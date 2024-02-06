from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from ProfileApp.models import Profile
from django.http import JsonResponse
# Create your views here.

@login_required
def profile(request, id: int = None):
    QueryS = Profile.objects.select_related('specialist')
    if id is None:
        id = request.user.id
    profile_obj = get_object_or_404(QueryS, id=id)
    return JsonResponse({'test': profile_obj.email})

