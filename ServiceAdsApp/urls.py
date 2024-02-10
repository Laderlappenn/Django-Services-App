from django.urls import path
from . import views


urlpatterns = [
    path('', views.get_ads, name='ads'),
    path('create-request/<int:pk>', views.create_service_request, name='create_service_request'),
    path('create-ad/', views.create_ad, name='create_ad'),
    path('<int:pk>/', views.get_ad, name='ad'),
    path('<slug:ad_slug>/', views.get_ad, name='ad'), # order is important
    #path('', views., name=''),

]
