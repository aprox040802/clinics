from django.urls import path
from . import views

urlpatterns = [
    path('', views.appointment_list, name='appointment_list'),
    path('create/', views.create_appointment, name='create_appointment'),
    path('update/<int:pk>/', views.update_appointment, name='update_appointment'),
    path('available_slots/<str:date>/', views.available_time_slots, name='available_time_slots'),
    path('calendar/', views.calendar_view, name='calendar'),
] 