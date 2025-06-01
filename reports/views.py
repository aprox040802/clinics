from django.shortcuts import render

# Create your views here.

def reports_view(request):
    return render(request, 'reports/reports_home.html', {})

def report_dashboard(request):
    return render(request, 'reports/report_dashboard.html', {})
