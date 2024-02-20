from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from ProfileApp.models import Profile
from django.core.exceptions import ValidationError


class ProfileRegistrationForm(UserCreationForm):
    email = forms.EmailField(max_length=255, required=True, help_text="Enter a valid email ")

    class Meta(UserCreationForm.Meta):
        model = Profile
        fields = UserCreationForm.Meta.fields + ('email',)
        exclude = ['username', ]  # must be specified explicitly

    def __init__(self, *args, **kwargs):
        super(ProfileRegistrationForm, self).__init__(*args, **kwargs)
        # Add any additional customization for form fields if needed
        # Example: self.fields['username'].widget.attrs.update({'class': 'your-custom-class'})

    def clean_email(self): # check for change forms
        email = self.cleaned_data['email']
        if Profile.objects.filter(email=email).exists():
            raise ValidationError("Email already exists")
        return email


class LoginForm(AuthenticationForm):

    class Meta:
        exclude = ['username', ]
