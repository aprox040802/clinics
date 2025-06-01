
from django.db import models

class Report(models.Model):
    REPORT_TYPES = [
        ('daily_appointments', 'Daily Appointments'),
        ('monthly_revenue', 'Monthly Revenue'),
        ('patient_visits', 'Patient Visit History'),
        ('inventory_status', 'Inventory Status'),
        ('staff_schedule', 'Staff Schedule'),
        ('treatment_summary', 'Treatment Summary'),
    ]
    
    name = models.CharField(max_length=200)
    report_type = models.CharField(max_length=25, choices=REPORT_TYPES)
    description = models.TextField(blank=True, null=True)
    generated_by = models.CharField(max_length=100)  # In production, use User model
    generated_at = models.DateTimeField(auto_now_add=True)
    parameters = models.JSONField(blank=True, null=True)  # Store report parameters
    file_path = models.CharField(max_length=500, blank=True, null=True)  # Path to generated file

    def __str__(self):
        return f"{self.name} - {self.generated_at.strftime('%Y-%m-%d')}"

    class Meta:
        ordering = ['-generated_at']
