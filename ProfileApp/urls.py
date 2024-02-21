from django.urls import path
from . import views


urlpatterns = [
    path('', views.profile, name='profile'),
    path('<int:pk>/', views.profile, name='profile'),
    path('register/', views.register, name='register'),
    path('register/profile/', views.register_profile, name='register_profile'),
    path('register/specialist/', views.register_specialist, name='register_specialist'),
    path('update_image/', views.update_image, name='update_profile_image'),
    path('login/', views.login_profile, name='login_profile'),
    path('logout/', views.logout_profile, name='logout_profile'),
]
