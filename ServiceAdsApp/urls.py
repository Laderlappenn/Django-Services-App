from django.urls import path
from . import views


urlpatterns = [
    path('', views.get_ads, name='ads'),
    path('create-request/<int:pk>', views.create_service_request, name='create_service_request'),
    path('service-requests/', views.get_service_requests_as_user, name= 'get_requests_for_user'),
    path('check-service-requests/', views.get_service_requests_as_specialist, name= 'get_requests_for_spec'),
    path('create-ad/', views.create_ad, name='create_ad'),
    path('<int:pk>/', views.get_ad, name='ad'),
    path('<slug:ad_slug>/', views.get_ad, name='ad'), # order is important
    #path('', views., name=''),

]
