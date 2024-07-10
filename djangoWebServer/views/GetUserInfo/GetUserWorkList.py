from django.db import connection
from django.views import View
from django.http import JsonResponse
import json
from ..log.log import Logger
from datetime import datetime


class GetUserWorkList(View):
    logger = Logger()
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'请求IP：{request_ip}，请求地址： {request_path}，时间： {self.now}；'

    def get(self, request):
        self.logger.warning(str(self.request_path(request)) + '请求方式：GET，非法访问' + '请求信息：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': 'Method not allowed'}, status=405)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = data.get('userid')
            if not userid:
                raise ValueError("用户ID缺失")

            sql_query_dict = {
                'ill': 'SELECT *, "ill" AS type FROM illustration_work WHERE belong_to_user_id=%s ORDER BY create_time DESC',
                'comic': 'SELECT *, "comic" AS type FROM comic WHERE belong_to_userid=%s ORDER BY create_time DESC',
                'novel': 'SELECT *, "novel" AS type FROM novel_work WHERE belong_to_userid=%s ORDER BY work_create_time DESC'
            }

            work_list = {}
            with connection.cursor() as cursor:
                for work_type, query in sql_query_dict.items():
                    cursor.execute(query, [userid])
                    columns = [desc[0] for desc in cursor.description]
                    result = cursor.fetchall()
                    rows = [dict(zip(columns, row)) for row in result]
                    work_list[work_type] = rows

            self.logger.info(str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + '请求成功')
            return JsonResponse({'status': 'success', 'data': work_list})

        except json.JSONDecodeError as e:
            self.logger.error(str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + ' JSON 解码错误: ' + str(e))
            return JsonResponse({'status': 'error', 'message': '请求数据格式错误'}, status=400)

        except ValueError as e:
            self.logger.error(str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + ' 参数错误: ' + str(e))
            return JsonResponse({'status': 'error', 'message': str(e)}, status=400)

        except Exception as e:
            self.logger.error(str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + ' 服务器错误: ' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
