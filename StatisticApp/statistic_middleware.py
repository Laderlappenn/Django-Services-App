from .models import Visits

class StatisticMiddleware(object):
    def __init__(self, get_response):
        """
        One-time configuration and initialisation.
        """
        self.get_response = get_response

    def __call__(self, request):
        """
        Code to be executed for each request before the view (and later
        middleware) are called.
        """
        response = self.get_response(request)
        """
        Code to be executed for each request/response after
        the view is called.
        """
        # if use request.get_full_path() url parameters will be attached too
        path = request.path

        # alternative https://docs.djangoproject.com/en/5.0/ref/models/querysets/ # get-or-create
        try:
            visit = Visits.objects.get(path=path)
            visit.count_visit()
            visit.save()
        except Visits.DoesNotExist:
            visit = Visits(path=path, count=1)
            visit.save()

        return response

    def process_view(self, request, view_func, view_args, view_kwargs):
        """
        Called just before Django calls the view.
        """
        return None

    def process_exception(self, request, exception):
        """
        Called when a view raises an exception.
        """
        return None

    def process_template_response(self, request, response):
        """
        Called just after the view has finished executing.
        """
        return response
