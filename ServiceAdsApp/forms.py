from django.forms import ModelForm


from ServiceAdsApp.models import Ad

class CreateAdForm(ModelForm):
    class Meta:
        model = Ad
        fields = ["title","text",]
