import json

from django.views import View
from django.http import JsonResponse
from django.db import connection

from ..log.log import Logger


class Login(View):
    log = Logger()

    def get(self, request, *args, **kwargs):
        return JsonResponse({'status': 'success', 'message': 'ok'})

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            username = data['username']
            password = data['password']
            with connection.cursor() as cursor:
                sql = "SELECT * FROM users WHERE (username=%s OR userid=%s OR email=%s OR phone=%s) AND password=%s"
                cursor.execute(sql, (username, username, username, username, password))
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]
                # 删除password列
                for row in rows:
                    del row['password']
                print(rows)
            if rows:
                self.log.info(rows)
                return JsonResponse({'status': 'success', 'data': rows})
            else:
                self.log.warning(data)
                return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=404)
        except Exception as e:
            print(e)
            self.log.error(e)
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)
