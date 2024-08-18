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

    def _request_path(self, request):
        request_path = request.path
        request_ip = request.META['REMOTE_ADDR']
        now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        return f'{request_ip}在{now}请求了{request_path}'

    def _log_and_return(self, request, level, message, data=None, status=200):
        log_message = f'{self._request_path(request)} {message}'
        if data:
            log_message += f'，请求数据为：{data}'
        getattr(self.logger, level)(log_message)
        return JsonResponse({'status': 'error', 'message': message}, status=status)

    def _get_user_info(self, cursor, userid):
        get_user_sql = '''
            SELECT username, user_avatar, user_address, password, user_back_img,
                   phone, email, user_self_website, sex, select_work, occupation,
                   birthday, vip, account_status, account_permissions
            FROM users
            WHERE userid = %s
        '''
        cursor.execute(get_user_sql, (userid,))
        columns = [column[0] for column in cursor.description]
        row = cursor.fetchone()
        return dict(zip(columns, row)) if row else None

    def _update_user_info(self, cursor, user_data, userid, is_super_admin, target_user_permissions):
        update_fields = '''
            username = %(username)s, user_avatar = %(user_avatar)s, user_address = %(user_address)s, 
            password = %(password)s, user_back_img = %(user_back_img)s, phone = %(phone)s, 
            email = %(email)s, user_self_website = %(user_self_website)s, sex = %(sex)s, 
            select_work = %(select_work)s, occupation = %(occupation)s, birthday = %(birthday)s, 
            vip = %(vip)s, account_status = %(account_status)s
        '''

        # 只有在操作者为超级管理员且目标用户权限低于操作者时才允许更新权限字段
        if is_super_admin and target_user_permissions < 2:
            update_fields += ', account_permissions = %(account_permissions)s'

        update_sql = f'UPDATE users SET {update_fields} WHERE userid = %(userid)s'
        cursor.execute(update_sql, user_data)

    def get(self, request):
        self.logger.warning(self._request_path(request) + '非法GET请求，请求数据为：' + str(request.GET))
        return render(request, '404.html', status=404)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
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
            result = json.loads(self.authentication.authenticate_user(token=token))

            operate_userid=result['user_info']['userid']

            with connection.cursor() as cursor:
                # 获取操作者的权限
                cursor.execute('SELECT account_permissions FROM users WHERE userid=%s', (result['user_info']['userid']))
                account_permissions = cursor.fetchone()[0]
                if not account_permissions:
                    return self._log_and_return(request, 'warning', '操作用户不存在')


            if not (result and result.get('is_login') == 1):
                return self._log_and_return(request, 'warning', '用户未登录')

            userid = data.get('userid')
            if not userid:
                return self._log_and_return(request, 'warning', '缺少被操作用户的userid')
            print(account_permissions)
            # 检查是否允许修改权限
            if account_permissions[0] not in [1, 2, '1', '2']:
                return self._log_and_return(request, 'warning', '权限不足，无法修改用户信息')

            with connection.cursor() as cursor:
                user_info = self._get_user_info(cursor, userid)
                if not user_info:
                    return self._log_and_return(request, 'warning', '用户不存在')

                target_user_permissions = user_info['account_permissions']

                # 防止用户修改自己的权限
                if result['user_info']['userid'] == userid or (account_permissions[0] == 2 and target_user_permissions == 2):
                    data['account_permissions'] = target_user_permissions

                update_data = {
                    'userid': userid,
                    'username': data.get('username', user_info['username']),
                    'user_avatar': data.get('user_avatar', user_info['user_avatar']),
                    'user_address': data.get('user_address', user_info['user_address']),
                    'password': data.get('password', user_info['password']),
                    'user_back_img': data.get('user_back_img', user_info['user_back_img']),
                    'phone': data.get('phone', user_info['phone']),
                    'email': data.get('email', user_info['email']),
                    'user_self_website': data.get('user_self_website', user_info['user_self_website']),
                    'sex': data.get('sex', user_info['sex']),
                    'select_work': data.get('select_work', user_info['select_work']),
                    'occupation': data.get('occupation', user_info['occupation']),
                    'birthday': data.get('birthday', user_info['birthday']),
                    'vip': data.get('vip', user_info['vip']),
                    'account_status': data.get('account_status', user_info['account_status']),
                    'account_permissions': data.get('account_permissions', user_info['account_permissions']),
                    'current_userid': operate_userid  # 添加当前操作用户ID
                }

                is_super_admin = account_permissions[0] == 2

                self._update_user_info(cursor, update_data, userid, is_super_admin, target_user_permissions)

                if is_super_admin:
                    self.logger.info(self._request_path(request) + '超级管理员修改用户信息，请求数据为：' + str(data))
                else:
                    self.logger.warning(
                        self._request_path(request) + '非超级管理员，修改用户信息，请求数据为：' + str(data))

                if cursor.rowcount >= 1:
                    return JsonResponse({'status': 'success', 'message': '修改成功'})

        except Exception as e:
            return self._log_and_return(request, 'error', '服务器发生错误', str(e), status=500)
