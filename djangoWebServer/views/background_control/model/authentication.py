from django.db import connection
from django.http import HttpResponse
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
    MAX_ATTEMPTS = 3
    BLOCK_TIME = 30  # 秒
    RATE_LIMIT = 2  # 每秒允许的最大尝试次数

    def __init__(self):
        super().__init__()

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
            UPDATE users SET token=%s WHERE userid=%s
        '''
        cursor.execute(update_token_sql, (new_token, userid))

    def authenticate_user(self, token=None, userid=None, password=None):
        """用户认证方法"""
        try:
            with connection.cursor() as cursor:
                if token:
                    # 基于 token 的认证
                    get_user_sql = '''
                        SELECT userid, account_permissions FROM users WHERE token=%s
                    '''
                    row = self._fetch_user(cursor, get_user_sql, (token,))
                    if row and row[1] in ['1', '2']:
                        userid = row[0]
                        new_token = create_uuid()
                        self._update_token(cursor, userid, new_token)
                        return new_token
                    else:
                        return False

                elif userid and password:
                    # 检查用户是否被锁定
                    if self._is_blocked(userid):
                        return False

                    # 基于 ID 和密码的认证
                    get_user_sql = '''
                        SELECT account_permissions FROM users WHERE userid=%s AND password=%s
                    '''
                    if not self._record_attempt(userid):
                        return False

                    row = self._fetch_user(cursor, get_user_sql, (userid, password))
                    if row and row[0] in ['1', '2']:
                        new_token = create_uuid()
                        self._update_token(cursor, userid, new_token)
                        return new_token
                    else:
                        self._record_failed_attempt(userid)
                        return False

                else:
                    return False

        except Exception as e:
            self.logger.error(f"认证过程中出错: {e}")
            return False
