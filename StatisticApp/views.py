from django.shortcuts import render
from django.contrib.auth.decorators import login_required

from .models import Visits
from ServiceAdsApp.models import Ad

@login_required
def specialist_ad_visits_statistic(request):
    user_model = request.user
    if hasattr(user_model, "specialist"):
        specialist_id = request.user.specialist.id # no n+1 problem because of new backend          
        ads = Ad.objects.filter(specialist_fk=specialist_id).values("id") # i don't like this method
        ad_paths = [f"/ad/{ads[ad_id]["id"]}/" for ad_id in range(len(ads))]
        visits = Visits.objects.filter(path__in=ad_paths).order_by("-count")
        return render(request, "StatisticApp/ad_statistic.html", {"ad_visits": visits})
    return HttpResponseRedirect(reverse("main_page:index"))  #TODO add no access page
