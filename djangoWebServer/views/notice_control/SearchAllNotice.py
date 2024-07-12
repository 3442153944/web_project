from django.db import connection
from django.http import JsonResponse
from django.views import View
from ..log.log import Logger
from datetime import datetime
import json

class SearchAllNotice(View):
    logger = Logger()

    def get_request_info(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        return f'{request_ip}在{now}访问了{request_path}页面'

    def get(self, request):
        self.logger.warning(f'{self.get_request_info(request)} - 非法访问：访问内容为GET {str(request.GET)}')
        return JsonResponse({'status': 'failed', 'message': '非法访问'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = data.get('userid')

            if not userid:
                self.logger.warning(f'{self.get_request_info(request)} - 访问失败：缺少参数userid {str(request.body)}')
                return JsonResponse({'status': 'failed', 'message': '缺少参数userid'}, status=400)

            if userid != 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb':
                self.logger.warning(f'{self.get_request_info(request)} - 访问失败：权限不足 {str(request.body)}')
                return JsonResponse({'status': 'failed', 'message': '权限不足'}, status=403)

            with connection.cursor() as cursor:
                sql = 'SELECT * FROM notice'
                cursor.execute(sql)
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]

            return JsonResponse({'status': 'success', 'data': rows}, status=200)

        except json.JSONDecodeError as e:
            self.logger.error(f'{self.get_request_info(request)} - 访问失败：JSONDecodeError {str(e)}')
            return JsonResponse({'status': 'failed', 'message': '请求数据格式错误'}, status=400)
        except Exception as e:
            self.logger.error(f'{self.get_request_info(request)} - 访问失败：Exception {str(e)}')
            return JsonResponse({'status': 'failed', 'message': '服务器内部错误'}, status=500)
