from django.shortcuts import render

# Create your views here.

def index(request):
    print("test")
    return (render(request, "MainPageApp/index.html",))
