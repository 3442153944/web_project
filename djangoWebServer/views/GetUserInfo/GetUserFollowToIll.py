import json
from django.db import connection
from django.views import View
from django.http import JsonResponse
from ..log.log import Logger


class GetUserFollowToIll(View):
    logger = Logger()

    def get(self, request, *args, **kwargs):
        return JsonResponse({'status': 'success', 'message': 'ok'})

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = data['userid']

            with connection.cursor() as cursor:
                # 获取关注列表
                sql = 'SELECT follow_user_id FROM user_follow WHERE user_id=%s'
                cursor.execute(sql, [userid])
                follow_user_ids = [row[0] for row in cursor.fetchall()]

                if not follow_user_ids:
                    self.logger.warning(data)
                    return JsonResponse({'status': 'failure', 'message': 'No data found'}, status=400)

                # 获取插画信息并按照时间排序
                sql = ('SELECT * FROM illustration_work WHERE belong_to_user_id IN %s '
                       'ORDER BY create_time DESC')
                cursor.execute(sql, [tuple(follow_user_ids)])
                columns = [desc[0] for desc in cursor.description]
                ill_result = cursor.fetchall()
                ill_list = [dict(zip(columns, row)) for row in ill_result]

                self.logger.info(ill_list)
                print(ill_list)
                #获取作品列表
                return JsonResponse({'status': 'success', 'data': ill_list})

        except Exception as e:
            self.logger.error(e)
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)
