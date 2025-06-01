
from django.db import models

class InventoryItem(models.Model):
    CATEGORY_CHOICES = [
        ('dental_supplies', 'Dental Supplies'),
        ('equipment', 'Equipment'),
        ('medication', 'Medication'),
        ('consumables', 'Consumables'),
        ('instruments', 'Instruments'),
    ]
    
    name = models.CharField(max_length=200)
    category = models.CharField(max_length=20, choices=CATEGORY_CHOICES)
    description = models.TextField(blank=True, null=True)
    quantity_in_stock = models.IntegerField(default=0)
    minimum_stock_level = models.IntegerField(default=5)
    unit_cost = models.DecimalField(max_digits=10, decimal_places=2)
    supplier = models.CharField(max_length=200, blank=True, null=True)
    last_ordered = models.DateField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.name} ({self.quantity_in_stock} in stock)"

    @property
    def needs_reorder(self):
        return self.quantity_in_stock <= self.minimum_stock_level

class InventoryMovement(models.Model):
    MOVEMENT_TYPES = [
        ('in', 'Stock In'),
        ('out', 'Stock Out'),
        ('adjustment', 'Adjustment'),
    ]
    
    item = models.ForeignKey(InventoryItem, on_delete=models.CASCADE)
    movement_type = models.CharField(max_length=15, choices=MOVEMENT_TYPES)
    quantity = models.IntegerField()
    reason = models.CharField(max_length=200)
    date = models.DateTimeField(auto_now_add=True)
    notes = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.item.name} - {self.movement_type} {self.quantity}"
