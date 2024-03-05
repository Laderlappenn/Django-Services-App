from django.urls import path
from . import views


urlpatterns = [
    path('', views.search, name='search'),
    path('search-result/', views.get_search_result, name='search_result'),
    path('ads/', views.search_ads, name='search_ads'),

]
