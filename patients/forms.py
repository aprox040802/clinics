from django import forms
from .models import Patient

class PatientForm(forms.ModelForm):
    class Meta:
        model = Patient
        fields = [
            'first_name', 'last_name', 'date_of_birth', 'gender', 'address',
            'phone', 'email', 'medical_history', 'dental_history'
        ]
        widgets = {
            'date_of_birth': forms.DateInput(attrs={'type': 'date'}),
            'medical_history': forms.Textarea(attrs={'rows': 2}),
            'dental_history': forms.Textarea(attrs={'rows': 2}),
        }
