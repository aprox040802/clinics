
from django import forms
from .models import Billing
from patients.models import Patient
from appointments.models import Appointment

class InvoiceForm(forms.ModelForm):
    class Meta:
        model = Billing
        fields = ['patient', 'appointment', 'amount', 'payment_method', 'notes']
        widgets = {
            'patient': forms.Select(attrs={'class': 'form-control'}),
            'appointment': forms.Select(attrs={'class': 'form-control'}),
            'amount': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01'}),
            'payment_method': forms.Select(attrs={'class': 'form-control'}),
            'notes': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['appointment'].required = False
        self.fields['notes'].required = False

class PaymentForm(forms.ModelForm):
    class Meta:
        model = Billing
        fields = ['payment_method']
        widgets = {
            'payment_method': forms.RadioSelect(attrs={'class': 'form-check-input'}),
        }

class GCashPaymentForm(forms.Form):
    gcash_number = forms.CharField(
        max_length=15,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': '09XXXXXXXXX'
        })
    )
    reference_number = forms.CharField(
        max_length=50,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter reference number'
        })
    )

class PayMayaPaymentForm(forms.Form):
    paymaya_number = forms.CharField(
        max_length=15,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': '09XXXXXXXXX'
        })
    )
    reference_number = forms.CharField(
        max_length=50,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter reference number'
        })
    )

class CardPaymentForm(forms.Form):
    card_number = forms.CharField(
        max_length=19,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': '1234 5678 9012 3456'
        })
    )
    expiry_date = forms.CharField(
        max_length=5,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'MM/YY'
        })
    )
    cvv = forms.CharField(
        max_length=4,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'CVV'
        })
    )
    cardholder_name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Cardholder Name'
        })
    )
