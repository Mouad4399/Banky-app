from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    username= models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    is_staff= models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']


    def __str__(self):
        return self.username