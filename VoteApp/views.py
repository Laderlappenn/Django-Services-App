from django.shortcuts import render
from django.http import HttpResponse


def ad_vote(request):
    print(request.headers.get("voted"))
    return HttpResponse(status=200)


# def profile_vote(request):
#     print(request.headers.get("voted"))
#     return HttpResponse(status=200)