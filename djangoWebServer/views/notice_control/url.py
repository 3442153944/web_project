from django.urls import path
from .SearchAllNotice import SearchAllNotice
urlpatterns = [
    path('SearchAllNotice/',SearchAllNotice.as_view(),name='SearchAllNotice'),
]