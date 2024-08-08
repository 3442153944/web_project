import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

# 配置静态网页的代理
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    'H:/web_project',
    'C:/Python/Lib/site-packages/drf_yasg/static',
]


SECRET_KEY = 'django-insecure-ypu2=#s5wqperumf6kmmi=eb4)u=#sror+nsa*kq$dfkhm7-a-'
PORT = 2233

DEBUG = True

# 允许所有主机名请求
ALLOWED_HOSTS = ['*']

# 设置跨域
CORS_ALLOW_CREDENTIALS = True
CORS_ORIGIN_ALLOW_ALL = False  # 改为 False
CORS_ALLOWED_ORIGINS = [
    'http://localhost:3000',
    'http://localhost',
    'http://localhost:*',
    'http://127.0.0.1:*',
    'http://127.0.0.1',
    'http://localhost:3002',
    'http://localhost:3001',
    'http://localhost:3003',
    'http://localhost:3004',
    'http://localhost:3005',
    'http://localhost:3006',
    'https://localhost:3000',
    'https://localhost',
    'https://localhost:*',
    'https://127.0.0.1:*',
    'https://127.0.0.1',
    'https://localhost:3002',
    'https://localhost:3001',
    'https://localhost:3003',
    'https://localhost:3004',
    'https://localhost:3005',
    'https://localhost:3006',
    'https://192.168.43.1:3002',
    'http://localhost:5173'
]
CORS_ALLOW_METHODS = [
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
]
CORS_ALLOW_HEADERS = [
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
]

# 添加信任的 CSRF 域名
CSRF_TRUSTED_ORIGINS = [
    'http://localhost:3000',
    'http://localhost',
    'http://127.0.0.1',
    'http://localhost:3002',
    'http://127.0.0.1:*',
    'http://localhost:*',
    'http://localhost:3001',
    'http://localhost:3003',
    'http://localhost:3004',
    'http://localhost:3005',
    'http://localhost:3006',
    'http://localhost:3000',
    'http://localhost:*',
    'http://127.0.0.1:*',
    'https://localhost:3000',
    'https://localhost',
    'https://localhost:*',
    'https://127.0.0.1:*',
    'https://127.0.0.1',
    'https://localhost:3002',
    'https://localhost:3001',
    'https://localhost:3003',
    'https://localhost:3004',
    'https://localhost:3005',
    'https://localhost:3006',
    'https://192.168.43.1:3002',
    'http://localhost:5173/',
]

# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'corsheaders',
    'channels',
    'djangoWebServer.WebSocket',
    'views.GetUserInfo',
    'views.mysql_conn_test',
    'views.upload',
    'views.notice_control',
    'views.novel',
    'views.get_work_info',
    'rest_framework',
    'views.update_userinfo',
    'views.work_interaction',
    'views.recommend',
]

ASGI_APPLICATION = 'djangoWebServer.asgi.application'

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',  # 这里
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'djangoWebServer.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            BASE_DIR / 'templates',
            'C:/Python/Lib/site-packages/drf_yasg/templates',
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]


WSGI_APPLICATION = 'djangoWebServer.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'admin',
        'USER': 'admin',
        'PASSWORD': '123456',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True

STATIC_URL = 'static/'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
