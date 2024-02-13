import uuid

from slugify import slugify
from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
from django.conf import settings


# here is a problem with save() so i don't use it at this time
# model is not saving from model form
class Slugged(models.Model):
    """
    Abstract model that handles auto-generating slugs.
    """

    title = models.CharField(_("Title"), max_length=255, default='')
    slug = models.CharField(_("Slug"), max_length=255, unique=True,
                            db_index=True, blank=True)

    class Meta:
        abstract = True
        ordering = ("title",)

    def __unicode__(self):
        return self.title

    def clean(self):
        from django.core.exceptions import ValidationError
        if self.title:
            slug = self.get_slug()
            if not slug:
                raise ValidationError('Please enter a \
                          valid title/name, it must contain at least one character')

    def save(self, *args, **kwargs):
        """
        Create a unique slug by appending an index.
        """
        #super().save(self, *args, **kwargs)
        update_slug = kwargs.pop('update_slug', False)
        #concrete_model = base_concrete_model(Slugged, self)

        new_slug = False
        if not self.slug or update_slug:
            new_slug = True

        if new_slug:
          self.slug = self.get_slug()

    def get_slug(self):
        """
        Allows subclasses to implement their own slug creation logic.
        """
        slug = ''
        # if title is None, slugify returns 'none' as string.
        if self.title is not None:
            slug = slugify(self.title)

        # For titles like !@#$!@#$, slugify returns an empty string.
        if slug == '':
            slug = str(uuid.uuid1())[:7]
        return slug[:256]


class Ad(models.Model):
    title = models.CharField(max_length=255)
    created_at = models.DateTimeField(default=timezone.now)
    changed_at = models.DateTimeField(auto_now=True)
    text = models.TextField(blank=False, null=False)
    specialist_fk = models.ForeignKey("SpecialistApp.Specialist", on_delete=models.CASCADE)


class ServiceRequest(models.Model):
    STATUS_CHOICES = {
        'pending': 'Pending',
        'in_progress': 'In Progress',
        'completed': 'Completed',
        'cancelled': 'Cancelled',
    }

    ad_fk = models.ForeignKey("Ad", on_delete=models.CASCADE)
    user_fk = models.ForeignKey("ProfileApp.Profile", on_delete=models.CASCADE)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    request_date = models.DateTimeField(default=timezone.now)

    class Meta:
        unique_together = ["ad_fk", "user_fk"]


class Comment(models.Model):
    text = models.TextField(blank=False, null=False)
    ad_fk = models.ForeignKey("Ad", on_delete=models.CASCADE)
    user_fk = models.ForeignKey("ProfileApp.Profile", on_delete=models.CASCADE)
    created_at = models.DateTimeField(default=timezone.now)
    class Meta:
        ordering = ['created_at']


