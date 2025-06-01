from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from datetime import datetime
from patients.models import Patient
from appointments.models import Appointment
from billing.models import Billing

# Create your views here.

@login_required
def dashboard(request):
    today = timezone.now().date()
    current_month = timezone.now().month
    current_year = timezone.now().year
    
    # Get dashboard statistics
    todays_appointments = Appointment.objects.filter(date=today).count()
    total_patients = Patient.objects.count()
    pending_bills = Billing.objects.filter(status='unpaid').count()
    monthly_revenue = Billing.objects.filter(
        status='paid',
        date_paid__month=current_month,
        date_paid__year=current_year
    ).aggregate(total=sum('amount'))['total'] or 0
    
    context = {
        'todays_appointments': todays_appointments,
        'total_patients': total_patients,
        'pending_bills': pending_bills,
        'monthly_revenue': monthly_revenue,
    }
    
    return render(request, 'core/dashboard.html', context)

@login_required
def profile(request):
    return render(request, 'core/profile.html')
