from django.urls import path
from .upload import UploadFile

urlpatterns= [
    path('UploadFile/',UploadFile.as_view(), name='UploadFile')
    #上传文件接口
]
