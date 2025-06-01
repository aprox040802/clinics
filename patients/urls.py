from django.urls import path
from . import views

urlpatterns = [
    path('', views.patient_list_view, name='patient_list'),
] 