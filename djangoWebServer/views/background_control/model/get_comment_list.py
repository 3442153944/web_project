from django.db import connection, transaction
from django.http import JsonResponse
from django.views import View
from django.shortcuts import render
import json
from datetime import datetime
from .log.log import Logger


class GetCommectionList(View):
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