from django.urls import path
from . import views

urlpatterns = [
    path('', views.billing_view, name='billing_home'),
] 
from django.urls import path
from . import views

app_name = 'billing'

urlpatterns = [
    path('', views.billing_list, name='billing_list'),
]
