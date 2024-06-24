from django.http import JsonResponse
from django.views import View
from django.db import connection


class GetAllUserInfo(View):
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
                print(rows)
            if rows:
                return JsonResponse({'status': 'success', 'data': rows})
            else:
                return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=404)
        except Exception as e:
            print(e)
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)

    def post(self, request, *args, **kwargs):
        try:
            with connection.cursor() as cursor:
                data = request.POST
                user_id = data.get('id')
                if user_id:
                    user_id = int(user_id)
                else:
                    user_id = 1
                sql = 'SELECT * FROM users WHERE id = %s'
                cursor.execute(sql, [user_id])
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]
                print(rows)
            if rows:
                return JsonResponse({'status': 'success', 'data': rows})
            else:
                return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=404)
        except Exception as e:
            print(e)
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)
