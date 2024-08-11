from django.urls import path

from .GetAllWorkData import GetAllWorkData

urlpatterns=[
    path('GetAllWorkData/',GetAllWorkData.as_view(),name='GetAllWorkData'),
    #获取作者的所有作品数据以及历史数据
]