
from django.db import models
from patients.models import Patient
from appointments.models import Appointment

class Treatment(models.Model):
    TREATMENT_TYPES = [
        ('cleaning', 'Dental Cleaning'),
        ('filling', 'Dental Filling'),
        ('extraction', 'Tooth Extraction'),
        ('root_canal', 'Root Canal'),
        ('crown', 'Crown'),
        ('bridge', 'Bridge'),
        ('implant', 'Dental Implant'),
        ('orthodontics', 'Orthodontics'),
        ('whitening', 'Teeth Whitening'),
        ('other', 'Other'),
    ]
    
    STATUS_CHOICES = [
        ('planned', 'Planned'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'),
    ]
    
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE, blank=True, null=True)
    treatment_type = models.CharField(max_length=20, choices=TREATMENT_TYPES)
    description = models.TextField()
    status = models.CharField(max_length=15, choices=STATUS_CHOICES, default='planned')
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    date_started = models.DateField(blank=True, null=True)
    date_completed = models.DateField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.patient} - {self.get_treatment_type_display()}"

class MedicalNote(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    treatment = models.ForeignKey(Treatment, on_delete=models.CASCADE, blank=True, null=True)
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE, blank=True, null=True)
    note = models.TextField()
    created_by = models.CharField(max_length=100)  # In production, use User model
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.patient} - {self.created_at.strftime('%Y-%m-%d')}"
