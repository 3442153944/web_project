from django.db import connection
from django.http import HttpResponse, JsonResponse
from server.api.re.recommend_base import RecommendBase


class ReWork(RecommendBase):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            data = self.format_request(request)
            work_type = data.get('work_type')
            user_id = request.user.id
            limit = data.get('limit')
            offset = data.get('offset')

            if work_type not in ['ill', 'comic', 'novel']:
                return JsonResponse({'code': 400, 'msg': '请求参数错误', 'data': {}}, status=400)

            # 动态表名映射
            table_map = {
                'ill': 'illustration_work',
                'comic': 'comic',
                'novel': 'novel_work'
            }
            table_name = table_map.get(work_type)

            # 安全的计数查询
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT COUNT(*) FROM {table_name}")  # 参数作为列表传递
                total = cursor.fetchone()[0]

            work_list = self.get_recommend_work(user_id, work_type, limit, offset)

            if work_list:
                return JsonResponse({
                    'code': 200,
                    'msg': 'ok',
                    'data': work_list,
                    'total': total
                }, status=200)
            else:
                return JsonResponse({'code': 404, 'msg': '未找到数据', 'data': {}}, status=404)

        except Exception as e:
            print(f"Error in ReWork: {str(e)}")
            self.error_log(e, request)
            return JsonResponse({'code': 500, 'msg': '服务器内部错误'}, status=500)
