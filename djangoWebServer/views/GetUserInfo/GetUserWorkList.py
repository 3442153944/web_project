from django.db import connection
from django.views import View
from django.http import JsonResponse
import json
from ..log.log import Logger
from datetime import datetime


class GetUserWorkList(View):
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '未知 IP')
        now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        return f'请求IP：{request_ip}，请求地址： {request_path}，时间： {now}；'

    def get(self, request):
        self.logger.warning(str(self.request_path(request)) + '请求方式：GET，非法访问' + '请求信息：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': 'Method not allowed'}, status=405)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = data.get('userid')
            token = data.get('token')
            admin_userid = 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb'

            if not userid and not token:
                raise ValueError("用户ID缺失和token缺失")

            sql_query_dict = {
                'ill': 'SELECT *, "ill" AS type FROM illustration_work WHERE belong_to_user_id=%s ORDER BY create_time DESC',
                'comic': 'SELECT *, "comic" AS type FROM comic WHERE belong_to_userid=%s ORDER BY create_time DESC',
                'novel': 'SELECT *, "novel" AS type FROM novel_work WHERE belong_to_userid=%s ORDER BY work_create_time DESC'
            }

            work_list = {}
            with connection.cursor() as cursor:
                if token == 'sunyuanling':
                    # 特殊管理员 token 处理
                    cursor.execute('SELECT token FROM users WHERE userid=%s', [admin_userid])
                    token_row = cursor.fetchone()
                    if token_row:
                        token = token_row[0]
                else:
                    # 普通用户
                    cursor.execute('SELECT token FROM users WHERE userid=%s', [userid])
                    token_row = cursor.fetchone()
                    if token_row:
                        token = token_row[0]

                if not token:
                    # 如果 token 为空，使用 userid
                    userid_query = userid
                else:
                    cursor.execute('SELECT userid FROM users WHERE token=%s', [token])
                    result = cursor.fetchone()
                    if result:
                        userid_query = result[0]
                    else:
                        raise ValueError("无效的token")

                for work_type, query in sql_query_dict.items():
                    cursor.execute(query, [userid_query])
                    columns = [desc[0] for desc in cursor.description]
                    result = cursor.fetchall()
                    rows = [dict(zip(columns, row)) for row in result]
                    work_list[work_type] = rows

            self.logger.info(
                str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + '请求成功')
            return JsonResponse({'status': 'success', 'data': work_list})

        except json.JSONDecodeError as e:
            self.logger.error(str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(
                request.body) + ' JSON 解码错误: ' + str(e))
            return JsonResponse({'status': 'error', 'message': '请求数据格式错误'}, status=400)

        except ValueError as e:
            self.logger.error(
                str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + ' 参数错误: ' + str(
                    e))
            return JsonResponse({'status': 'error', 'message': str(e)}, status=400)

        except Exception as e:
            self.logger.error(
                str(self.request_path(request)) + '请求方式：POST，请求信息：' + str(request.body) + ' 服务器错误: ' + str(
                    e))
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)
