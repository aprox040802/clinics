from django.shortcuts import render, redirect, get_object_or_404
from .models import Appointment
from .forms import AppointmentForm
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse

# Create your views here.

@login_required
def appointment_list(request):
    appointments = Appointment.objects.all().order_by('date', 'time')
    return render(request, 'appointments/appointment_list.html', {'appointments': appointments})

@login_required
def create_appointment(request):
    if request.method == 'POST':
        form = AppointmentForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('appointment_list')
    else:
        form = AppointmentForm()
    return render(request, 'appointments/create_appointment.html', {'form': form})

@login_required
def update_appointment(request, pk):
    appointment = get_object_or_404(Appointment, pk=pk)
    if request.method == 'POST':
        form = AppointmentForm(request.POST, instance=appointment)
        if form.is_valid():
            form.save()
            return redirect('appointment_list')
    else:
        form = AppointmentForm(instance=appointment)
    return render(request, 'appointments/update_appointment.html', {'form': form})

@login_required
def calendar_view(request):
    return render(request, 'appointments/calendar.html')

def available_time_slots(request, date):
    # In a real application, you would fetch available slots based on the date
    # from your database here.
    # This is just dummy data for demonstration:
    dummy_slots = [
        '9:00 AM - 9:30 AM',
        '10:00 AM - 10:30 AM',
        '11:00 AM - 11:30 AM',
        '1:00 PM - 1:30 PM',
        '2:00 PM - 2:30 PM',
    ]
    return JsonResponse({'date': date, 'slots': dummy_slots})
