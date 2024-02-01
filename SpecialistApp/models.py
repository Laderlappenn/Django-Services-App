from django.db import models
from django.utils import timezone
# from ProfileApp.models import Profile
from django.contrib.auth.models import AbstractBaseUser
from django.conf import settings
# Create your models here.


class Specialist(AbstractBaseUser):
    SPECIALIZATION_CHOICES = {
        "PLUMBER": "Plumber",
        "ELECTRICIAN": "Electrician",
    }

    specialization = models.CharField(max_length=20,
                                      choices=SPECIALIZATION_CHOICES)


class Rating(models.Model):
    VOTE_CHOICES = {
        "1": "1",
        "2": "2",
        "3": "3",
        "4": "4",
        "5": "5",
    }

    created_at = models.DateTimeField(default=timezone.now)
    changed_at = models.DateTimeField(auto_now=True)
    user_id = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING)
    specialist_id = models.ForeignKey("Specialist", on_delete=models.CASCADE)
    vote = models.SmallIntegerField(choices=VOTE_CHOICES, null=False)
