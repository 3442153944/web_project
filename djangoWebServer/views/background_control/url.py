from django.urls import path

from .model.admin_login import AdminLogin

urlpatterns = [
    path('AdminLogin/',AdminLogin.as_view(),name='AdminLogin'),
    #管理员登录
]