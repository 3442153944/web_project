import json
from django.http import JsonResponse
from django.views import View
from django.db import connection
from ..log.log import Logger
from datetime import datetime
from base_api import BaseApi


class GetAllUserInfo(BaseApi):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            user_info_sql = '''select * from admin.users where userid=%s'''
            fans_count_sql = '''SELECT COUNT(*) as total FROM user_fans WHERE user_id = %s'''
            follow_count_sql = '''SELECT COUNT(*) as total FROM user_follow WHERE user_id = %s'''
            if request.user.id:
                result = self.execute_sql(user_info_sql, [request.user.id])
                result = self.filter_info(result)
                if result:
                    result[0]['fans'] = self.execute_sql(fans_count_sql, [request.user.id])[0]['total']
                    result[0]['follow'] = self.execute_sql(follow_count_sql, [request.user.id])[0]['total']
                    return JsonResponse({'status': 'success', 'data': result}, status=200)
                else:
                    return JsonResponse({'status': 'error', 'message': '用户不存在'}, status=404)
            else:
                data = self.format_request(request)
                user_id = data.get('userid', None)
                if not user_id:
                    return JsonResponse({'status': 'error', 'message': '参数错误', 'code': 400, 'msg': '参数错误'},
                                        status=400)
                result = self.execute_sql(user_info_sql, [user_id])
                result = self.filter_info(result)
                if result:
                    result[0]['fans'] = self.execute_sql(fans_count_sql, [user_id])[0]['total']
                    result[0]['follow'] = self.execute_sql(follow_count_sql, [user_id])[0]['total']
                    return JsonResponse({'status': 'success', 'data': result}, status=200)
                else:
                    return JsonResponse({'status': 'error', 'message': '用户不存在'}, status=404)

        except Exception as e:
            print(e)
            self.error_log(e, request)
            return JsonResponse({'status': 'error', 'message': '服务器错误', 'code': 500, 'msg': '服务器错误'},
                                status=500)

    def filter_info(self, data):
        for i in data:
            i.pop('password')
            i.pop('token')
            i.pop('ip_address')
            i.pop('user_register')
            i.pop('last_login')
            i.pop('phone')
            i.pop('email')
        return data
