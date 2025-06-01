
from django.urls import path
from . import views

app_name = 'billing'

urlpatterns = [
    path('', views.billing_list, name='billing_list'),
    path('home/', views.billing_view, name='billing_home'),
    path('invoices/', views.billing_list, name='invoice_list'),
    path('create/', views.billing_list, name='create_invoice'),
]
