# djangoWebServer/urls.py
from django.contrib import admin
from django.urls import path, include


urlpatterns = [
    path('admin/', admin.site.urls),
    path('mysql_conn_test/', include('views.mysql_conn_test.urls')),
    path('GetUserInfo/',include('views.GetUserInfo.url')),
    path('file/',include('views.upload.url'))
]

