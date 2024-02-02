from django.shortcuts import render
from SpecialistApp.forms import SpecialistRegistrationForm
from ProfileApp.forms import ProfileForm
# Create your views here.

def index(request):
    return render(request, "MainPageApp/index.html",)

def register(request):
    profile_form = ProfileForm()
    specialist_form = SpecialistRegistrationForm()
    return render(request, "register.html", {'profile_form': profile_form, 'specialist_form': specialist_form})

def register_profile(request):
    if request.method == "POST":
        form = ProfileForm(request.POST)
        if form.is_valid():
            form.save()
        else:
            return render(request, "register.html", {'profile_form': form})

def register_specialist(request):
    if request.method == "POST":
        form = SpecialistRegistrationForm(request.POST)
        if form.is_valid():
            form.save()
        else:
            return render(request, "register.html", {'specialist_form': form})
