from django.shortcuts import render
from django.http import HttpResponse
from .models import Votes

def ad_vote(request):
    vote, created = Votes.objects.update_or_create(vote=1, ad_id=2, user_id=1)
    if created:
        return HttpResponse(status=201)

    return HttpResponse(status=200)


# def profile_vote(request):
#     print(request.headers.get("voted"))
#     return HttpResponse(status=200)