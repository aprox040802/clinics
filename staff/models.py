from django.db import models
from django.contrib.auth.models import User

class Staff(models.Model):
    POSITION_CHOICES = [
        ('dentist', 'Dentist'),
        ('hygienist', 'Dental Hygienist'),
        ('assistant', 'Dental Assistant'),
        ('receptionist', 'Receptionist'),
        ('manager', 'Office Manager'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    employee_id = models.CharField(max_length=20, unique=True)
    position = models.CharField(max_length=20, choices=POSITION_CHOICES)
    phone = models.CharField(max_length=20)
    address = models.TextField()
    hire_date = models.DateField()
    salary = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.get_full_name()} - {self.position}"