from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
from django.conf import settings
from SpecialistApp.models import Specialist


class SpecialistRegistrationForm(UserCreationForm):
    # class Meta(UserCreationForm.Meta):
    #     model = settings.AUTH_USER_MODEL
    #     field = ["email","password"]
    pass