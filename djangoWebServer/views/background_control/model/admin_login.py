from django.http import JsonResponse
from django.views import View
from datetime import datetime
from .log.log import Logger
import json
from .authentication import Authentication
from django.shortcuts import render

class AdminLogin(View):
    logger = Logger()
    authentication = Authentication()

    def _request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '未知')
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        return f'{request_ip} 在 {now} 访问了 {request_path}'

    def get(self, request):
        self.logger.warning(f"{self._request_path(request)} 非法 GET 请求，请求数据为：{request.GET}")
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = data.get('userid')
            password = data.get('password')

            # 从请求头获取 Authorization 头部
            auth_header = request.headers.get('Authorization')
            token = None
            if auth_header and auth_header.startswith("Bearer "):
                try:
                    parts = auth_header.split(" ")
                    if len(parts) == 2 and parts[1] not in [None, 'null', '']:
                        token = parts[1]
                        print('\ntoken:', token)
                except Exception as e:
                    print('\n解析token错误',e)

            if not token and not (userid and password):
                self.logger.warning(f"{self._request_path(request)} 缺少 token 或 userid 和 password")
                return JsonResponse({'status': 'error', 'message': '参数错误'}, status=400)

            response = json.loads(self.authentication.authenticate_user(token=token, userid=userid, password=password))
            return JsonResponse(response,status=response.get('status_code') if response.get('status_code') else 404)

        except json.JSONDecodeError as e:
            self.logger.error(f"{self._request_path(request)} 请求数据解析失败，数据为：{request.body.decode('utf-8')}")
            return JsonResponse({'status': 'error', 'message': '请求数据解析失败'}, status=400)
        except Exception as e:
            print('\nadmin_login类错误',e)
            self.logger.error(f"{self._request_path(request)} 请求数据为：{request.body.decode('utf-8')}，错误信息为：{e}")
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
