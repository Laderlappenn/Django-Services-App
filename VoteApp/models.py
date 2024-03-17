from django.db import models
from django.utils import timezone
from django.conf import settings

# Create your models here.

class Votes(models.Model):
    created_at = models.DateTimeField(default=timezone.now)
    changed_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING)
    ad = models.ForeignKey("ServiceAdsApp.Ad", on_delete=models.CASCADE)
    vote = models.BooleanField(null=False)

    class Meta:
        unique_together = ["ad", "user"]
