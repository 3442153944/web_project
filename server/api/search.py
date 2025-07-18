from datetime import datetime
from base_api import BaseApi
from django.http import JsonResponse


class Search(BaseApi):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            data = self.format_request(request)
            search_key = data.get('search_key')
            limit = int(data.get('limit', 10))
            offset = int(data.get('offset', 0))

            if not search_key:
                return JsonResponse({'code': 400, 'msg': '参数错误'}, status=400)

            if self.is_login(request):
                self.record_search_his(request.user.id, search_key)

            target_key = f'%{search_key}%'

            # 通用查询结构
            repose = {
                'illustration': self.query_work(
                    table='illustration_work',
                    join_user_field='belong_to_user_id',
                    search_fields=['users.username', 'work_tags', 'illustration_work.name'],
                    limit=limit, offset=offset, target_key=target_key
                ),
                'comic': self.query_work(
                    table='comic',
                    join_user_field='belong_to_userid',
                    search_fields=['users.username', 'work_name', 'work_tags'],
                    limit=limit, offset=offset, target_key=target_key
                ),
                'novel': self.query_work(
                    table='novel_work',
                    join_user_field='belong_to_userid',
                    search_fields=['users.username', 'work_name', 'work_tags'],
                    limit=limit, offset=offset, target_key=target_key
                )
            }

            return JsonResponse({'code': 200, 'msg': 'success', 'data': repose}, status=200)

        except Exception as e:
            print(e)
            self.execute_sql(e, request)
            return JsonResponse({'code': 500, 'msg': '服务器错误'}, status=500)

    def query_work(self, table, join_user_field, search_fields, limit, offset, target_key):
        """通用作品查询函数"""
        # 构造 WHERE 条件
        like_conditions = " OR ".join(f"{field} LIKE %s" for field in search_fields)
        like_values = [target_key] * len(search_fields)

        # 查询总数
        count_sql = f'''
            SELECT COUNT(*) as count
            FROM admin.{table}
            LEFT JOIN admin.users ON users.userid = {join_user_field}
            WHERE {like_conditions}
        '''
        count_result = self.execute_sql(count_sql, like_values)
        count = count_result[0].get('count', 0) if count_result else 0

        # 查询列表
        data_sql = f'''
            SELECT {table}.*, users.username, users.userid, users.user_avatar
            FROM admin.{table}
            LEFT JOIN admin.users ON users.userid = {join_user_field}
            WHERE {like_conditions}
            LIMIT %s OFFSET %s
        '''
        list_result = self.execute_sql(data_sql, like_values + [limit, offset])

        return {'count': count, 'list': list_result}

    def record_search_his(self, user_id, search_key):
        try:
            sql = '''SELECT 1 FROM admin.search_his WHERE user_id=%s AND search_key=%s'''
            res = self.execute_sql(sql, (user_id, search_key))
            if not res:
                now = datetime.now()
                record_sql = '''INSERT INTO admin.search_his (search_key, user_id, date) VALUES (%s, %s, %s)'''
                self.execute_sql(record_sql, (search_key, user_id, now), True)
        except Exception as e:
            print('记录搜索历史错误', e)
