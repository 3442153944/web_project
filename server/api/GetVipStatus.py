from base_api import BaseApi
from django.http import JsonResponse
from datetime import datetime


class GetVipStatus(BaseApi):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            is_login = self.check_user(request)
            if is_login:
                return is_login
            user_id = request.user.id
            sql = 'select vip_last_date from users where userid=%s and account_status=1'
            res = self.execute_sql(sql, [user_id])[0]
            now = datetime.now()
            if res.get('vip_last_date') and now < res.get('vip_last_date'):
                return JsonResponse({
                    'code': 200,
                    'msg': 'vip正常',
                    'status': 1
                }, status=200)
            return JsonResponse({
                'code': 200,
                'msg': 'vip已过期',
                'status': 0
            }, status=200)
        except Exception as e:
            self.error_log(str(e), request)
            print(e)
            return JsonResponse({
                'code': 500,
                'msg': '服务器错误'
            }, status=500)
