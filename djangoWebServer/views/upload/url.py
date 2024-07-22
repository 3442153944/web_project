from django.urls import path

from .GetPreviewCover import GetPreviewCover
from .upload import UploadFile

urlpatterns= [
    path('UploadFile/',UploadFile.as_view(), name='UploadFile'),
    #上传文件接口
    path('GetPreviewCover/',GetPreviewCover.as_view(),name='GetPreviewCover'),
]
