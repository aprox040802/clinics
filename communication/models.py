
from django.db import models
from patients.models import Patient

class Communication(models.Model):
    COMMUNICATION_TYPES = [
        ('sms', 'SMS'),
        ('email', 'Email'),
        ('call', 'Phone Call'),
        ('notification', 'System Notification'),
    ]
    
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('sent', 'Sent'),
        ('delivered', 'Delivered'),
        ('failed', 'Failed'),
    ]
    
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, blank=True, null=True)
    communication_type = models.CharField(max_length=15, choices=COMMUNICATION_TYPES)
    subject = models.CharField(max_length=200)
    message = models.TextField()
    recipient = models.CharField(max_length=200)  # Phone number or email
    status = models.CharField(max_length=15, choices=STATUS_CHOICES, default='pending')
    scheduled_time = models.DateTimeField(blank=True, null=True)
    sent_time = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.communication_type} to {self.recipient} - {self.subject}"

class NotificationTemplate(models.Model):
    name = models.CharField(max_length=100)
    template_type = models.CharField(max_length=15, choices=Communication.COMMUNICATION_TYPES)
    subject = models.CharField(max_length=200)
    message_template = models.TextField()
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} ({self.template_type})"
