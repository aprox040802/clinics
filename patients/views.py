from django.shortcuts import render

# Create your views here.
def patient_list_view(request):
    return render(request, 'index.html')
