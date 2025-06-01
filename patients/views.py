
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse

@login_required
def patient_list_view(request):
    return render(request, 'patients/patient_list.html')

@login_required  
def register_patient(request):
    return render(request, 'patients/patient_list.html')

@login_required
def patient_detail(request, patient_id):
    return render(request, 'patients/patient_list.html')

@login_required
def edit_patient(request, patient_id):
    return render(request, 'patients/patient_list.html')
