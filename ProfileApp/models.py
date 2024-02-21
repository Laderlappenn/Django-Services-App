from django.db import models
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.models import AbstractBaseUser, UserManager
from django.core.validators import RegexValidator
# Create your models here.


class ProfileManager(UserManager):
    def create_user(self, email, password, is_admin=False,
                                           is_stuff=False,
                                           is_superuser=False):
        if not email:
            raise ValueError('Users must have an email address')
        if not password:
            raise ValueError('Users must have a password')

        user = self.model(
            email=self.normalize_email(email),
        )
        user.set_password(password)
        user.is_admin = is_admin
        user.is_staff = is_stuff
        user.is_superuser = is_superuser
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password):
        return self.create_user(email, password, is_admin=True,
                                                 is_stuff=True,
                                                 is_superuser=True)


class Profile(AbstractBaseUser, PermissionsMixin):
    username = None
    email = models.EmailField(unique=True)
    image = models.ImageField(upload_to='profile_images/')  # MEDIA_ROOT / profile_images
    is_admin = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$',
                                 message="Phone number must be entered\
                                          in the format: '+999999999'.\
                                          Up to 15 digits allowed.")
    phone_number = models.CharField(validators=[phone_regex], max_length=17, blank=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ["password", ]

    objects = ProfileManager()
