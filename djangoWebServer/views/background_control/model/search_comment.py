from django.db import connection
from django.http import JsonResponse
from django.views import View
from django.shortcuts import render
import json
from datetime import datetime
from .log.log import Logger

class SearchComment(View):
    logger = Logger()

    def _request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '0.0.0.0')
        now = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        content = request.body.decode('utf-8')
        return f'{request_ip}在{now}请求了{request_path}, 请求内容为：{content}'

    def get(self, request):
        self.logger.warning(f'非法GET请求；{self._request_path(request)}')
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = str(getattr(request, 'userid', None))
            is_authenticated = getattr(request, 'is_authenticated', None)

            if not is_authenticated:
                self.logger.warning(f'未登录用户尝试访问：{self._request_path(request)}')
                return JsonResponse({'status': 'fail', 'message': '未登录'}, status=401)

            # 检查用户权限
            with connection.cursor() as cursor:
                cursor.execute('SELECT account_permissions FROM users WHERE userid=%s', [userid])
                account_permissions = cursor.fetchone()

                if not account_permissions or account_permissions[0] not in ['1', '2', 1, 2]:
                    self.logger.warning(f'用户权限不足：{self._request_path(request)}')
                    return JsonResponse({'status': 'fail', 'message': '权限不足'}, status=403)

                # 读取分页和查询条件
                limit = data.get('limit', 10)
                offset = data.get('offset', 0)
                comment_id = data.get('comment_id', '')
                work_id = data.get('work_id', '')
                work_type = data.get('work_type', '')
                send_userid = data.get('send_userid', '')
                main_userid = data.get('main_userid', '')

                # 处理查询精确度
                accuracy = data.get('accuracy_type', 'vague')
                if accuracy == 'accuracy':
                    comment_id = comment_id or None
                    work_id = work_id or None
                    work_type = work_type or None
                    send_userid = send_userid or None
                    main_userid = main_userid or None
                    sql = '''
                        SELECT comment.*, users.userid, users.username, users.user_avatar
                        FROM comment
                        LEFT JOIN users ON users.userid = comment.send_userid
                        WHERE (comment.comment_id = %s OR %s IS NULL)
                        AND (comment.work_id = %s OR %s IS NULL)
                        AND (comment.work_type = %s OR %s IS NULL)
                        AND (comment.send_userid = %s OR %s IS NULL)
                        AND (comment.main_userid = %s OR %s IS NULL)
                        ORDER BY date DESC
                        LIMIT %s OFFSET %s
                    '''
                    params = [comment_id, comment_id, work_id, work_id, work_type, work_type, send_userid, send_userid, main_userid, main_userid, limit, offset]
                else:  # 模糊查询
                    sql = '''
                        SELECT comment.*, users.userid, users.username, users.user_avatar
                        FROM comment
                        LEFT JOIN users ON users.userid = comment.send_userid
                        WHERE (comment.comment_id LIKE %s OR comment.work_id LIKE %s OR comment.work_type LIKE %s
                        OR comment.send_userid LIKE %s OR comment.main_userid LIKE %s)
                        ORDER BY date DESC
                        LIMIT %s OFFSET %s
                    '''
                    params = [f'%{comment_id}%', f'%{work_id}%', f'%{work_type}%', f'%{send_userid}%', f'%{main_userid}%', limit, offset]

                # 执行查询
                cursor.execute(sql, params)
                result = cursor.fetchall()
                columns = [column[0] for column in cursor.description]
                rows = [dict(zip(columns, row)) for row in result]

                if result:
                    count_sql = '''
                        SELECT COUNT(*) FROM comment
                        WHERE (comment.comment_id LIKE %s OR comment.work_id LIKE %s OR comment.work_type LIKE %s
                        OR comment.send_userid LIKE %s OR comment.main_userid LIKE %s)
                    '''
                    cursor.execute(count_sql, [f'%{comment_id}%', f'%{work_id}%', f'%{work_type}%', f'%{send_userid}%', f'%{main_userid}%'])
                    total = cursor.fetchone()[0]

                    return JsonResponse({
                        'status': 'success',
                        'message': '查询成功',
                        'data': {
                            'rows': rows,
                            'total': total
                        }
                    }, status=200)
                else:
                    return JsonResponse({
                        'status': 'success',
                        'message': '没有找到匹配的结果',
                        'data': {
                            'rows': [],
                            'total': 0
                        }
                    }, status=200)

        except json.JSONDecodeError:
            self.logger.error(f'请求数据格式错误：{self._request_path(request)}')
            return JsonResponse({'status': 'fail', 'message': '无效的JSON数据'}, status=400)

        except Exception as e:
            self.logger.error(f'服务器错误：{self._request_path(request)} - 错误详情：{str(e)}')
            return JsonResponse({'status': 'fail', 'message': '服务器错误'}, status=500)
