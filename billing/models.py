from django.db import models
from patients.models import Patient
from appointments.models import Appointment

class Billing(models.Model):
    PAYMENT_METHODS = [
        ("cash", "Cash"),
        ("gcash", "GCash"),
        ("paymaya", "PayMaya"),
        ("card", "Credit/Debit Card"),
        ("bdo", "BDO Bank Transfer")
    ]
    STATUS_CHOICES = [
        ("unpaid", "Unpaid"),
        ("paid", "Paid"),
        ("partial", "Partial")
    ]
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE, blank=True, null=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHODS)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="unpaid")
    date_issued = models.DateField(auto_now_add=True)
    date_paid = models.DateField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.patient} - {self.amount} ({self.status})"
