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
        """生成请求路径的日志信息"""
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '未知')
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        return f'{request_ip} 在 {now} 访问了 {request_path}'

    def get(self, request):
        """处理 GET 请求，返回 404 错误页面"""
        self.logger.warning(f"{self._request_path(request)} 非法 GET 请求，请求数据为：{request.GET}")
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        """处理 POST 请求，进行用户登录认证"""
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token', None)
            userid = data.get('userid', None)
            password = data.get('password', None)
            auth_token = request.COOKIES.get('auth_token', None)

            if not token and (not userid or not password) and not auth_token:
                self.logger.warning(f"{self._request_path(request)} 缺少 token 或 userid 和 password")
                return JsonResponse({'status': 'error', 'message': '参数错误'}, status=400)

            # Set request for Authentication instance
            self.authentication.set_request(request)
            response = self.authentication.authenticate_user(token=auth_token, userid=userid, password=password)
            return response

        except json.JSONDecodeError as e:
            self.logger.error(f"{self._request_path(request)} 请求数据解析失败，数据为：{request.body.decode('utf-8')}")
            return JsonResponse({'status': 'error', 'message': '请求数据解析失败'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(f"{self._request_path(request)} 请求数据为：{request.body.decode('utf-8')}，错误信息为：{e}")
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
