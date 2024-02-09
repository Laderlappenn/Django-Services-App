from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.contrib.auth.decorators import login_required

from ServiceAdsApp.models import Ad
from ServiceAdsApp.forms import CreateAdForm
# Create your views here.


def get_ads(request):
    ads = Ad.objects.all()
    return render(request, "ServiceAdsApp/ads.html", {"ads": ads})

#  test view for id and slug
def get_ad(request, pk=None, slug=None):
    if pk is not None:
        ad = Ad.objects.filter(id=pk)
    if slug is not None:
        ad = Ad.objects.filter(slug=slug)
    return render(request, "ServiceAdsApp/ad.html", {"ad": ad})

@login_required
def create_ad(request):
    if request.method == "POST":
        ad_form = CreateAdForm(request.POST)
        if ad_form.is_valid():
            ad_form.save()
            user_id = request.user.id
            ad_form.cleaned_data['specialist_fk_id'] = user_id
            print(ad_form.cleaned_data)
            return HttpResponseRedirect(reverse("ad:ad", args=(user_id,)))
    ad_form = CreateAdForm()
    return render(request, "ServiceAdsApp/create_ad.html", {"ad_form": ad_form})
