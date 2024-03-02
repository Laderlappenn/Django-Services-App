from django.shortcuts import render
from django.urls import reverse
from django.http import HttpResponseRedirect

from ServiceAdsApp.models import Ad

#  On Windows the Visual C++ 2019 redistributable is required
from rapidfuzz import fuzz as fuzzy_search


def search_ads(request, ratio=60):
    search_query = request.GET.get("query")
    ads = Ad.objects.all()
    search_result = [
        ad.id for index, ad in enumerate(ads)
        if fuzzy_search.ratio(search_query, ads[index].title) >= ratio
                    ]
    url = reverse("ad:ads") + "?"
    for ad_id in search_result:
        url += f"id={ad_id}&"
    # remove the last '&' character
    url = url[:-1]
    return HttpResponseRedirect(url)

