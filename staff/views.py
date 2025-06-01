from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def staff_list(request):
    return render(request, 'staff/staff_list.html')
