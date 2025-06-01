
from django.urls import path
from . import views

app_name = 'reports'

urlpatterns = [
    path('', views.report_dashboard, name='report_dashboard'),
    path('dashboard/', views.report_dashboard, name='report_dashboard_alt'),
]
