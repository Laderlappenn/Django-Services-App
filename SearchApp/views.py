from django.shortcuts import render
from django.urls import reverse
from django.http import HttpResponseRedirect

from ServiceAdsApp.models import Ad
from SpecialistApp.models import Specialist

from .fuzzy_search import fuzzy_search


def search(request):
    return render(request, "SearchApp/search.html", {})


#htmx view
def get_search_result(request):
    query_category = request.GET.get("category")
    search_query = request.GET.get("search_query")
    if query_category == "ads":
        ads = Ad.objects.all()
        search_result = fuzzy_search(search_query, ads)
        return render(request, "SearchApp/ads_results.html", {"ads": search_result})
    if query_category == "specs":
        specialists = Specialist.objects.all()
        search_result = fuzzy_search(search_query, specialists, "specialization")
        return render(request, "SearchApp/specialists_results.html", {"specialists": search_result})




#  deprecated
def search_ads(request):
    search_query = request.GET.get("query")
    ads = Ad.objects.all()
    search_result = fuzzy_search(search_query, ads)
    url = reverse("ad:ads") + "?"
    for ad_id in search_result:
        url += f"id={ad_id}&"
    # remove the last '&' character
    url = url[:-1]
    return HttpResponseRedirect(url)

