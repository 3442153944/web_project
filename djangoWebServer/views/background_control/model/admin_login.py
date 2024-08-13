from django.db import connection
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
            token = data.get('token')
            userid = data.get('userid')
            password = data.get('password')

            if not token or (not userid and not password):
                self.logger.warning(f"{self._request_path(request)} 缺少 token 或 userid 和 password")
                return JsonResponse({'status': 'error', 'message': '参数错误'}, status=400)

            new_token = self.authentication.authenticate_user(token=token, userid=userid, password=password)
            if new_token:
                self.logger.info(f"{self._request_path(request)} 登录成功，返回 token 为：{new_token}")
                return JsonResponse({'status': 'success', 'token': new_token})
            else:
                self.logger.warning(f"{self._request_path(request)} 登录失败，返回 token 为：{new_token}")
                return JsonResponse({'status': 'error', 'message': '用户名或密码错误或者权限不足，token 失效，请联系管理员'}, status=401)

        except json.JSONDecodeError:
            self.logger.error(f"{self._request_path(request)} 请求数据解析失败，数据为：{request.body.decode('utf-8')}")
            return JsonResponse({'status': 'error', 'message': '请求数据解析失败'}, status=400)
        except Exception as e:
            self.logger.error(f"{self._request_path(request)} 请求数据为：{request.body.decode('utf-8')}，错误信息为：{e}")
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
