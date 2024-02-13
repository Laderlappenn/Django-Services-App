from django.forms import ModelForm


from ServiceAdsApp.models import Ad, Comment

class CreateAdForm(ModelForm):
    class Meta:
        model = Ad
        fields = ["title","text",]


class CreateCommentForm(ModelForm):
    class Meta:
        model = Comment
        fields = ["text",]
