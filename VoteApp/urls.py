from django.urls import path
from . import views


urlpatterns = [
    path('', views.ad_vote, name='ad_vote'),

]
