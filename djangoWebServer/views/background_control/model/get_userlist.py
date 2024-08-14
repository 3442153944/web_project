from django.db import connection
from django.http import JsonResponse
from django.views import View
from django.shortcuts import render
from .log.log import Logger
from datetime import datetime
import json
from .authentication import Authentication


class GetUserList(View):
    logger = Logger()

    def _request_path(self, request):
        request_path = request.get_full_path()
        request_ip = request.META['REMOTE_ADDR']
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        return f'{request_ip}在{now}请求了{request_path}'

    def get(self, request):
        self.logger.warning(self._request_path(request) + '非法GET请求，请求数据为：' + str(request.GET))
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            authentication = Authentication()
            authentication.set_request(request)
            data = json.loads(request.body.decode('utf-8'))
            auth_token = request.COOKIES.get('auth_token')
            print(auth_token)
            authentication.authenticate_user(token=auth_token)
            auth_data = request.session.get('auth_response_data',None)
            print('服务器数据',auth_data)
            if auth_data.get('is_login') == 1 and auth_data:
                sql = '''select * from users'''
                cursor = connection.cursor()
                cursor.execute(sql)
                columns = [col[0] for col in cursor.description]
                rows = [dict(zip(columns, row)) for row in cursor.fetchall()]
                authentication.app_end_msg(data={'user_list': rows})
                return_data=authentication.authenticate_user(token=auth_token)
                auth_data = request.session.get('auth_response_data', None)
                print(auth_data)
                return return_data
            else:
                return_data = authentication.authenticate_user(token=auth_token)
                return JsonResponse({'status':'error','message':'用户未登录！'})
        except Exception as e:
            print(e)
            self.logger.error(f'{self._request_path(request)}请求失败，错误信息为：{str(e)}')
            return_data =JsonResponse({'status':'error','message':'服务器错误！'})
            return return_data
