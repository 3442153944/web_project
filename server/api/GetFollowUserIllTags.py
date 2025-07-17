from base_api import BaseApi
from django.http import JsonResponse
import re


class GetFollowUserIllTags(BaseApi):
    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            is_login = self.check_user(request)
            if is_login:
                return is_login

            user_id = request.user.id
            get_follow_user = '''
                SELECT follow_user_id 
                FROM admin.user_follow 
                WHERE user_id = %s 
                LIMIT 100
            '''
            user_list = self.execute_sql(get_follow_user, [user_id])

            tags = []
            if user_list:
                follow_user_ids = [user['follow_user_id'] for user in user_list]
                format_strings = ','.join(['%s'] * len(follow_user_ids))
                get_work_list = f'''
                    SELECT work_tags 
                    FROM admin.illustration_work 
                    WHERE belong_to_user_id IN ({format_strings})
                '''
                work_list = self.execute_sql(get_work_list, follow_user_ids)

                temp_tag = []
                for work in work_list:
                    raw_tags = work.get('work_tags') or ''
                    temp = re.split(r'[,，]', raw_tags.replace(' ', ''))
                    temp_tag.extend(filter(None, temp))  # 去除空字符串

                tags = list(set(temp_tag))

            return JsonResponse({
                'code': 200,
                'msg': '获取成功',
                'data': tags
            }, status=200)

        except Exception as e:
            print(e)
            self.error_log(e, request)
            return JsonResponse({
                'code': 500,
                'msg': '服务器错误'
            }, status=500)
