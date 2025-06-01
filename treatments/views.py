from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def treatment_list(request):
    return render(request, 'treatments/treatment_list.html')
