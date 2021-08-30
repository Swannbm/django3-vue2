"""Urls of the SPA in vue.js"""
from django.urls import path

from .views import entry_point


app_name = 'front'


urlpatterns = [
    path('', entry_point, name="entry"),
]
