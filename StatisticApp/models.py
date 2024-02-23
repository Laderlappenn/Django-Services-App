from django.db import models


class Visits(models.Model):
    path = models.CharField(max_length=255, unique=True)
    count = models.IntegerField(default=0)

    def count_visit(self):
        self.count += 1
        self.save()

