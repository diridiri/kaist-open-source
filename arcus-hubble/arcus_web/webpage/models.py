from django.db import models

# Create your models here.

class Count(models.Model):
        countname = models.CharField(max_length = 20,default="total_greetings")
        count = models.IntegerField(default=0)
        def __str__(self):
                return self.countname
