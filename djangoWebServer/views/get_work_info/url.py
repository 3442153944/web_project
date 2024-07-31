from django.urls import path

from .GetComicinfo import GetComicinfo
from .GetIllInfo import GetIllInfo
from .GetNovelContent import GetNovelContent
from .GetNovelList import GetNovelList

urlpatterns = [
    path('GetIllInfo/', GetIllInfo.as_view(), name='GetIllInfo'),
    # 使用作品ID来获取作品的详细信息
    path('GetComicinfo/',GetComicinfo.as_view(),name='GetComicinfo'),
    # 使用作品ID来获取漫画作品的详细信息
    path('GetNovelList/',GetNovelList.as_view(),name='GetNovelList'),
    # 使用作品ID来获取小说作品的详细信息
    path('GetNovelContent/',GetNovelContent.as_view(),name='GetNovelContent'),
    # 使用作品ID和章节名来获取小说作品的章节内容
]
