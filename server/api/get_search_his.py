from base_api import BaseApi
from django.http import JsonResponse


class GetSearchHis(BaseApi):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            if not self.is_login(request):
                return JsonResponse({'code': 401, 'msg': '未登录'}, status=401)

            user_id = request.user.id
            sql = '''
                SELECT id, search_key, user_id, date
                FROM admin.search_his
                WHERE user_id = %s
                ORDER BY date DESC
                LIMIT 10
            '''
            res = self.execute_sql(sql, (user_id,))

            return JsonResponse({'code': 200, 'msg': 'success', 'data': res}, status=200)

        except Exception as e:
            print("获取搜索历史失败：", e)
            self.error_log(e,request)
            return JsonResponse({'code': 500, 'msg': '服务器错误'}, status=500)
