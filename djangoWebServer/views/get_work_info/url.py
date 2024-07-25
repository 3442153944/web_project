from django.urls import path

from .GetIllInfo import GetIllInfo

urlpatterns = [
    path('GetIllInfo/', GetIllInfo.as_view(), name='GetIllInfo')
    # 使用作品ID来获取作品的详细信息

]
