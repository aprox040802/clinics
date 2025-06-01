
from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def report_dashboard(request):
    return render(request, 'reports/report_dashboard.html')

@login_required
def financial_report(request):
    return render(request, 'reports/report_dashboard.html')

@login_required
def appointment_report(request):
    return render(request, 'reports/report_dashboard.html')

@login_required
def patient_report(request):
    return render(request, 'reports/report_dashboard.html')

def reports_view(request):
    return render(request, 'reports/report_dashboard.html', {})
