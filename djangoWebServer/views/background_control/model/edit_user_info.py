from .authentication import Authentication
from django.db import connection
from django.views import View
from django.http import JsonResponse
from .log.log import Logger
from datetime import datetime
import json
from django.shortcuts import render

class EditUserInfo(View):
    authentication = Authentication()
    logger = Logger()

    def _request_path(self,request):
        request_path=request.path
        request_ip=request.META['REMOTE_ADDR']
        now=datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        return f'{request_ip}在{now}请求了{request_path}'

    def get(self,request):
        self.logger.warning(self._request_path(request)+'非法GET请求，请求数据为：'+str(request.GET))
        return render(request,'404.html',status=200)

    def post(self,request,*args,**kwargs):
        try:
            data=json.loads(request.body.decode('utf-8'))
            auth_token=request.COOKIES.get('auth_token')
            self.authentication.set_request(request)
            self.authentication.authenticate_user(token=auth_token)
            auth_data = request.session.get('auth_response_data', None)
            if auth_data.get('is_login')==1:
                userid=data.get('userid',None)
                if not userid:
                    return JsonResponse({'status':'error','message':'缺少userid'})
                with connection.cursor() as cursor:
                    get_user_sql='''select username,user_avatar,user_address,password,user_back_img,
                      phone,email,user_self_website,sex,select_work,occupation,birthday,vip,account_status,account_permissions
                      from users where userid=%s'''
                    cursor.execute(get_user_sql,(userid,))
                    columns=[column[0] for column in cursor.description]
                    rows=[dict(zip(columns,row)) for row in cursor.fetchall()]
                    super_admin_update_sql='''update users set username=%s,user_avatar=%s,user_address=%s ,password=%s,user_back_img=%s,
                    phone=%s,email=%s,user_self_website=%s,sex=%s,select_work=%s,occupation=%s,birthday=%s,vip=%s,
                    account_permissions=%s,account_status=%s
                    where userid=%s'''
                    admin_update_sql='''
                        update users set username=%s,user_avatar=%s,user_address=%s ,password=%s,user_back_img=%s,
                    phone=%s,email=%s,user_self_website=%s,sex=%s,select_work=%s,occupation=%s,birthday=%s,vip=%s,
                    account_status=%s
                    where userid=%s
                    '''
            else:
                self.logger.warning(self._request_path(request)+'用户未登录，非法请求，请求数据为：'+str(data))
                return JsonResponse({'status':'error','message':'用户未登录'})

        except Exception as e:
            self.logger.error(self._request_path(request)+'发生错误，错误信息为：'+str(e))
            return JsonResponse({'status':'error','message':'服务器发生错误'})
