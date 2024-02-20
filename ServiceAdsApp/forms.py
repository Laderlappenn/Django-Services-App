from django import forms


from ServiceAdsApp.models import Ad, Comment, ServiceRequest


class CreateAdForm(forms.ModelForm):
    class Meta:
        model = Ad
        fields = ["title", "image", "text",]


class CreateCommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ["text",]


# using model based form because status field can be changed
class ChangeServiceRequestStatus(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)



    class Meta:
        model = ServiceRequest
        fields = ["status",]
