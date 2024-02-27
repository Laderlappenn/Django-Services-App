from django.urls import path
from . import views


urlpatterns = [
    path('ads/', views.specialist_ad_visits_statistic, name='specialist_ad_visits_statistic'),
]
