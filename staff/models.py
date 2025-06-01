
from django.db import models

class Staff(models.Model):
    ROLE_CHOICES = [
        ('dentist', 'Dentist'),
        ('hygienist', 'Dental Hygienist'),
        ('assistant', 'Dental Assistant'),
        ('receptionist', 'Receptionist'),
        ('manager', 'Office Manager'),
    ]
    
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    role = models.CharField(max_length=15, choices=ROLE_CHOICES)
    email = models.EmailField()
    phone = models.CharField(max_length=20)
    hire_date = models.DateField()
    is_active = models.BooleanField(default=True)
    schedule = models.TextField(blank=True, null=True)  # JSON field for schedule
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name} - {self.get_role_display()}"

    class Meta:
        verbose_name_plural = "Staff"
