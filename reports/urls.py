from django.urls import path
from . import views

urlpatterns = [
    path('', views.reports_view, name='reports_home'),
    path('dashboard/', views.report_dashboard, name='report_dashboard'),
] 
from django.urls import path
from . import views

app_name = 'reports'

urlpatterns = [
    path('', views.report_dashboard, name='report_dashboard'),
]
