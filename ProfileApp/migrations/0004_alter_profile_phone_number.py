# Generated by Django 5.0.1 on 2024-02-01 03:58

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ProfileApp', '0003_profile_groups_profile_is_superuser_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='phone_number',
            field=models.CharField(blank=True, max_length=17, validators=[django.core.validators.RegexValidator(message="Phone number must be entered                                          in the format: '+999999999'.                                          Up to 15 digits allowed.", regex='^\\+?1?\\d{9,15}$')]),
        ),
    ]
