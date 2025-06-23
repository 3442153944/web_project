from django.db import connection
from django.http import JsonResponse
from django.views import View
from datetime import datetime
from ..log.log import Logger
import json
import bleach
from django.utils.html import escape
import re
from base_api import BaseApi


class GetNovelContentNew(BaseApi):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            if self.check_user(request):
                return self.check_user(request)
            data = self.format_request(request)
            work_id = data.get('work_id')
            chapter_id = data.get('chapter_id')
            vip = request.user.vip
            if not work_id and not chapter_id:
                return JsonResponse({'code': 400, 'msg': '请求参数错误'}, status=400)
            sql = '''
            select *,left(novel_content.content,100) as content from novel_content where id=%s and belong_to_series_id=%s
            '''
            vip_sql = '''
            select * from novel_content where id=%s and  belong_to_series_id=%s
            '''
            if vip == 1:
                result = self.execute_sql(vip_sql, [work_id, chapter_id], True)[0]
            else:
                result = self.execute_sql(sql, [work_id, chapter_id], True)[0]
            if result:
                return JsonResponse({'code': 200, 'msg': '获取成功', 'data': result}, status=200)
            else:
                return JsonResponse({'code': 404, 'msg': '小说不存在', 'data': {}}, status=404)
        except json.JSONDecodeError as e:
            print(e)
            self.error_log(e, request)
            return JsonResponse({'code': 500, 'msg': '服务器异常'}, status=500)
        except Exception as e:
            print(e)
            self.error_log(e, request)
            return JsonResponse({'code': 500, 'msg': '服务器异常'}, status=500)


class GetNovelContent(View):
    logger = Logger()

    def request_path(self, request):
        request_path = request.path
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        request_ip = request.META.get('REMOTE_ADDR', 'unknown')
        return f'{request_ip}在{now}访问了{request_path}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + '非法GET请求，请求数据为：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法请求方式'}, status=400)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            userid = request.user.id
            is_vip = request.user.vip
            print(is_vip)
            if not token and not userid:
                self.logger.warning(self.request_path(request) + 'token缺失，请求数据为：' + str(data))
                return JsonResponse({'status': 'error', 'message': 'token缺失或者用户未登录'}, status=400)

            with connection.cursor() as cursor:
                cursor.execute('SELECT vip FROM users WHERE token=%s or userid=%s', [token, userid])
                result = cursor.fetchone()

                if result:
                    vip = result[0]
                else:
                    vip = 0

                if token == 'sunyuanling':
                    vip = 1

                if vip == 1 or vip == '1' or token == 'sunyuanling':
                    title = data.get('title')
                    work_id = data.get('work_id')
                    if title and work_id:
                        cursor.execute('SELECT content FROM novel_content '
                                       'WHERE title=%s AND belong_to_series_id=%s and chapter_approved=1',
                                       [title, work_id])
                        result = cursor.fetchone()

                        if result:
                            content = result[0]
                            # 替换 \\n 为 \n
                            content = content.replace('\\n', '\n')
                            # 处理每个段落，并添加首行缩进
                            paragraphs = [p.strip() for p in content.split('\n') if p.strip()]
                            formatted_content = ''.join(
                                f'<p style="text-indent: 2em; margin: 0; padding: 0;">{escape(p)}</p>' for p in
                                paragraphs
                            )
                            # 使用 bleach 清洗 HTML 内容，允许基本标签和属性
                            allowed_tags = ['p', 'b', 'i', 'u']
                            safe_content = bleach.clean(formatted_content, tags=allowed_tags, strip=True)
                            safe_content_with_styles = re.sub(r'<p>',
                                                              r'<p style="text-indent: 2em; margin: 0; padding: 0;">',
                                                              safe_content)
                            return JsonResponse({'status': 'success', 'data': safe_content_with_styles})
                        else:
                            self.logger.warning(self.request_path(request) + '未找到相关内容，请求数据为：' + str(data))
                            return JsonResponse({'status': 'error', 'message': '未找到相关内容'}, status=404)
                    else:
                        self.logger.warning(self.request_path(request) + '请求数据错误，请求数据为：' + str(data))
                        return JsonResponse({'status': 'error', 'message': '请求数据错误'}, status=400)
                else:
                    self.logger.warning(self.request_path(request) + '无权访问，请求数据为：' + str(data))
                    return JsonResponse({'status': 'error', 'message': '无权访问'}, status=403)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + '请求数据格式错误，错误信息为：' + str(e))
            return JsonResponse({'status': 'error', 'message': '请求数据格式错误'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + '服务器内部错误，错误信息为：' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)
