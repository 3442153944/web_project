import json

from django.db import connection
from django.http import HttpResponse, JsonResponse
from django.views import View
from .log.log import Logger
import uuid
from datetime import datetime, timedelta
from django.core.cache import cache


def create_uuid():
    """生成一个新的 UUID"""
    return str(uuid.uuid4())


class Authentication(View):
    logger = Logger()
    MAX_ATTEMPTS = 100
    BLOCK_TIME = 1  # 秒
    RATE_LIMIT = 20  # 每秒允许的最大尝试次数
    TOKEN_EXPIRY = 3600  # token 有效期（秒）
    data = {}
    response = None

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.request = None  # Initialize request attribute

    def set_request(self, request):
        self.request = request

    def _is_blocked(self, userid):
        """检查用户是否被锁定"""
        block_key = f"user_block_{userid}"
        block_info = cache.get(block_key)
        if block_info:
            block_time = datetime.strptime(block_info, '%Y-%m-%d %H:%M:%S')
            if datetime.now() < block_time + timedelta(seconds=self.BLOCK_TIME):
                return True
        return False

    def _record_attempt(self, userid):
        """记录用户的登录尝试"""
        attempts_key = f"user_attempts_{userid}"
        last_attempt_time_key = f"user_last_attempt_time_{userid}"

        now = datetime.now()
        last_attempt_time = cache.get(last_attempt_time_key)
        if last_attempt_time:
            last_attempt_time = datetime.strptime(last_attempt_time, '%Y-%m-%d %H:%M:%S')
        else:
            last_attempt_time = now

        # 如果超过 1 秒，重置尝试次数
        if (now - last_attempt_time).total_seconds() > 1:
            cache.set(attempts_key, 0)
            cache.set(last_attempt_time_key, now.strftime('%Y-%m-%d %H:%M:%S'))

        attempts = cache.get(attempts_key, 0)
        if attempts >= self.RATE_LIMIT:
            return False
        else:
            cache.set(attempts_key, attempts + 1)
            return True

    def _record_failed_attempt(self, userid):
        """记录失败的登录尝试，如果需要则锁定用户"""
        attempts_key = f"user_failed_attempts_{userid}"
        failed_attempts = cache.get(attempts_key, 0)
        if failed_attempts >= self.MAX_ATTEMPTS:
            block_time = datetime.now()
            cache.set(f"user_block_{userid}", block_time.strftime('%Y-%m-%d %H:%M:%S'))
            cache.set(attempts_key, 0)
        else:
            cache.set(attempts_key, failed_attempts + 1)

    def _fetch_user(self, cursor, sql, params):
        """从数据库中获取用户数据"""
        cursor.execute(sql, params)
        return cursor.fetchone()

    def _update_token(self, cursor, userid, new_token):
        """更新数据库中的用户 token"""
        update_token_sql = '''
            UPDATE users SET token=%s, token_expiry=%s WHERE userid=%s
        '''
        expiry_time = datetime.now() + timedelta(seconds=self.TOKEN_EXPIRY)
        cursor.execute(update_token_sql, (new_token, expiry_time.strftime('%Y-%m-%d %H:%M:%S'), userid))

    def _is_token_valid(self, cursor, token):
        """检查 token 是否有效"""
        check_token_sql = '''
            SELECT token_expiry FROM users WHERE token=%s
        '''
        cursor.execute(check_token_sql, (token,))
        row = cursor.fetchone()
        if row:
            token_expiry = datetime.strptime(row[0], '%Y-%m-%d %H:%M:%S')
            return datetime.now() < token_expiry
        return False

    def app_end_msg(self, data):
        """返回可直接给客户端使用的数据"""
        self.data = data

    def authenticate_user(self, token=None, userid=None, password=None):
        """用户认证方法"""
        try:
            with connection.cursor() as cursor:
                if userid and password:
                    if self._is_blocked(userid):
                        return HttpResponse('登录锁定，稍后再试', status=403)

                    # 基于 ID 和密码的认证
                    get_user_sql = '''
                        SELECT account_permissions FROM users WHERE userid=%s AND password=%s
                    '''
                    if not self._record_attempt(userid):
                        return HttpResponse('操作过频繁，请稍后再试', status=429)

                    row = self._fetch_user(cursor, get_user_sql, (str(userid), str(password)))
                    if row and row[0] in ['1', '2']:
                        new_token = create_uuid()
                        self._update_token(cursor, userid, new_token)
                        self.request.session['auth_response_data'] = {'status': 'success', 'is_login': 1,
                                                                      'token': new_token}
                        #获取登录用户的信息，返回给客户端
                        cursor.execute("select * from users where userid=%s", [userid])
                        user_info = cursor.fetchone()
                        columns = [desc[0] for desc in cursor.description]
                        user_info = dict(zip(columns, user_info))
                        self.response = JsonResponse(
                            {'status': 'success', 'is_login': 1, 'token': new_token,'user_info':user_info,
                             'data': self.data}, status=200)
                        self.response.set_cookie('auth_token', new_token, max_age=self.TOKEN_EXPIRY, samesite='None',
                                                 secure=True, httponly=True)
                        return self.response
                    else:
                        self._record_failed_attempt(userid)
                        return JsonResponse(
                            {'status': 'error', 'is_login': '0', 'message': '用户名或密码错误，请稍后再试'}, status=401)

                elif token:
                    if not self._is_token_valid(cursor, token):
                        return JsonResponse({'status': 'error', 'is_login': '0', 'message': 'token失效，请重试'},
                                            status=401)

                    # 如果 token 有效，只更新 token 的有效期
                    get_user_sql = '''
                        SELECT userid, account_permissions FROM users WHERE token=%s
                    '''
                    row = self._fetch_user(cursor, get_user_sql, (token,))
                    if row and row[1] in ['1', '2']:
                        userid = row[0]
                        #new_token = create_uuid()
                        #self._update_token(cursor, userid, new_token)
                        get_token_sql="select token from users where userid=%s"
                        cursor.execute(get_token_sql,(userid,))
                        new_token=cursor.fetchone()[0]
                        #更新过期时间
                        expiry_time = datetime.now() + timedelta(seconds=self.TOKEN_EXPIRY)
                        update_token_sql = '''
                            UPDATE users SET token_expiry=%s WHERE userid=%s
                        '''
                        cursor.execute(update_token_sql, (expiry_time.strftime('%Y-%m-%d %H:%M:%S'), userid))
                        #获取登录用户的信息，返回给客户端
                        cursor.execute("select * from users where userid=%s", [userid])
                        user_info = cursor.fetchone()
                        columns = [desc[0] for desc in cursor.description]
                        user_info = dict(zip(columns, user_info))

                        self.request.session['auth_response_data'] = {'status': 'success', 'is_login': 1,
                                                                      'token': new_token}
                        self.response = JsonResponse(
                            {'status': 'success', 'is_login': 1, 'token': new_token,'user_info':user_info,
                             'data': self.data}, status=200)
                        self.response.set_cookie('auth_token', new_token, max_age=self.TOKEN_EXPIRY, samesite='None',
                                                 secure=True, httponly=True)
                        self.response.set_cookie('userid', userid, max_age=self.TOKEN_EXPIRY, samesite='None',
                                                 secure=True,httponly=True)
                        return self.response
                    else:
                        return JsonResponse({'status': 'error', 'is_login': '0', 'message': 'token失效，请重试'},
                                            status=401)

                else:
                    return JsonResponse({'status': 'error', 'is_login': '0', 'message': '缺少认证信息'}, status=400)

        except Exception as e:
            print(e)
            self.logger.error(f"认证过程中出错: {e}")
            return JsonResponse({'status': 'error', 'is_login': '0', 'message': '认证过程中出错'}, status=500)



