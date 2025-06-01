from django.db import models
from django.contrib.auth.models import User

class Report(models.Model):
    REPORT_TYPES = [
        ('financial', 'Financial Report'),
        ('patient', 'Patient Report'),
        ('appointment', 'Appointment Report'),
        ('inventory', 'Inventory Report'),
    ]

    title = models.CharField(max_length=200)
    report_type = models.CharField(max_length=20, choices=REPORT_TYPES)
    date_from = models.DateField()
    date_to = models.DateField()
    generated_by = models.ForeignKey(User, on_delete=models.CASCADE)
    generated_at = models.DateTimeField(auto_now_add=True)
    file_path = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return self.title