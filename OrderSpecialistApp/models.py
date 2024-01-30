from django.db import models
from django.utils import timezone
from ProfileApp.models import User
# Create your models here.


class Specialist(User):
    SPECIALIZATION_CHOICES = {
        "PLUMBER": "Plumber",
        "ELECTRICIAN": "Electrician",
    }

    specialization = models.CharField(max_lenght=20,
                                      choices=SPECIALIZATION_CHOICES)


class Rating(models.Model):
    created_at = models.DateTimeField(default=timezone.now)
    changed_at = models.DateTimeField(auto_now=True)
