from django.db import models
from patients.models import Patient

class Appointment(models.Model):
    APPOINTMENT_TYPES = [
        ("short", "Short (Check-up, Prophylaxis)"),
        ("medium", "Medium (Fillings, Simple Procedures)"),
        ("long", "Long (Root Canals, Extractions, Braces)")
    ]
    STATUS_CHOICES = [
        ("scheduled", "Scheduled"),
        ("completed", "Completed"),
        ("cancelled", "Cancelled")
    ]
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    date = models.DateField()
    time = models.TimeField()
    appointment_type = models.CharField(max_length=10, choices=APPOINTMENT_TYPES)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="scheduled")
    notes = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.patient} - {self.date} {self.time}"
