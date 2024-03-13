from django.db import models
from django.utils import timezone
from django.contrib.auth.models import AbstractBaseUser
from django.conf import settings

# Create your models here.

class Specialist(models.Model):
    SPECIALIZATION_CHOICES = {
        "PLUMBER": "Plumber",
        "ELECTRICIAN": "Electrician",
    }

    specialization = models.CharField(max_length=20,
                                      choices=SPECIALIZATION_CHOICES)
    user = models.OneToOneField(settings.AUTH_USER_MODEL,
                                on_delete=models.CASCADE, null=False)

# class Rating(models.Model):
#     VOTE_CHOICES = {
#         "1": "1",
#         "2": "2",
#         "3": "3",
#         "4": "4",
#         "5": "5",
#     }
#
#     created_at = models.DateTimeField(default=timezone.now)
#     changed_at = models.DateTimeField(auto_now=True)
#     user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING)
#     ad = models.ForeignKey("Ad", on_delete=models.CASCADE)
#     vote = models.SmallIntegerField(choices=VOTE_CHOICES, null=False)
