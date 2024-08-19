from datetime import timedelta, datetime

from django.conf import settings
from django.utils import timezone
from django.http import JsonResponse
import jwt
import json
import os
from cryptography.fernet import Fernet
from ..log.log import Logger

# 初始化日志记录器
logger = Logger()

# 获取加密密钥
token_key_path = os.path.join('H:/web_project/djangoWebServer', 'token_key.txt')
token_secret = open(token_key_path, 'rb').read()
cipher_suite = Fernet(token_secret)

TOKEN_EXPIRY=3600

def create_jwt_token(userid):
    """生成并签名 JWT Token，设置自定义过期时间"""
    try:
        payload = {
            'userid': userid,
            'exp': timezone.now() + timedelta(seconds=TOKEN_EXPIRY)  # 使用 timezone.now()
        }
        # 使用 SECRET_KEY 进行编码
        token = jwt.encode(payload, settings.SECRET_KEY, algorithm='HS256')
        return token
    except Exception as e:
        print(f'生成 JWT Token 错误: {e}')
        raise ValueError("生成 Token 失败")


def decode_jwt_token(token):
    """解码 JWT Token"""
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
        return payload
    except jwt.ExpiredSignatureError:
        raise ValueError("Token 已过期")
    except jwt.InvalidTokenError:
        raise ValueError("无效的 Token")


def encrypt_token(token):
    """加密 JWT Token"""
    if isinstance(token, str):
        token = token.encode()  # 确保 token 是 bytes 类型
    return cipher_suite.encrypt(token).decode()

def decrypt_token(encrypted_token):
    """解密 JWT Token"""
    if isinstance(encrypted_token, str):
        encrypted_token = encrypted_token.encode()  # 确保 encrypted_token 是 bytes 类型
    return cipher_suite.decrypt(encrypted_token).decode()


class TokenAuthMiddleware:
    """Token 认证中间件"""

    def __init__(self, get_response):
        self.get_response = get_response

    def token_auth(self, request):
        """Token 认证逻辑"""
        try:
            if hasattr(request, 'userinfo') and hasattr(request, 'token') and hasattr(request, 'is_authenticated'):
                request.userinfo = json.loads(request.userinfo)
                return None

            auth_header = request.headers.get('Authorization')
            if auth_header and auth_header.startswith('Bearer '):
                token = auth_header.split(' ')[1]
                print('原始Token:', token)
                decrypted_token = decrypt_token(token)  # 先解密
                print('解密后的Token:', decrypted_token)
                decoded_token = decode_jwt_token(decrypted_token)  # 然后解码JWT
                print('解码后的Token:', decoded_token)
                if decoded_token:
                    userid = decoded_token['userid']
                    new_token = create_jwt_token(userid)
                    c_token=encrypt_token(new_token)
                    request.userid = userid
                    request.token = c_token  # 直接使用新生成的token，不再额外加密
                    request.is_authenticated = True
                    return None
                else:
                    return JsonResponse({'status': 'error', 'message': 'Token 无效或已过期'}, status=401)
            return None

        except Exception as e:
            print(e)
            logger.error(f'服务器错误: {str(e)}')
            return JsonResponse({'status': 'error', 'message': f'服务器错误: {str(e)}'}, status=500)

    def __call__(self, request):
        """处理请求"""
        if request.method == 'POST':
            response = self.token_auth(request)
            if response:
                return response
        return self.get_response(request)
