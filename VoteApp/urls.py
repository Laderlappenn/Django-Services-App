from django.urls import path
from . import views


urlpatterns = [
    path('<int:ad_id>/', views.ad_vote, name='ad_vote'),

]
