from django.shortcuts import render, redirect
from SpecialistApp.forms import SpecialistRegistrationForm
from ProfileApp.forms import ProfileRegistrationForm, LoginForm
from django.contrib.auth import authenticate, login
from django.urls import reverse
from django.http import HttpResponseRedirect
# Create your views here.

def index(request):
    return render(request, "MainPageApp/index.html",)
