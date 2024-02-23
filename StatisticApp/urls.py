from django.urls import path
from . import views


urlpatterns = [
    path('statistic/', views.specialist_statistic, name='specialist_statistic'),
]