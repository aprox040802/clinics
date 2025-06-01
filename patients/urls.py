
from django.urls import path
from . import views

app_name = 'patients'

urlpatterns = [
    path('', views.patient_list_view, name='patient_list'),
    path('register/', views.patient_list_view, name='register_patient'),
]
