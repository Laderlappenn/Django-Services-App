from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from ProfileApp.models import Profile
from django.http import JsonResponse
from SpecialistApp.forms import SpecialistRegistrationForm
from ProfileApp.forms import ProfileRegistrationForm, LoginForm
from django.contrib.auth import authenticate, login
from django.urls import reverse
from django.http import HttpResponseRedirect


@login_required
def profile(request, id: int = None):
    QueryS = Profile.objects.select_related('specialist')
    if id is None:
        id = request.user.id
    profile_obj = get_object_or_404(QueryS, id=id)
    return JsonResponse({'test': profile_obj.email})

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
