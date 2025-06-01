
from django.urls import path
from . import views

app_name = 'treatments'

urlpatterns = [
    path('', views.treatment_list, name='treatment_list'),
]
