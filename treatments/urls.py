
from django.urls import path
from . import views

app_name = 'treatments'

urlpatterns = [
    path('', views.treatment_list, name='treatment_list'),
    path('create/', views.create_treatment, name='create_treatment'),
    path('<int:treatment_id>/', views.treatment_detail, name='treatment_detail'),
]
