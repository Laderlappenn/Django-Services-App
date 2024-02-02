from django import forms
from django.contrib.auth.forms import UserCreationForm
from ProfileApp.models import Profile
from SpecialistApp.models import Specialist
from django.core.exceptions import ValidationError

class SpecialistRegistrationForm(UserCreationForm):
    email = forms.EmailField(max_length=255, required=True, help_text="Enter a valid email ")
    specialization = forms.ChoiceField(choices=Specialist.SPECIALIZATION_CHOICES)  # the whole model only for choices field

    class Meta(UserCreationForm.Meta):
        model = Profile
        fields = UserCreationForm.Meta.fields + ('email',)
        exclude = ['username', ]  # must be specified explicitly

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Add any additional customization for form fields if needed
        # Example: self.fields['username'].widget.attrs.update({'class': 'your-custom-class'})

    def clean_email(self): # check for change forms
        email = self.cleaned_data['email']
        if Profile.objects.filter(email=email).exists():
            raise ValidationError("Email already exists")
        return email

    def save(self):
        profile = super().save()
        specialization = self.cleaned_data['specialization']
        Specialist(specialization=specialization, user_id=profile.id).save()
