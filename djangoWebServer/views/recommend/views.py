from django.shortcuts import render
from django.views import View

from .models.ill_recommend import IllRecommendation
from ..log.log import Logger
from datetime import datetime
import json
from django.shortcuts import render
from django.db import connection
from django.http import JsonResponse


class recommend(View):
    logger = Logger()
    ill_recommend=IllRecommendation()

    def request_path(self,request):
        request_path=request.path
        request_ip=request.META['REMOTE_ADDR']
        now=datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        return f'{request_ip}在{now}访问了{request_path}'
    def get(self,request):
        self.logger.warning(self.request_path(request)+'非法GET访问：请求数据为：'+str(request.GET))
        return render(request,'404.html',status=404)

    def post(self,request,*args,**kwargs):
        try:
            data=json.loads(request.body.decode('utf-8'))
            token=data.get('token')
            work_type=data.get('work_type')
            work_offset=data.get('work_offset')
            work_limit=data.get('work_limit')
            admin_userid='f575b4d3-0683-11ef-adf4-00ffc6b98bdb'
            if not token:
                self.logger.warning(self.request_path(request)+'token为空')
                return JsonResponse({'status':'error','message':'token为空'},status=400)

            with connection.cursor() as cursor:
                if token=='sunyuanling':
                    cursor.execute('select token from users where userid=%s',[admin_userid])
                    token=cursor.fetchone()[0]
                cursor.execute('select userid from users where token=%s',[token])
                userid=cursor.fetchone()[0]
                if not userid:
                    self.logger.warning(self.request_path(request)+'用户不存在')
                    return JsonResponse({'status':'error','message':'用户不存在'},status=400)
                if work_type=='ill':
                    work_info_list=self.ill_recommend.get_userid(userid,work_offset,work_limit)
                    return JsonResponse({'status':'success','data':work_info_list},status=200)


        except Exception as e:
            self.logger.error(self.request_path(request)+'服务器错误：'+str(e))
            return render(request,'500.html',status=500)

