
-- MySQL Database Dump for Biteworks Dental Management System
-- Compatible with phpMyAdmin
-- Database: biteworks_dental

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Create database
CREATE DATABASE IF NOT EXISTS `biteworks_dental` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `biteworks_dental`;

-- --------------------------------------------------------

-- Table structure for table `auth_user`
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `patients_patient`
CREATE TABLE `patients_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `date_of_birth` date NOT NULL,
  `emergency_contact` varchar(100) NOT NULL,
  `emergency_phone` varchar(20) NOT NULL,
  `medical_history` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `appointments_appointment`
CREATE TABLE `appointments_appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time(6) NOT NULL,
  `treatment_type` varchar(200) NOT NULL,
  `status` varchar(20) NOT NULL,
  `notes` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_appointment_patient_id` (`patient_id`),
  CONSTRAINT `appointments_appointment_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `billing_invoice`
CREATE TABLE `billing_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoice_number` (`invoice_number`),
  KEY `billing_invoice_patient_id` (`patient_id`),
  KEY `billing_invoice_appointment_id` (`appointment_id`),
  CONSTRAINT `billing_invoice_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`),
  CONSTRAINT `billing_invoice_appointment_id_fk` FOREIGN KEY (`appointment_id`) REFERENCES `appointments_appointment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Sample data for patients
INSERT INTO `patients_patient` (`id`, `first_name`, `last_name`, `email`, `phone`, `address`, `date_of_birth`, `emergency_contact`, `emergency_phone`, `medical_history`, `created_at`, `updated_at`) VALUES
(1, 'Emma', 'Davis', 'emma.davis@email.com', '+1234567890', '123 Main St, City, State 12345', '1990-05-15', 'John Davis', '+1234567891', 'No known allergies', '2024-01-15 10:00:00.000000', '2024-01-15 10:00:00.000000'),
(2, 'Olivia', 'Bennett', 'olivia.bennett@email.com', '+1234567892', '456 Oak Ave, City, State 12345', '1985-08-22', 'Mike Bennett', '+1234567893', 'Allergic to penicillin', '2024-01-16 11:00:00.000000', '2024-01-16 11:00:00.000000'),
(3, 'Noah', 'Carter', 'noah.carter@email.com', '+1234567894', '789 Pine Rd, City, State 12345', '1992-03-10', 'Sarah Carter', '+1234567895', 'History of dental anxiety', '2024-01-17 12:00:00.000000', '2024-01-17 12:00:00.000000');

-- --------------------------------------------------------

-- Sample data for appointments
INSERT INTO `appointments_appointment` (`id`, `patient_id`, `appointment_date`, `appointment_time`, `treatment_type`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-03-14', '10:00:00.000000', 'Routine Checkup', 'Scheduled', 'Regular cleaning and examination', '2024-01-15 10:30:00.000000', '2024-01-15 10:30:00.000000'),
(2, 2, '2024-03-16', '14:30:00.000000', 'Teeth Cleaning', 'Scheduled', 'Deep cleaning required', '2024-01-16 11:30:00.000000', '2024-01-16 11:30:00.000000'),
(3, 3, '2024-03-17', '09:00:00.000000', 'Filling', 'Confirmed', 'Cavity filling on molar', '2024-01-17 12:30:00.000000', '2024-01-17 12:30:00.000000');

-- --------------------------------------------------------

-- Sample data for billing
INSERT INTO `billing_invoice` (`id`, `patient_id`, `appointment_id`, `invoice_number`, `amount`, `status`, `payment_method`, `payment_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'INV-2024-001', 150.00, 'Paid', 'Cash', '2024-03-14', '2024-03-14 15:00:00.000000', '2024-03-14 15:00:00.000000'),
(2, 2, 2, 'INV-2024-002', 200.00, 'Pending', 'GCash', NULL, '2024-03-16 16:00:00.000000', '2024-03-16 16:00:00.000000'),
(3, 3, 3, 'INV-2024-003', 120.00, 'Paid', 'Cash', '2024-03-17', '2024-03-17 10:00:00.000000', '2024-03-17 10:00:00.000000');

-- --------------------------------------------------------

-- Table structure for Django migrations
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Auto increment values
ALTER TABLE `auth_user` AUTO_INCREMENT=1;
ALTER TABLE `patients_patient` AUTO_INCREMENT=4;
ALTER TABLE `appointments_appointment` AUTO_INCREMENT=4;
ALTER TABLE `billing_invoice` AUTO_INCREMENT=4;
ALTER TABLE `django_migrations` AUTO_INCREMENT=1;

COMMIT;
