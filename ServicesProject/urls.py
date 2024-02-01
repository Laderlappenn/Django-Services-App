"""
URL configuration for ServicesProject project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(('MainPageApp.urls', 'main_page'),  namespace='main_page')),
    path('specialists/', include(('SpecialistApp.urls', 'specialists'), namespace='specialists')),
    path('profile/', include(('ProfileApp.urls', 'profile'), namespace='profile')),
    path('posts/', include(('ServiceAdsApp.urls', 'posts'), namespace='posts')),
    path('search/', include(('SpecialistSearchApp.urls', 'search'), namespace='search')),
    path('__debug__/', include('debug_toolbar.urls')), # debug toolbar

]
