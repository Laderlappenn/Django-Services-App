from django import forms
from django.contrib.auth.forms import UserCreationForm
from ProfileApp.models import Profile


class ProfileForm(UserCreationForm):
    email = forms.EmailField(max_length=255, required=True, help_text="Enter a valid email ")

    class Meta(UserCreationForm.Meta):
        model = Profile
        fields = UserCreationForm.Meta.fields + ('email',)
        exclude = ['username', ]  # must be specified explicitly

    def __init__(self, *args, **kwargs):
        super(ProfileForm, self).__init__(*args, **kwargs)
        # Add any additional customization for form fields if needed
        # Example: self.fields['username'].widget.attrs.update({'class': 'your-custom-class'})
