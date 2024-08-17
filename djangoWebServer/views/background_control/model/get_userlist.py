from django.db import connection
from django.http import JsonResponse
from django.views import View
from django.shortcuts import render
from .log.log import Logger
from datetime import datetime
import json
from .authentication import Authentication


class GetUserList(View):
    logger = Logger()

    def _request_path(self, request):
        request_path = request.get_full_path()
        request_ip = request.META['REMOTE_ADDR']
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        return f'{request_ip}在{now}请求了{request_path}'

    def get(self, request):
        self.logger.warning(self._request_path(request) + '非法GET请求，请求数据为：' + str(request.GET))
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            authentication = Authentication()
            data = json.loads(request.body.decode('utf-8'))
            # 从请求头获取 Authorization 头部
            auth_header = request.headers.get('Authorization')

            token = None
            if auth_header and auth_header.startswith("Bearer "):
                try:
                    parts = auth_header.split(" ")
                    if len(parts) == 2 and parts[1] not in [None, 'null', '']:
                        token = parts[1]
                        print('解析token成功', token)
                    else:
                        print('\n解析token失败')
                except Exception as e:
                    print('\n解析token错误', e)
            result = json.loads(authentication.authenticate_user(token=token))
            print('\n验证结果', result.get('status'))
            if result.get('status') == 'success':
                sql = '''select * from users'''
                cursor = connection.cursor()
                cursor.execute(sql)
                columns = [col[0] for col in cursor.description]
                rows = [dict(zip(columns, row)) for row in cursor.fetchall()]
                # 这里直接在 result 字典中更新 data 键
                result['data'] = {'user_list': rows}
                print('最后的结果：', result)
                return JsonResponse(result, status=result.get('status_code') if result.get('status_code') else 404)
            else:
                return JsonResponse({'status': 'error', 'message': '用户未登录！'},
                                    status=result.get('status_code') if result.get('status_code') else 404)
        except Exception as e:
            print(e)
            self.logger.error(f'{self._request_path(request)}请求失败，错误信息为：{str(e)}')
            return_data = JsonResponse({'status': 'error', 'message': '服务器错误！'})
            return return_data

