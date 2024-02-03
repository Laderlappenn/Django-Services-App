from django.shortcuts import render
from SpecialistApp.forms import SpecialistRegistrationForm
from ProfileApp.forms import ProfileRegistrationForm
from django.contrib.auth import authenticate, login
# Create your views here.

def index(request):
    return render(request, "MainPageApp/index.html",)

def register(request):
    profile_form = ProfileRegistrationForm()
    specialist_form = SpecialistRegistrationForm()
    return render(request, "register.html", {'profile_form': profile_form, 'specialist_form': specialist_form})

def register_profile(request):
    if request.method == "POST":
        form = ProfileRegistrationForm(request.POST)
        if form.is_valid():
            form.save()

def register_specialist(request):
    if request.method == "POST":
        form = SpecialistRegistrationForm(request.POST)
        if form.is_valid():
            form.save()

def login_profile(request):
    if request.method == "POST":
        form = ProfileRegistrationForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            password = form.cleaned_data['password']
            user = authenticate(email=email, password=password)
            login(request, user)
    else:
        login_form = ProfileRegistrationForm()
        return render(request, "login.html", {'login_form': login_form})
