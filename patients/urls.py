
from django.urls import path
from . import views

app_name = 'patients'

urlpatterns = [
    path('', views.patient_list_view, name='patient_list'),
    path('register/', views.register_patient, name='register_patient'),
    path('<int:patient_id>/', views.patient_detail, name='patient_detail'),
    path('<int:patient_id>/edit/', views.edit_patient, name='edit_patient'),
]
