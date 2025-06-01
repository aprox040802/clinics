
from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def billing_list(request):
    return render(request, 'billing/billing_home.html')

@login_required
def create_invoice(request):
    return render(request, 'billing/billing_home.html')

@login_required
def invoice_detail(request, invoice_id):
    return render(request, 'billing/billing_home.html')

def billing_view(request):
    return render(request, 'billing/billing_home.html', {})
