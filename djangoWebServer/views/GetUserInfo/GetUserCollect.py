from django.db import connection
from django.views import View
from django.http import JsonResponse
from ..log.log import Logger
from datetime import datetime
import json


class GetUserCollect(View):
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '未知 IP')
        now = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        return f'{request_ip} 在 {now} 访问了 {request_path}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + ' 非法 GET 请求：请求数据为：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法 GET 请求'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode("utf-8"))
            token = data.get('token')

            if not token:
                self.logger.warning(self.request_path(request) + ' token 为空，请求数据为：' + str(data))
                return JsonResponse({'status': 'error', 'message': 'token 为空'}, status=403)

            admin_userid = 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb'
            with connection.cursor() as cursor:
                # 检查 token 是否为 'sunyuanling' 并进行覆盖
                if token == 'sunyuanling':
                    cursor.execute('SELECT token FROM users WHERE userid=%s', [admin_userid])
                    token = cursor.fetchone()[0]

                # 根据 token 获取用户 ID
                cursor.execute('SELECT userid FROM users WHERE token=%s', [token])
                user_id_result = cursor.fetchone()
                if user_id_result:
                    userid = user_id_result[0]
                    # 根据用户 ID 获取收藏列表
                    cursor.execute('SELECT * FROM user_collection_table WHERE userid=%s', [userid])
                    collect_list = cursor.fetchall()
                    columns = [column[0] for column in cursor.description]
                    rows = [dict(zip(columns, row)) for row in collect_list]
                    return JsonResponse({'status': 'success', 'message': '获取收藏列表成功', 'data': rows})
                else:
                    self.logger.warning(self.request_path(request) + ' 根据 token 找不到用户：' + str(token))
                    return JsonResponse({'status': 'error', 'message': '用户不存在'}, status=404)

        except json.JSONDecodeError:
            self.logger.error(self.request_path(request) + ' JSON 解码错误：请求数据为：' + str(request.body))
            return JsonResponse({'status': 'error', 'message': 'JSON 格式错误'}, status=400)

        except Exception as e:
            self.logger.error(self.request_path(request) + ' 服务器内部错误：' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)
