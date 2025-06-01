
from django.urls import path
from . import views

app_name = 'reports'

urlpatterns = [
    path('', views.report_dashboard, name='report_dashboard'),
    path('financial/', views.financial_report, name='financial_report'),
    path('appointments/', views.appointment_report, name='appointment_report'),
    path('patients/', views.patient_report, name='patient_report'),
]
