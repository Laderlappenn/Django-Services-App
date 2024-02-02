# Generated by Django 5.0.1 on 2024-02-02 06:54

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SpecialistApp', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.RemoveField(
            model_name='specialist',
            name='last_login',
        ),
        migrations.RemoveField(
            model_name='specialist',
            name='password',
        ),
        migrations.AddField(
            model_name='specialist',
            name='user',
            field=models.OneToOneField(default=0, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]
