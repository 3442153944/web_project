from django.urls import path

from .DeleteUserBack import DeleteUserBack
from .UpdateUserBack import UpdateUserBack

urlpatterns=[
 path('UpdateUserBack/',UpdateUserBack.as_view(),name='UpdateUserBack'),
    #更新用户的背景
 path('DeleteUserBack/',DeleteUserBack.as_view(),name='DeleteUserBack')
 #删除用户的背景,替换为默认背景
]