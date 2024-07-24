from django.db import connection
from django.http import JsonResponse
from django.views import View
import json
from ..log.log import Logger


class GetUserFollow(View):
    logger = Logger()

    def get(self, request, *args, **kwargs):
        return JsonResponse({'status': 'success', 'message': 'ok'})

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = data['userid']
            with connection.cursor() as cursor:
                sql = 'select * from user_follow where user_id=%s'
                cursor.execute(sql, [userid])
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                rows = [dict(zip(columns, row)) for row in result]
            if rows:
                self.logger.info(rows)
                return JsonResponse({'status': 'success', 'data': rows})
            else:
                self.logger.warning(data)
                return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(e)
            return JsonResponse({'status': 'fail', 'message': 'error'}, status=500)
