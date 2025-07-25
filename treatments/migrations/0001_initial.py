# Generated by Django 5.2 on 2025-06-01 15:45

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('appointments', '0001_initial'),
        ('patients', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Treatment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('treatment_type', models.CharField(choices=[('cleaning', 'Dental Cleaning'), ('filling', 'Dental Filling'), ('extraction', 'Tooth Extraction'), ('root_canal', 'Root Canal'), ('crown', 'Crown'), ('bridge', 'Bridge'), ('implant', 'Dental Implant'), ('orthodontics', 'Orthodontics'), ('whitening', 'Teeth Whitening'), ('other', 'Other')], max_length=20)),
                ('description', models.TextField()),
                ('status', models.CharField(choices=[('planned', 'Planned'), ('in_progress', 'In Progress'), ('completed', 'Completed'), ('cancelled', 'Cancelled')], default='planned', max_length=15)),
                ('cost', models.DecimalField(decimal_places=2, max_digits=10)),
                ('date_started', models.DateField(blank=True, null=True)),
                ('date_completed', models.DateField(blank=True, null=True)),
                ('notes', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('appointment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='appointments.appointment')),
                ('patient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='patients.patient')),
            ],
        ),
        migrations.CreateModel(
            name='MedicalNote',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('note', models.TextField()),
                ('created_by', models.CharField(max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('appointment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='appointments.appointment')),
                ('patient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='patients.patient')),
                ('treatment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='treatments.treatment')),
            ],
        ),
    ]
