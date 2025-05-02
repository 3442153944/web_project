from django.db import connection
from django.http import HttpResponse, JsonResponse
from server.api.re.recommend_base import RecommendBase

class IllRe(RecommendBase):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        global table_name
        try:
            data=self.format_request(request)
            work_type=data.get('work_type')
            user_id=request.user.id
            limit=data.get('limit')
            offset=data.get('offset')
            total_sql='''
            select count(*) as total from %s
            '''
            if work_type not in ['ill','comic','novel']:
                return JsonResponse({'code':400,'msg':'请求参数错误','data':{}},status=400)
            work_list=self.get_item_cf_recommendations(user_id, work_type, limit, offset)
            if work_type=='ill':
                table_name='illustration_work'
            if work_type=='comic':
                table_name='comic'
            if work_type=='novel':
                table_name='novel_work'
            with connection.cursor() as cursor:
                cursor.execute(total_sql,table_name)
                total=cursor.fetchall()[0][0]
            if work_list:
                return JsonResponse({'code':200,'msg':'ok','data':work_list,'total':total},status=200)
            else:
                return JsonResponse({'code':404,})

        except Exception as e:
            self.error_log(e,request)
            return JsonResponse({'code':500,'msg':'服务器错误'},status=500)