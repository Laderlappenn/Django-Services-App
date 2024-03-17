from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from django.utils import timezone
from django.contrib.auth.decorators import login_required
from django.http.request import QueryDict
from django.db.models import Sum

from SpecialistApp.models import Specialist
from ProfileApp.models import Profile
from ServiceAdsApp.models import Ad, ServiceRequest, Comment
from ServiceAdsApp.forms import CreateAdForm, CreateCommentForm, ChangeServiceRequestStatus
from VoteApp.models import Votes
# TODO need to use context_processors.messages
from .utils import get_info

# Create your views here.


def get_ads(request):
    if not request.GET.getlist("id"):
        ads = Ad.objects.all()
    else:
        ads_id_list = request.GET.getlist("id")
        ads = Ad.objects.filter(id__in=ads_id_list)
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
    comments = Comment.objects.filter(ad_fk=pk).select_related("user_fk")
    comment_form = CreateCommentForm()

    # Calculate the sum of votes where value is True and False for a specific ad_id
    sum_of_true_votes = Votes.objects.filter(ad_id=ad.id, vote=1).aggregate(Sum('vote'))['vote__sum']
    sum_of_false_votes = Votes.objects.filter(ad_id=ad.id, vote=0).aggregate(Sum('vote'))['vote__sum']
    # TODO change handle of TypeError when sum_of_false_votes or sum_of_true_votes is NoneType
    try:
        votes = sum_of_true_votes - sum_of_false_votes
    except TypeError:
        votes = sum_of_true_votes

    context = {"ad": ad,
               "info": info, 
               "button_status": button_status, 
               "comments": comments,
               "comment_form": comment_form,
               "votes": votes,
               }
    return render(request, "ServiceAdsApp/ad.html", context)


# only specialist can create ads
@login_required
def create_ad(request):
    user_id = request.user.id
    user_model = Profile.objects.get(id=user_id)
    if hasattr(user_model, "specialist"):
        if request.method == "POST":
            ad_form = CreateAdForm(request.POST, request.FILES)
            if ad_form.is_valid():
                spec = Specialist.objects.get(user=user_id)
                ad_model = ad_form.save(commit=False)
                ad_model.specialist_fk = spec
                ad_model.save()
                return HttpResponseRedirect(reverse("ad:ad", args=(ad_model.id,)))
        ad_form = CreateAdForm()
        return render(request, "ServiceAdsApp/create_ad.html", {"ad_form": ad_form})
    return HttpResponseRedirect(reverse("main_page:index"))  #TODO add no access page


#  2 similar queries.  Duplicated 2 times.
# htmx view
@login_required
def create_comment(request, pk):
    if request.method == "POST":
        comment_form = CreateCommentForm(request.POST)
        if comment_form.is_valid():
            comment_model = comment_form.save(commit=False)
            ad = Ad.objects.get(id=pk)
            comment_model.ad_fk = ad
            user_id = request.user.id
            profile = Profile.objects.get(id=user_id)
            comment_model.user_fk = profile
            comment_model.save()

            email = profile.email
            comment_text = comment_form.cleaned_data["text"]
            context = {"comment": comment_text,
                       "email": email,
                       "date_posted": timezone.now()}
            return render(request, "ServiceAdsApp/htmx/create_comment.html", context)

# the response goes to htmx
@login_required
def create_service_request(request, pk):
    user_id = request.user.id
    ad = Ad.objects.get(id=pk)
    if user_id == ad.specialist_fk.user_id:
        info = "Вы не можете обращаться на свое объявление"
        return render(request, "ServiceAdsApp/htmx/create_service_request.html", {"info": info})
    info = "Ожидайте ответа от специалиста"
    from django.db.utils import IntegrityError
    try:
        profile = Profile.objects.get(id=user_id)
        service_request = ServiceRequest(user_fk=profile, ad_fk=ad)
        service_request.save()
    except IntegrityError:
        info = "Вы уже обращались"
    return render(request, "ServiceAdsApp/htmx/create_service_request.html", {"info": info})


@login_required
def get_service_requests_as_user(request):
    user_id = request.user.id
    service_requests = ServiceRequest.objects.filter(user_fk=user_id).select_related("ad_fk")
    return render(request, "ServiceAdsApp/get_service_requests_for_user.html", {"service_requests": service_requests})


@login_required
def get_service_requests_as_specialist(request):
    user_model = request.user
    specialist_fk = user_model.specialist  # no n+1 problem because of new backend
    if hasattr(user_model, "specialist"):
        ads = Ad.objects.filter(specialist_fk=specialist_fk)
        service_requests = ServiceRequest.objects.filter(ad_fk__in=ads).select_related("user_fk")
        return render(request, "ServiceAdsApp/get_service_requests_for_specialist.html", {"service_requests": service_requests})
    return HttpResponseRedirect(reverse("main_page:index"))  # TODO add no access page


# TODO add no access cases
# view for user and specialst
@login_required
def get_service_request(request, pk):
    user_model = request.user
    service_request = ServiceRequest.objects.get(id=pk)
    context = {
        "service_request": service_request,
    }
    if hasattr(user_model, "specialist"):
        ad_specialist_id = service_request.ad_fk.specialist_fk.id # TODO fix?
        if ad_specialist_id == user_model.specialist.id:
            change_status_form = ChangeServiceRequestStatus(request.POST, instance=service_request)
            context["change_status_form"] = change_status_form
    return render(request, "ServiceAdsApp/service_request.html", context)


# TODO add no access cases, make sure that u cant change status if u don't own an ad
# i wanted to use PATCH request method but seems django doesnt like it
@login_required
def change_service_request_status(request, pk):
    if request.method == "POST":
        user_model = request.user
        if hasattr(user_model, "specialist"):
            service_request = ServiceRequest.objects.select_related("ad_fk").get(id=pk) # TODO fix?
            ad_specialist_id = service_request.ad_fk.specialist_fk.id # TODO fix?
            if ad_specialist_id == user_model.specialist.id:
                change_status_form = ChangeServiceRequestStatus(request.POST)
                if change_status_form.is_valid():
                    new_status = change_status_form.cleaned_data["status"]
                    service_request = ServiceRequest.objects.get(id=pk)
                    service_request.status = new_status
                    service_request.save(update_fields=["status"])
                    return HttpResponse("<br> status changed")
                return HttpResponse("status not changed")
        return HttpResponse("status not changed")














