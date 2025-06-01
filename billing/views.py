
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from .models import Billing
from .forms import InvoiceForm, PaymentForm, GCashPaymentForm, PayMayaPaymentForm, CardPaymentForm
from patients.models import Patient
from appointments.models import Appointment

@login_required
def billing_list(request):
    invoices = Billing.objects.all().order_by('-date_issued')
    
    # Calculate statistics
    total_revenue = sum(invoice.amount for invoice in invoices if invoice.status == 'paid')
    pending_invoices = invoices.filter(status='unpaid').count()
    overdue_amount = sum(invoice.amount for invoice in invoices if invoice.status == 'unpaid')
    this_month_revenue = sum(
        invoice.amount for invoice in invoices 
        if invoice.status == 'paid' and invoice.date_paid and invoice.date_paid.month == timezone.now().month
    )
    
    context = {
        'invoices': invoices[:10],  # Recent 10 invoices
        'total_revenue': total_revenue,
        'pending_invoices': pending_invoices,
        'overdue_amount': overdue_amount,
        'this_month_revenue': this_month_revenue,
    }
    return render(request, 'billing/billing_home.html', context)

@login_required
def create_invoice(request):
    if request.method == 'POST':
        form = InvoiceForm(request.POST)
        if form.is_valid():
            invoice = form.save()
            messages.success(request, f'Invoice created successfully for {invoice.patient}')
            return redirect('billing:invoice_detail', invoice_id=invoice.id)
    else:
        form = InvoiceForm()
    
    return render(request, 'billing/create_invoice.html', {'form': form})

@login_required
def invoice_detail(request, invoice_id):
    invoice = get_object_or_404(Billing, id=invoice_id)
    return render(request, 'billing/invoice_detail.html', {'invoice': invoice})

@login_required
def process_payment(request, invoice_id):
    invoice = get_object_or_404(Billing, id=invoice_id)
    
    if request.method == 'POST':
        payment_method = request.POST.get('payment_method')
        
        if payment_method == 'cash':
            # Process cash payment
            invoice.status = 'paid'
            invoice.date_paid = timezone.now().date()
            invoice.save()
            messages.success(request, 'Cash payment processed successfully!')
            return redirect('billing:invoice_detail', invoice_id=invoice.id)
        
        elif payment_method == 'gcash':
            gcash_form = GCashPaymentForm(request.POST)
            if gcash_form.is_valid():
                # Process GCash payment
                invoice.status = 'paid'
                invoice.date_paid = timezone.now().date()
                invoice.payment_method = 'gcash'
                invoice.notes = f"GCash payment - Ref: {gcash_form.cleaned_data['reference_number']}"
                invoice.save()
                messages.success(request, 'GCash payment processed successfully!')
                return redirect('billing:invoice_detail', invoice_id=invoice.id)
        
        elif payment_method == 'paymaya':
            paymaya_form = PayMayaPaymentForm(request.POST)
            if paymaya_form.is_valid():
                # Process PayMaya payment
                invoice.status = 'paid'
                invoice.date_paid = timezone.now().date()
                invoice.payment_method = 'paymaya'
                invoice.notes = f"PayMaya payment - Ref: {paymaya_form.cleaned_data['reference_number']}"
                invoice.save()
                messages.success(request, 'PayMaya payment processed successfully!')
                return redirect('billing:invoice_detail', invoice_id=invoice.id)
        
        elif payment_method == 'card':
            card_form = CardPaymentForm(request.POST)
            if card_form.is_valid():
                # Process card payment
                invoice.status = 'paid'
                invoice.date_paid = timezone.now().date()
                invoice.payment_method = 'card'
                invoice.notes = f"Card payment - {card_form.cleaned_data['cardholder_name']}"
                invoice.save()
                messages.success(request, 'Card payment processed successfully!')
                return redirect('billing:invoice_detail', invoice_id=invoice.id)
    
    # Initialize forms
    payment_form = PaymentForm()
    gcash_form = GCashPaymentForm()
    paymaya_form = PayMayaPaymentForm()
    card_form = CardPaymentForm()
    
    context = {
        'invoice': invoice,
        'payment_form': payment_form,
        'gcash_form': gcash_form,
        'paymaya_form': paymaya_form,
        'card_form': card_form,
    }
    return render(request, 'billing/process_payment.html', context)

def billing_view(request):
    return render(request, 'billing/billing_home.html', {})
