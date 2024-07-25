from django.db import connection
from django.http import JsonResponse
from django.views import View
from datetime import datetime
from ..log.log import Logger
import json


class GetIllInfo(View):
    now = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'{request_ip}访问了{request_path}接口，时间为{self.now}，请求方式为{request.method}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + '非法访问，请求数据为' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法访问'}, status=405)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            sql = 'select * from illustration_work where Illustration_id=%s'
            work_id = data.get('work_id')
            with connection.cursor() as cursor:
                cursor.execute(sql, (work_id,))
                result = cursor.fetchall()
                if not result:
                    self.logger.info(self.request_path(request) + '获取失败，请求数据为：' + str(request.body))
                    return JsonResponse({'status': 'error', 'message': '获取失败'}, status=404)
                columns = [desc[0] for desc in cursor.description]
                rows = [dict(zip(columns, row)) for row in result]
                self.logger.info(self.request_path(request) + '获取成功，请求数据为：' + str(request.body))
            return JsonResponse({'status': 'success', 'message': '获取成功', 'data': rows}, status=200)
        except json.JSONDecodeError as e:
            print(e)
            self.logger.error(self.request_path(request) + str(e) + '请求数据为：' + str(request.body))
            return JsonResponse({'status': 'error', 'message': '请求数据格式错误'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + str(e) + '请求数据为：' + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)
