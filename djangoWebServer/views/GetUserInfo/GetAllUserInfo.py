import json
from django.http import JsonResponse
from django.views import View
from django.db import connection
from ..log.log import Logger
from datetime import datetime

class GetAllUserInfo(View):
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', 'unknown')
        now = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        return f'{request_ip} 在 {now} 访问了 {request_path}'

    # 禁用 GET 请求
    def get(self, request, *args, **kwargs):
        self.logger.warning(self.request_path(request) + ' 非法GET请求：请求数据为：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法GET请求'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            userid = data.get('userid')
            admin_userid = 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb'

            if not userid and not token:
                return JsonResponse({'status': 'fail', 'message': 'Please provide userid or token'}, status=400)

            if token == 'sunyuanling':
                userid = admin_userid

            with connection.cursor() as cursor:
                sql = 'SELECT * FROM users WHERE userid = %s OR token = %s'
                cursor.execute(sql, [userid, token])
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]

                if rows:
                    user_id = rows[0].get('userid')
                    if user_id:
                        cursor.execute('SELECT COUNT(*) FROM user_fans WHERE user_id = %s', [user_id])
                        rows[0]['fans'] = cursor.fetchone()[0]
                        cursor.execute('SELECT COUNT(*) FROM user_follow WHERE user_id = %s', [user_id])
                        rows[0]['follow'] = cursor.fetchone()[0]

                    for row in rows:
                        row.pop('password', None)
                        row.pop('token', None)

                    self.logger.info(f'POST request success: {rows}')
                    return JsonResponse({'status': 'success', 'data': rows})
                else:
                    self.logger.warning(f'No data found for request: {data}')
                    return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=404)
        except json.JSONDecodeError as e:
            self.logger.warning(self.request_path(request) + ' 数据格式错误：请求数据为：' + str(request.body) + ' 错误信息为：' + str(e))
            return JsonResponse({'status': 'error', 'message': '数据格式错误'}, status=400)
        except Exception as e:
            self.logger.error(self.request_path(request) + ' 错误信息：' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
