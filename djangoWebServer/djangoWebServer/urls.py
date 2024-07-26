# djangoWebServer/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('mysql_conn_test/', include('views.mysql_conn_test.urls')),
    path('GetUserInfo/', include('views.GetUserInfo.url')),
    path('file/', include('views.upload.url')),
    path('notice_control/', include('views.notice_control.url')),
    path('novel/', include('views.novel.url')),
    path('get_work_info/', include('views.get_work_info.url')),
    path('work_interaction/', include('views.work_interaction.url'))
    # 作品互动的主接口
]
