from django.urls import path
from .SearchAllNotice import NoticeOperations, ControlNoticeLogin
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('NoticeOperations/', NoticeOperations.as_view(), name='NoticeOperations'),
    # 公告操作
    path('ControlNoticeLogin/', ControlNoticeLogin.as_view(), name='ControlNoticeLogin'),
]
