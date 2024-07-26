from django.urls import path

from .collect import Collect
from .like import Like
from .watch import Watch

urlpatterns = [
    path('Watch/', Watch.as_view(), name='Watch'),
    # 作品观看记录
    path('Like/',Like.as_view(),name='Like'),
    # 作品点赞记录
    path('Collect/',Collect.as_view(),name='Collect'),
    # 作品收藏记录
]
