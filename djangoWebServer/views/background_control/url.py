from django.urls import path

from .model.admin_login import AdminLogin
from .model.get_userlist import GetUserList

urlpatterns = [
    path('AdminLogin/',AdminLogin.as_view(),name='AdminLogin'),
    #管理员登录
    path('GetUserList/',GetUserList.as_view(),name='GetUserList'),
    #获取用户列表
]