from django.shortcuts import render, redirect
from SpecialistApp.forms import SpecialistRegistrationForm
from ProfileApp.forms import ProfileRegistrationForm, LoginForm
from django.contrib.auth import authenticate, login
from django.urls import reverse
from django.http import HttpResponseRedirect
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
        login_form = LoginForm(data=request.POST) # why data required??
        if login_form.is_valid():
            print(login_form.cleaned_data)
            email = login_form.cleaned_data['username'] #TODO replace username with email
            password = login_form.cleaned_data['password']
            user = authenticate(email=email, password=password)
            if user is not None:
                login(request, user)
                return HttpResponseRedirect(reverse("profile:profile"))
        print("not ok")
        return render(request, "login.html", {'login_form': login_form})
    else:
        login_form = LoginForm()
        return render(request, "login.html", {'login_form': login_form})
