from django.urls import path
from . import views


urlpatterns = [
    #path('', views., name=''),
    path('ads/', views.search_ads, name='search_ads'),

]
