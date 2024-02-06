from django.urls import path
from . import views


urlpatterns = [
    path('', views.profile, name='profile'),
    path('<int:id>/', views.profile, name='profile'),
    path('register/', views.register, name='register'),
    path('register/profile/', views.register_profile, name='register_profile'),
    path('register/specialist/', views.register_specialist, name='register_specialist'),
    path('login/', views.login_profile, name='login_profile'),

]
