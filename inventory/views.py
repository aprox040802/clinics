from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from .models import InventoryItem

@login_required
def inventory_list(request):
    items = InventoryItem.objects.all()
    return render(request, 'inventory/inventory_list.html', {'items': items})
