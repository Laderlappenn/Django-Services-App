from django.urls import path
from . import views


urlpatterns = [
    path('', views.get_ads, name='ads'),
    path('create-request/<int:pk>', views.create_service_request, name='create_service_request'),
    path('service-requests/', views.get_service_requests_as_user, name='get_requests_for_user'),
    path('check-service-requests/', views.get_service_requests_as_specialist, name='get_requests_for_spec'),
    path('service-request/<int:pk>/', views.get_service_request, name='get_request'),
    path('change-service-request-status/<int:pk>', views.change_service_request_status, name='change_request_status'),
    path('create-ad/', views.create_ad, name='create_ad'),
    path('create-comment/<int:pk>', views.create_comment, name='create_comment'),
    path('<int:pk>/', views.get_ad, name='ad'),
    path('<slug:ad_slug>/', views.get_ad, name='ad'), # order is important
    #path('', views., name=''),

]
