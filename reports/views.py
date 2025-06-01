from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def report_dashboard(request):
    return render(request, 'reports/report_dashboard.html')

def reports_view(request):
    return render(request, 'reports/reports_home.html', {})

def report_dashboard(request):
    return render(request, 'reports/report_dashboard.html', {})
