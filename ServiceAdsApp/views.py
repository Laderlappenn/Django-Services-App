from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.contrib.auth.decorators import login_required

from SpecialistApp.models import Specialist
from ProfileApp.models import Profile
from ServiceAdsApp.models import Ad, ServiceRequest
from ServiceAdsApp.forms import CreateAdForm

from .utils import get_info
# Create your views here.


def get_ads(request):
    ads = Ad.objects.all()
    return render(request, "ServiceAdsApp/ads.html", {"ads": ads})

#  test view for id and slug
def get_ad(request, pk=None, slug=None):
    if pk is not None:
        ad = Ad.objects.get(pk=pk)
    if slug is not None:
        ad = Ad.objects.filter(slug=slug)
    #info = get_info()
    info = "Обратиться"
    button_status = True
    return render(request, "ServiceAdsApp/ad.html", {"ad": ad, "info": info, "button_status": button_status})


# only specialist can create ads
@login_required
def create_ad(request):
    user_id = request.user.id
    user_model = Profile.objects.get(id=user_id)
    if hasattr(user_model, "specialist"):
        if request.method == "POST":
            ad_form = CreateAdForm(request.POST)
            if ad_form.is_valid():
                spec = Specialist.objects.get(user=user_id)
                ad_model = ad_form.save(commit=False)
                ad_model.specialist_fk = spec
                ad_model.save()
                return HttpResponseRedirect(reverse("ad:ad", args=(ad_model.id,)))
        ad_form = CreateAdForm()
        return render(request, "ServiceAdsApp/create_ad.html", {"ad_form": ad_form})
    return HttpResponseRedirect(reverse("main_page:index")) #TODO add no access page


# the response goes to htmx
@login_required
def create_service_request(request, pk):
    user_id = request.user.id
    ad = Ad.objects.get(id=pk)
    if user_id == ad.specialist_fk.user_id:
        info = "Вы не можете обращаться на свое объявление"
    else:
        info = "Ожидайте ответа от специалиста"
    profile = Profile.objects.get(id=user_id)
    service_request = ServiceRequest(user_fk=profile, ad_fk=ad)
    service_request.save()

    return render(request, "ServiceAdsApp/htmx/create_service_request.html", {"info": info})
