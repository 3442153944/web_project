from .GetAllUserInfo import GetAllUserInfo
from django.urls import path
from .login import Login

urlpatterns = [
    path('GetAllUserInfo/', GetAllUserInfo.as_view(), name='GetAllUserInfo'),
    path('Login/', Login.as_view(), name='Login'),
]
