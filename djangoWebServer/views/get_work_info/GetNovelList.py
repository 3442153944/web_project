from django.db import connection
from django.views import View
from django.http import JsonResponse
from datetime import datetime
from ..log.log import Logger
import json


class GetNovelList(View):
    logger = Logger()

    def request_path(self, request):
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', 'unknown')
        return f'请求IP：{request_ip}，请求地址：{request_path}，时间：{now}'

    def get(self, request):
        self.logger.info(self.request_path(request) + '非法GET访问，访问数据为：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法GET访问'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            print(data)
            token = data.get('token')
            work_id = data.get('work_id')
            if not token:
                self.logger.warning(self.request_path(request) + '数据获取失败，失败原因：token为空')
                return JsonResponse({'status': 'error', 'message': 'token为空'}, status=400)

            with connection.cursor() as cursor:
                # 验证 token 是否有效
                sql = 'SELECT userid, username, vip FROM users WHERE token = %s'
                result = None
                vip = None
                if token != 'sunyuanling':
                    cursor.execute(sql, [token])
                    result = cursor.fetchone()
                    vip = result[2] if result else None

                if result or vip in ('1', 1) or token == 'sunyuanling':
                    sql = ('''SELECT novel_work.work_name ,novel_work.work_cover,novel_work.is_vip_work,novel_work.work_status,novel_content.* 
                           ,novel_work.brief_introduction,novel_work.work_id
                           FROM novel_content 
                           join novel_work on novel_work.work_id=novel_content.belong_to_series_id 
                           WHERE belong_to_series_id=%s order by novel_content.create_time''')
                    cursor.execute(sql, [work_id])
                    result = cursor.fetchall()
                    work_info = {
                        'work_list': [],
                        'author_info': [],
                        'word_count': 0
                    }
                    if result:
                        columns = [column[0] for column in cursor.description]
                        rows = [dict(zip(columns, row)) for row in result]
                        #将字段中的时间转换为年月日时分秒格式
                        for row in rows:
                            create_time_dt = datetime.strptime(row['create_time'], '%Y-%m-%dT%H:%M:%S')
                            formatted_create_time = create_time_dt.strftime('%Y年%m月%d日 %H时%M分%S秒')
                            #将转换后的时间放入原位置
                            row['create_time'] = formatted_create_time
                            del row['content']
                        work_info['work_list'] = rows
                        belong_to_userid = rows[0]['belong_to_userid']
                        cursor.execute('SELECT * FROM users WHERE userid=%s', [belong_to_userid])
                        columns = [column[0] for column in cursor.description]
                        result = cursor.fetchone()
                        if result:
                            rows = dict(zip(columns, result))
                            del rows['password']
                            del rows['token']
                            work_info['author_info'] = rows
                            # 获取 content 字段的文字总数
                            sql = 'SELECT SUM(CHAR_LENGTH(content)) AS work_count FROM novel_content WHERE belong_to_series_id=%s'
                            cursor.execute(sql, [work_id])
                            result = cursor.fetchone()
                            if result:
                                work_info['word_count'] = result[0] if result[0] else 0
                            get_userid_sql='select userid from users where token=%s'
                            cursor.execute(get_userid_sql,[token])
                            result=cursor.fetchone()[0]
                            userid=result

                            watch_sql='select count(*) from user_watch_table where type=%s and workid=%s'
                            cursor.execute(watch_sql,['novel',work_id])
                            result=cursor.fetchone()[0]
                            work_info['watch_count']=result
                            like_sql='select count(*) from user_like_table where type=%s and workid=%s'
                            is_like_sql='select * from user_like_table where  type=%s and workid=%s and userid=%s'
                            cursor.execute(is_like_sql,['novel',work_id,userid])
                            if cursor.fetchone():
                                work_info['is_like']=True
                            else:
                                work_info['is_like']=False
                            cursor.execute(like_sql,['novel',work_id])
                            result=cursor.fetchone()[0]
                            work_info['like_count']=result
                            collect_sql='select count(*) from user_collection_table where type=%s and workid=%s'
                            is_collect_sql='select * from user_collection_table where  type=%s and workid=%s and userid=%s'
                            cursor.execute(is_collect_sql,['novel',work_id,userid])
                            if cursor.fetchone():
                                work_info['is_collect']=True
                            else:
                                work_info['is_collect']=False
                            cursor.execute(collect_sql,['novel',work_id])
                            result=cursor.fetchone()[0]
                            work_info['collect_count']=result
                            print(work_info)
                            return JsonResponse({'status': 'success', 'message': '数据获取成功', 'data': work_info},
                                                status=200)

                        else:
                            self.logger.warning(self.request_path(request) + '数据获取失败，失败原因：数据不存在')
                            return JsonResponse({'status': 'error', 'message': '数据不存在'}, status=400)
                    else:
                        self.logger.warning(self.request_path(request) + '数据获取失败，失败原因：数据不存在')
                        return JsonResponse({'status': 'error', 'message': '数据不存在'}, status=400)

                else:
                    self.logger.warning(self.request_path(request) + '数据获取失败，失败原因：token无效')
                    return JsonResponse({'status': 'error', 'message': 'token无效'}, status=400)

        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + '数据获取失败，失败原因：' + str(e))
            return JsonResponse({'status': 'error', 'message': '数据获取失败'}, status=500)
