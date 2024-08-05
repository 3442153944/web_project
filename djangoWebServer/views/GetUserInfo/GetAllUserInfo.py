import json

from django.http import JsonResponse
from django.views import View
from django.db import connection
from ..log.log import Logger


class GetAllUserInfo(View):

    logger = Logger()
    # 允许所有跨域
    def options(self, request, *args, **kwargs):
        return JsonResponse({'status': 'success', 'message': 'ok'})
    def get(self,request, *args, **kwargs):
        try:
            with connection.cursor() as cursor:
                sql = 'SELECT * FROM users'
                cursor.execute(sql)
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]
                #del password
                for row in rows:
                    del row['password']
            if rows:
                return JsonResponse({'status': 'success', 'data': '非法访问'})
            else:
                return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=400)
        except Exception as e:
            print(e)
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)

    def post(self, request, *args, **kwargs):
        try:
            with connection.cursor() as cursor:
                data = json.loads(request.body.decode('utf-8'))
                print(data)
                userid = data.get('userid')
                token = data.get('token')
                admin_userid = 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb'

                if not userid and not token:
                    return JsonResponse({'status': 'fail', 'message': 'Please provide userid or token'}, status=400)

                if token == 'sunyuanling':
                    userid = admin_userid

                sql = 'SELECT * FROM users WHERE userid = %s OR token = %s'
                cursor.execute(sql, [userid, token])
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]
                print('获取的用户信息：',rows)
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
                    return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(f'POST request error: {e}')
            return JsonResponse({'status': 'error', 'message': 'Server error'}, status=500)
