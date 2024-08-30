from django.db import connection
from django.http import JsonResponse
from django.shortcuts import render
from django.views import View
import json
from datetime import datetime
from .log.log import Logger

logger = Logger()

class GetComicList(View):
    def _request_path(self,request):
        request_path=request.path
        request_ip = request.META['REMOTE_ADDR']
        now=datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        return f'{request_ip}在{now}请求了{request_path}'

    def get(self,request):
        logger.warning('非法GET请求，请求内容为：'+str(request.GET))
        return render(request,'404.html',status=404)

    def post(self,request,*args,**kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = str(getattr(request, 'userid', None))
            is_authenticated = getattr(request, 'is_authenticated', None)
            if is_authenticated:
                limit = data.get('limit',10)
                offset = data.get('offset',0)
                sql='select account_permissions from users where userid=%s'
                with connection.cursor() as cursor:
                    cursor.execute(sql,[userid])
                    result=cursor.fetchone()
                    if result in ['1','2',1,2]:
                        sql='select * from comic limit %s offset %s'
                        cursor.execute(sql,[limit,offset])
                        result=cursor.fetchall()
                        if result:
                            columns = [col[0] for col in cursor.description]
                            rows=[dict(zip(columns,row)) for row in result]
                            return JsonResponse({
                                'status':'success',
                                'data':rows
                            },status=200)
                        else:
                            return JsonResponse({'status':'success','data':[]},status=200)
                    else:
                        logger.warning(self._request_path(request)+'非授权人员访问')
                        return JsonResponse({'status':'error','message':'权限不足'},status=403)
            else:
                logger.warning(self._request_path(request)+'用户未登录，非法访问')
                return JsonResponse({'status':'error','message':'未登录'},status=401)
        except Exception as e:
            logger.error(e)
            return JsonResponse({'status':'error','message':'server_error'},status=500)