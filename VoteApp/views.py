from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required

from .models import Vote

@login_required
def ad_vote(request, ad_id):
    user_id = request.user.id
    if request.META.get("HTTP_VOTED") == "true":
        voted = 1
    elif request.META.get("HTTP_VOTED") == "false":
        voted = 0
    elif request.META.get("HTTP_VOTED") == "null":
        # what if object DoesNotExist?
        vote = Vote.objects.get(ad_id=ad_id, user_id=user_id)
        vote.delete()
        return HttpResponse(status=200)
    vote, created = Vote.objects.update_or_create(ad_id=ad_id, user_id=user_id, defaults={'vote': voted},)
    if created:
        return HttpResponse(status=201)
    return HttpResponse(status=200)


# def profile_vote(request):
#     print(request.headers.get("voted"))
#     return HttpResponse(status=200)