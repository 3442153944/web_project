from .GetAllUserInfo import GetAllUserInfo
from django.urls import path

from .GetUserFans import GetUserFans
from .GetUserFollow import GetUserFollow
from .GetUserFollowToIll import GetUserFollowToIll
from .login import Login

urlpatterns = [
    path('GetAllUserInfo/', GetAllUserInfo.as_view(), name='GetAllUserInfo'),
    # 使用ID获取用户信息
    path('Login/', Login.as_view(), name='Login'),
    # 用户登录接口
    path('GetUserFans/', GetUserFans.as_view(), name='GetUserFans'),
    # 获取用户粉丝
    path('GetUserFollow/', GetUserFollow.as_view(), name='GetUserFollow'),
    # 获取用户关注
    path('GetUserFollowToIll/', GetUserFollowToIll.as_view(), name='GetUserFollowToIll'),
    # 获取用户关注的用户的插画详情
]
