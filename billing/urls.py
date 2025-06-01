from django.urls import path
from . import views

urlpatterns = [
    path('', views.billing_view, name='billing_home'),
] 