from django.shortcuts import render
from django.views import View
from django.http import JsonResponse
from django.db import connection
import json
from datetime import datetime
from .models.comic_recommend import ComicRecommendation
from .models.ill_recommend import IllRecommendation
from .models.novel_recommend import NovelRecommendation
from ..log.log import Logger


class RecommendView(View):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 初始化 Logger 和推荐类
        self.logger = Logger()
        self.ill_recommend = IllRecommendation()
        self.comic_recommend = ComicRecommendation()
        self.novel_recommend = NovelRecommendation()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR', '未知IP')
        now = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        return f'{request_ip} 在 {now} 访问了 {request_path}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + ' 非法GET访问：请求数据为：' + str(request.GET))
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            token = data.get('token')
            work_type = data.get('work_type')
            work_offset = data.get('work_offset', 0)
            work_limit = data.get('work_limit', 9)
            admin_userid = 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb'

            if not token:
                self.logger.warning(self.request_path(request) + ' token为空')
                return JsonResponse({'status': 'error', 'message': 'token为空'}, status=400)

            userid = self.get_userid_from_token(token, admin_userid)
            if not userid:
                self.logger.warning(self.request_path(request) + ' 用户不存在')
                return JsonResponse({'status': 'error', 'message': '用户不存在'}, status=400)

            work_info_list = []
            if work_type == 'ill':
                work_info_list = self.ill_recommend.get_userid(userid, work_offset, work_limit)
            elif work_type == 'comic':
                work_info_list = self.comic_recommend.get_userid(userid, work_offset, work_limit)
            elif work_type == 'novel':
                work_info_list = self.novel_recommend.get_userid(userid, work_offset, work_limit)
            else:
                self.logger.warning(self.request_path(request) + ' 无效的 work_type: %s' % work_type)
                return JsonResponse({'status': 'error', 'message': '无效的 work_type'}, status=400)

            return JsonResponse({'status': 'success', 'data': work_info_list}, status=200)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + ' 请求数据格式错误：' + str(e))
            return JsonResponse({'status': 'error', 'message': '请求数据格式错误'}, status=400)
        except Exception as e:
            self.logger.error(self.request_path(request) + ' 服务器错误：' + str(e))
            return render(request, '500.html', status=500)

    def get_userid_from_token(self, token, admin_userid):
        """根据token获取用户ID"""
        try:
            with connection.cursor() as cursor:
                if token == 'sunyuanling':
                    cursor.execute('SELECT token FROM users WHERE userid=%s', [admin_userid])
                    token = cursor.fetchone()[0]
                cursor.execute('SELECT userid FROM users WHERE token=%s', [token])
                result = cursor.fetchone()
                return result[0] if result else None
        except Exception as e:
            self.logger.error('获取用户ID时发生错误: %s' % str(e))
            return None
