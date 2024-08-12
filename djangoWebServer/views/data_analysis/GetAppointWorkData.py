from django.db import connection
from django.http import JsonResponse
from django.views import View
from ..log.log import Logger
from datetime import datetime, timedelta
import json
from django.shortcuts import render


class GetAppointWorkData(View):
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '未知 IP')
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        return f'{request_ip} 在 {now} 访问了 {request_path}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + ' 非法 GET 请求：请求数据为：' + str(request.GET))
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            ago_days = int(data.get('ago_date', 7))  # 默认值为 7
            work_id = data.get('work_id')
            work_type = data.get('work_type')
            print(data)

            if not token:
                self.logger.warning(self.request_path(request) + ' token 为空')
                return JsonResponse({'status': 'error', 'message': 'token 为空'}, status=401)

            target_date = (datetime.now() - timedelta(days=ago_days)).strftime('%Y-%m-%dT%H:%M:%S')
            history_date = datetime(1900, 1, 1).strftime('%Y-%m-%dT%H:%M:%S')

            with connection.cursor() as cursor:
                # 验证管理员 token
                if token == 'sunyuanling':
                    cursor.execute('SELECT token FROM users WHERE userid=%s', ['f575b4d3-0683-11ef-adf4-00ffc6b98bdb'])
                    admin_token = cursor.fetchone()
                    if admin_token:
                        token = admin_token[0]
                    else:
                        return JsonResponse({'status': 'error', 'message': '管理员信息不存在'}, status=401)

                # 获取用户 ID
                cursor.execute('SELECT userid FROM users WHERE token=%s', [token])
                user_id_row = cursor.fetchone()
                if not user_id_row:
                    return JsonResponse({'status': 'error', 'message': '用户信息不存在'}, status=401)

                user_id = user_id_row[0]

                # 定义 SQL 查询
                get_appoint_work_data_sql_dict = {
                    'watch': '''
                        SELECT COUNT(*) FROM user_watch_table WHERE workid=%s AND type=%s AND time > %s AND time < %s
                    ''',
                    'like': '''
                        SELECT COUNT(*) FROM user_like_table WHERE workid=%s AND type=%s AND time > %s AND time < %s
                    ''',
                    'collect': '''
                        SELECT COUNT(*) FROM user_collection_table WHERE workid=%s AND type=%s AND time > %s AND time < %s
                    '''
                }

                target_work_data_dict = {
                    'watch': 0,
                    'like': 0,
                    'collect': 0
                }

                history_work_data_dict = {
                    'watch': 0,
                    'like': 0,
                    'collect': 0
                }

                for key in target_work_data_dict:
                    cursor.execute(get_appoint_work_data_sql_dict[key], [work_id, work_type, target_date, now])
                    target_work_data_dict[key] = cursor.fetchone()[0]
                    cursor.execute(get_appoint_work_data_sql_dict[key], [work_id, work_type, history_date, target_date])
                    history_work_data_dict[key] = cursor.fetchone()[0]

                # 计算分析数据（示例）
                total_target = sum(target_work_data_dict.values())
                total_history = sum(history_work_data_dict.values())

                return JsonResponse({
                    'status': 'success',
                    'data': {
                        'target_work_data': target_work_data_dict,
                        'history_work_data': history_work_data_dict,
                        'total_target': total_target,
                        'total_history': total_history
                    }
                }, status=200)

        except ValueError as e:
            print(e)
            self.logger.error(self.request_path(request) + ' 参数格式错误：' + str(e))
            return JsonResponse({'status': 'error', 'message': '参数格式错误'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + ' 服务器内部错误：' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)
