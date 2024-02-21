from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.urls import reverse
from django.http import HttpResponseRedirect

from ProfileApp.models import Profile
from ProfileApp.forms import ProfileRegistrationForm, LoginForm, ProfileImageForm
from SpecialistApp.forms import SpecialistRegistrationForm
from ServiceAdsApp.models import ServiceRequest, Ad


# view for both specialist and user
@login_required
def profile(request, pk: int = None):
    if pk is None:
        pk = request.user.id
    profile = Profile.objects.get(id=pk)
    context = {
    "profile": profile,
    }
    if hasattr(profile, "specialist"):
        specialist_id = request.user.specialist.id # no n+1 problem because of new backend

        # I wanted to implement the same inside the model class, but this does not apply to a specific model instance, but to all instances, so I decided to do it in view
        ads = Ad.objects.filter(specialist_fk=specialist_id)
        service_requests = ServiceRequest.objects.filter(ad_fk__in=ads)
        service_requests_count = service_requests.count()
        completed_service_requests_count = service_requests.filter(status="completed").count()
        percentage_of_completed_service_requets = completed_service_requests_count / service_requests_count
        
        context["service_requests"] = service_requests
        context["service_requests_count"] = service_requests_count
        context["completed_service_requests_count"] = completed_service_requests_count
        context["percentage_of_completed_service_requets"] = percentage_of_completed_service_requets
    return render(request, "ProfileApp/profile.html", context)


def register(request):
    profile_form = ProfileRegistrationForm()
    specialist_form = SpecialistRegistrationForm()
    context = {
        'profile_form': profile_form,
        'specialist_form': specialist_form
    }
    return render(request, "register.html", context)


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


def logout_profile(request):
    logout(request)
    return HttpResponseRedirect(reverse("profile:profile"))


def update_image(request):
    if request.method == "POST":
        profile = request.user
        image_form = ProfileImageForm(request.POST, request.FILES, instance=profile)
        if image_form.is_valid():
            image_form.save()
            return HttpResponseRedirect(reverse("profile:profile"))
    image_form = ProfileImageForm()
    return render(request, "ProfileApp/update_profile_image.html", {'image_form': image_form})


