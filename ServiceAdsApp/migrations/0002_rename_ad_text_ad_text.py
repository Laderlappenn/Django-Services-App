# Generated by Django 5.0.1 on 2024-02-01 04:59

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ServiceAdsApp', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='ad',
            old_name='ad_text',
            new_name='text',
        ),
    ]
