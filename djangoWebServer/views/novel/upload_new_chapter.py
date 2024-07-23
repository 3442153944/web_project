from django.db import connection
from django.http import JsonResponse
from django.views import View
from ..log.log import Logger
from datetime import datetime
import json

class UploadNewChapter(View):
    now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'{request_ip} 访问了 {request_path}，时间为 {self.now}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + '非法GET访问，访问请求：' + str(request.GET))
        return JsonResponse({'status': 'success', 'message': '非法GET访问，请使用POST请求！'}, status=405)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            if not token:
                return JsonResponse({'status': 'error', 'message': '上传新章节失败，请先登录！'}, status=401)

            with connection.cursor() as cursor:
                cursor.execute('SELECT userid FROM users WHERE token = %s', [token])
                userid_row = cursor.fetchone()
                if not userid_row:
                    return JsonResponse({'status': 'error', 'message': 'token无效，请重新登陆'}, status=401)
                userid = userid_row[0]

                cursor.execute('SELECT work_id, work_series FROM novel_work WHERE belong_to_userid = %s', [userid])
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                if not result:
                    return JsonResponse({'status': 'error', 'message': '您还没有创建小说，请先创建小说！'}, status=401)
                rows = [dict(zip(columns, row)) for row in result]

            chapter_name = data.get('chapter_name')
            content = data.get('content')
            series_name = data.get('series_name')

            work_id = next((row['work_id'] for row in rows if row['work_series'] == series_name), None)
            if not work_id:
                return JsonResponse({'status': 'error', 'message': '指定的系列不存在！'}, status=404)

            sql = ('INSERT INTO novel_content (belong_to_series_id, belong_to_userid, title, content, create_time) '
                   'VALUES (%s, %s, %s, %s, %s)')
            with connection.cursor() as cursor:
                cursor.execute(sql, [work_id, userid, chapter_name, content, self.now])
                if cursor.rowcount <= 0:
                    return JsonResponse({'status': 'error', 'message': '上传新章节失败，请重试！'}, status=500)

            return JsonResponse({'status': 'success', 'message': '上传新章节成功！'}, status=200)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + '上传新章节失败，错误信息：' + str(e))
            return JsonResponse({'status': 'error', 'message': '上传新章节失败，请重试！'}, status=500)
        except Exception as e:
            self.logger.error(self.request_path(request) + '上传新章节失败，错误信息：' + str(e))
            return JsonResponse({'status': 'error', 'message': '上传新章节失败，请重试！'}, status=500)
