from django.urls import path

from .model.admin_login import AdminLogin
from .model.edit_user_info import EditUserInfo
from .model.get_comic_list import GetComicList
from .model.get_ill_list import GetIllList
from .model.get_userlist import GetUserList
from .model.search_ill import SearchIll
from .model.updata_ill_status import UpdateIll

urlpatterns = [
    path('AdminLogin/',AdminLogin.as_view(),name='AdminLogin'),
    #管理员登录
    path('GetUserList/',GetUserList.as_view(),name='GetUserList'),
    #获取用户列表
    path('EditUserInfo/',EditUserInfo.as_view(),name='EditUserInfo'),
    #编辑用户信息
    path('GetIllList/',GetIllList.as_view(),name='GetIllList'),
    #获取插画作品列表
    path('GetComicList/',GetComicList.as_view(),name='GetComicList'),
    #获取漫画作品列表
    path('SearchIll/',SearchIll.as_view(),name='SearchIll'),
    #搜索插画作品
    path('UpdateIll/',UpdateIll.as_view(),name='UpdateIll'),
    #更新插画作品
]