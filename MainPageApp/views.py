from django.shortcuts import render
from SpecialistApp.forms import SpecialistRegistrationForm
# Create your views here.

def index(request):
    return render(request, "MainPageApp/index.html",)

def register(request):
    return render(request, "register.html",)

def register_user(request):
    return render(request, "register.html",)

def register_specialist(request):
    if request.method == "POST":
        form = SpecialistRegistrationForm(request.POST)
        if form.is_valid:
            pass
        else:
            return render(request, "register.html", {'form': form})
