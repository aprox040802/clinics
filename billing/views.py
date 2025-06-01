from django.shortcuts import render

# Create your views here.

def billing_view(request):
    return render(request, 'billing/billing_home.html', {})
