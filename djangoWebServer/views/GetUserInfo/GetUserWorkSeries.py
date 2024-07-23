from django.db import connection
from django.http import JsonResponse
from django.views import View
from datetime import datetime
import json
from ..log.log import Logger


class GetUserWorkSeries(View):
    now = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'{request_ip}访问了{request_path}接口,访问时间为{self.now}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + '非法GET访问' + '请求内容' + str(request.GET))
        return JsonResponse({'status': 'success', 'message': '非法GET请求'}, status=405)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            userid = ''
            if not token:
                self.logger.warning(self.request_path(request) + '缺少token' + '请求内容' + str(request.body))
                return JsonResponse({'status': 'error', 'message': '缺少token'}, status=400)
            with connection.cursor() as cursor:
                cursor.execute('select userid from users where token=%s', token)
                if cursor.rowcount > 0:
                    userid = cursor.fetchone()[0]
                else:
                    self.logger.warning(self.request_path(request) + 'token无效' + '请求内容' + str(request.body))
                    return JsonResponse({'status': 'error', 'message': 'token无效'}, status=401)
            with connection.cursor() as cursor:
                cursor.execute('select * from novel_work where belong_to_userid=%s', userid)
                result = cursor.fetchall()
                columns = [desc[0] for desc in cursor.description]
                rows = [dict(zip(columns, row)) for row in result]
                if not rows:
                    return JsonResponse({'status': 'success', 'message': '没有作品', 'data': []}, status=200)
                else:
                    self.logger.info(self.request_path(request) + '请求成功，请求内容' + str(request.body))
                    return JsonResponse({'status': 'success', 'message': '获取成功', 'data': rows}, status=200)


        except json.JSONDecodeError as e:
            print(e)
            self.logger.error(self.request_path(request) + '错误信息' + str(e) + '请求内容' + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + '错误信息' + str(e) + '请求内容' + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
