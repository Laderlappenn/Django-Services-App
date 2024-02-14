from django.contrib.auth.backends import ModelBackend, UserModel


class Backend(ModelBackend):
    # i overrode get user and resolved n+1 problem with specialist
    def get_user(self, user_id):
        try:
            user = UserModel.objects.select_related("specialist").get(pk=user_id)
        except UserModel.DoesNotExist:
            return None
        return user if self.user_can_authenticate(user) else None
