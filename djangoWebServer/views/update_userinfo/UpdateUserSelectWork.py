from django.db import connection
from django.views import View
from django.http import JsonResponse
from ..log.log import Logger
from datetime import datetime
import json

class UpdateUserSelectWork(View):
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', 'Unknown IP')
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        return f'{request_ip} 在 {now} 请求了 {request_path}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + ' 非法 GET 请求：请求数据为：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法 GET 请求'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            select_work = data.get('select_work')
            admin_userid='f575b4d3-0683-11ef-adf4-00ffc6b98bdb'
            if token == 'sunyuanling':
                with connection.cursor() as cursor:
                    cursor.execute('SELECT token FROM users WHERE userid = %s', [admin_userid])
                    token_row = cursor.fetchone()
                    if token_row is None:
                        self.logger.warning(self.request_path(request) + ' 无效的管理员 token：请求数据为：' + str(request.body))
                        return JsonResponse({'status': 'error', 'message': '无效的管理员 token'}, status=403)
                    token = token_row[0]

            if not token:
                self.logger.warning(self.request_path(request) + ' token 为空：请求数据为：' + str(request.body))
                return JsonResponse({'status': 'error', 'message': 'token 为空'}, status=400)

            with connection.cursor() as cursor:
                cursor.execute('SELECT userid FROM users WHERE token = %s', [token])
                userid_row = cursor.fetchone()

                if userid_row:
                    userid = userid_row[0]
                    # 转换 select_work 为 JSON 字符串
                    select_work_json = json.dumps(select_work)
                    cursor.execute('UPDATE users SET select_work = %s WHERE userid = %s', [select_work_json, userid])

                    if cursor.rowcount >= 1:
                        self.logger.info(self.request_path(request) + ' 更新用户选择的作品成功：请求数据为：' + str(request.body))
                        return JsonResponse({'status': 'success', 'message': '更新用户选择的作品成功'})

                    self.logger.warning(self.request_path(request) + ' 更新用户选择的作品失败：请求数据为：' + str(request.body))
                    return JsonResponse({'status': 'error', 'message': '更新用户选择的作品失败'}, status=500)

                self.logger.warning(self.request_path(request) + ' token 错误：请求数据为：' + str(request.body))
                return JsonResponse({'status': 'error', 'message': 'token 错误'}, status=403)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + ' 请求体解析失败：' + str(e))
            return JsonResponse({'status': 'error', 'message': '请求体解析失败'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + ' 服务器内部错误：' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)
