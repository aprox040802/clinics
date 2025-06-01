

-- MySQL Database Dump for Biteworks Dental Management System
-- Complete database structure with all apps
-- Compatible with phpMyAdmin
-- Database: biteworks_dental

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Create database
CREATE DATABASE IF NOT EXISTS `biteworks_dental` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `biteworks_dental`;

-- --------------------------------------------------------
-- DJANGO CORE TABLES
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

-- Table structure for table `auth_group`
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `auth_permission`
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename` (`content_type_id`,`codename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `django_content_type`
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `django_session`
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for Django migrations
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- PATIENTS APP TABLES
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
-- APPOINTMENTS APP TABLES
-- --------------------------------------------------------

-- Table structure for table `appointments_appointment`
CREATE TABLE `appointments_appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time(6) NOT NULL,
  `appointment_type` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'scheduled',
  `notes` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_appointment_patient_id` (`patient_id`),
  CONSTRAINT `appointments_appointment_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- BILLING APP TABLES
-- --------------------------------------------------------

-- Table structure for table `billing_billing`
CREATE TABLE `billing_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'unpaid',
  `date_issued` date NOT NULL,
  `date_paid` date DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`id`),
  KEY `billing_billing_patient_id` (`patient_id`),
  KEY `billing_billing_appointment_id` (`appointment_id`),
  CONSTRAINT `billing_billing_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`),
  CONSTRAINT `billing_billing_appointment_id_fk` FOREIGN KEY (`appointment_id`) REFERENCES `appointments_appointment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `billing_payment_transaction`
CREATE TABLE `billing_payment_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `billing_id` int(11) NOT NULL,
  `transaction_id` varchar(100) NOT NULL,
  `payment_method` varchar(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `reference_number` varchar(100) DEFAULT NULL,
  `payment_gateway_response` longtext,
  `processed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `billing_payment_transaction_billing_id` (`billing_id`),
  CONSTRAINT `billing_payment_transaction_billing_id_fk` FOREIGN KEY (`billing_id`) REFERENCES `billing_billing` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- TREATMENTS APP TABLES
-- --------------------------------------------------------

-- Table structure for table `treatments_treatment`
CREATE TABLE `treatments_treatment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `duration` int(11) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `category` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `treatments_patienttreatment`
CREATE TABLE `treatments_patienttreatment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `date_performed` date NOT NULL,
  `notes` longtext,
  `status` varchar(20) NOT NULL DEFAULT 'planned',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `treatments_patienttreatment_patient_id` (`patient_id`),
  KEY `treatments_patienttreatment_treatment_id` (`treatment_id`),
  KEY `treatments_patienttreatment_appointment_id` (`appointment_id`),
  CONSTRAINT `treatments_patienttreatment_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`),
  CONSTRAINT `treatments_patienttreatment_treatment_id_fk` FOREIGN KEY (`treatment_id`) REFERENCES `treatments_treatment` (`id`),
  CONSTRAINT `treatments_patienttreatment_appointment_id_fk` FOREIGN KEY (`appointment_id`) REFERENCES `appointments_appointment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- INVENTORY APP TABLES
-- --------------------------------------------------------

-- Table structure for table `inventory_item`
CREATE TABLE `inventory_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `supplier` varchar(200) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `minimum_stock` int(11) NOT NULL DEFAULT 0,
  `category` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- STAFF APP TABLES
-- --------------------------------------------------------

-- Table structure for table `staff_staff`
CREATE TABLE `staff_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `position` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `hire_date` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `staff_staff_user_id` (`user_id`),
  CONSTRAINT `staff_staff_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- REPORTS APP TABLES
-- --------------------------------------------------------

-- Table structure for table `reports_report`
CREATE TABLE `reports_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `report_type` varchar(50) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `generated_by_id` int(11) NOT NULL,
  `generated_at` datetime(6) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_report_generated_by_id` (`generated_by_id`),
  CONSTRAINT `reports_report_generated_by_id_fk` FOREIGN KEY (`generated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- COMMUNICATION APP TABLES
-- --------------------------------------------------------

-- Table structure for table `communication_message`
CREATE TABLE `communication_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `message_type` varchar(20) NOT NULL DEFAULT 'email',
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `sent_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `communication_message_patient_id` (`patient_id`),
  KEY `communication_message_sender_id` (`sender_id`),
  CONSTRAINT `communication_message_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`),
  CONSTRAINT `communication_message_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- SAMPLE DATA
-- --------------------------------------------------------

-- Sample superuser (password: admin123)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$260000$dummyhash', NULL, 1, 'admin', 'Admin', 'User', 'admin@biteworks.com', 1, 1, '2024-01-01 00:00:00.000000');

-- Sample patients
INSERT INTO `patients_patient` (`id`, `first_name`, `last_name`, `email`, `phone`, `address`, `date_of_birth`, `emergency_contact`, `emergency_phone`, `medical_history`, `created_at`, `updated_at`) VALUES
(1, 'Emma', 'Davis', 'emma.davis@email.com', '+1234567890', '123 Main St, City, State 12345', '1990-05-15', 'John Davis', '+1234567891', 'No known allergies', '2024-01-15 10:00:00.000000', '2024-01-15 10:00:00.000000'),
(2, 'Olivia', 'Bennett', 'olivia.bennett@email.com', '+1234567892', '456 Oak Ave, City, State 12345', '1985-08-22', 'Mike Bennett', '+1234567893', 'Allergic to penicillin', '2024-01-16 11:00:00.000000', '2024-01-16 11:00:00.000000'),
(3, 'Noah', 'Carter', 'noah.carter@email.com', '+1234567894', '789 Pine Rd, City, State 12345', '1992-03-10', 'Sarah Carter', '+1234567895', 'History of dental anxiety', '2024-01-17 12:00:00.000000', '2024-01-17 12:00:00.000000');

-- Sample appointments
INSERT INTO `appointments_appointment` (`id`, `patient_id`, `date`, `time`, `appointment_type`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-03-14', '10:00:00.000000', 'short', 'scheduled', 'Regular cleaning and examination', '2024-01-15 10:30:00.000000', '2024-01-15 10:30:00.000000'),
(2, 2, '2024-03-16', '14:30:00.000000', 'short', 'scheduled', 'Deep cleaning required', '2024-01-16 11:30:00.000000', '2024-01-16 11:30:00.000000'),
(3, 3, '2024-03-17', '09:00:00.000000', 'medium', 'completed', 'Cavity filling on molar', '2024-01-17 12:30:00.000000', '2024-01-17 12:30:00.000000');

-- Sample billing records with updated payment methods
INSERT INTO `billing_billing` (`id`, `patient_id`, `appointment_id`, `amount`, `payment_method`, `status`, `date_issued`, `date_paid`, `notes`) VALUES
(1, 1, 1, 150.00, 'cash', 'paid', '2024-03-14', '2024-03-14', 'Paid in full'),
(2, 2, 2, 200.00, 'gcash', 'unpaid', '2024-03-16', NULL, 'Payment pending via GCash'),
(3, 3, 3, 120.00, 'cash', 'paid', '2024-03-17', '2024-03-17', 'Paid after treatment'),
(4, 1, NULL, 80.00, 'paymaya', 'paid', '2024-03-20', '2024-03-20', 'Payment via PayMaya'),
(5, 2, NULL, 350.00, 'card', 'partial', '2024-03-21', NULL, 'Partial payment via credit card'),
(6, 3, NULL, 180.00, 'bdo', 'unpaid', '2024-03-22', NULL, 'BDO bank transfer pending');

-- Sample payment transactions
INSERT INTO `billing_payment_transaction` (`id`, `billing_id`, `transaction_id`, `payment_method`, `amount`, `status`, `reference_number`, `payment_gateway_response`, `processed_at`, `created_at`) VALUES
(1, 2, 'GCASH_TXN_001', 'gcash', 200.00, 'pending', 'GC202403160001', '{"status": "pending", "reference": "GC202403160001"}', NULL, '2024-03-16 14:45:00.000000'),
(2, 4, 'PAYMAYA_TXN_001', 'paymaya', 80.00, 'completed', 'PM202403200001', '{"status": "success", "reference": "PM202403200001"}', '2024-03-20 16:30:00.000000', '2024-03-20 16:25:00.000000'),
(3, 5, 'CARD_TXN_001', 'card', 175.00, 'completed', 'CC202403210001', '{"status": "success", "reference": "CC202403210001"}', '2024-03-21 11:15:00.000000', '2024-03-21 11:10:00.000000'),
(4, 6, 'BDO_TXN_001', 'bdo', 180.00, 'pending', 'BDO202403220001', '{"status": "pending", "reference": "BDO202403220001"}', NULL, '2024-03-22 09:20:00.000000');

-- Sample treatments
INSERT INTO `treatments_treatment` (`id`, `name`, `description`, `duration`, `cost`, `category`, `created_at`, `updated_at`) VALUES
(1, 'Dental Cleaning', 'Professional teeth cleaning and prophylaxis', 60, 100.00, 'Preventive', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(2, 'Tooth Filling', 'Composite resin filling for cavities', 45, 80.00, 'Restorative', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(3, 'Root Canal', 'Root canal therapy for infected teeth', 120, 300.00, 'Endodontic', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(4, 'Teeth Whitening', 'Professional teeth whitening treatment', 90, 200.00, 'Cosmetic', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(5, 'Dental Crown', 'Porcelain crown placement', 120, 450.00, 'Restorative', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000');

-- Sample inventory items
INSERT INTO `inventory_item` (`id`, `name`, `description`, `quantity`, `unit_price`, `supplier`, `expiry_date`, `minimum_stock`, `category`, `created_at`, `updated_at`) VALUES
(1, 'Composite Resin', 'Tooth-colored filling material', 50, 25.00, 'Dental Supply Co', '2025-12-31', 10, 'Materials', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(2, 'Dental Gloves', 'Disposable examination gloves', 1000, 0.15, 'Medical Supplies Inc', '2025-06-30', 100, 'PPE', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(3, 'Local Anesthetic', 'Lidocaine injection for pain relief', 20, 8.50, 'Pharma Dental', '2025-03-15', 5, 'Medications', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(4, 'Dental Mirrors', 'Stainless steel dental mirrors', 25, 12.00, 'Dental Tools Ltd', NULL, 5, 'Instruments', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000'),
(5, 'Sterilization Pouches', 'Self-sealing sterilization pouches', 500, 0.25, 'Sterilization Co', '2025-09-30', 50, 'Sterilization', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000');

-- --------------------------------------------------------
-- AUTO INCREMENT VALUES
-- --------------------------------------------------------

ALTER TABLE `auth_user` AUTO_INCREMENT=2;
ALTER TABLE `auth_group` AUTO_INCREMENT=1;
ALTER TABLE `auth_permission` AUTO_INCREMENT=1;
ALTER TABLE `django_content_type` AUTO_INCREMENT=1;
ALTER TABLE `django_migrations` AUTO_INCREMENT=1;
ALTER TABLE `patients_patient` AUTO_INCREMENT=4;
ALTER TABLE `appointments_appointment` AUTO_INCREMENT=4;
ALTER TABLE `billing_billing` AUTO_INCREMENT=7;
ALTER TABLE `billing_payment_transaction` AUTO_INCREMENT=5;
ALTER TABLE `treatments_treatment` AUTO_INCREMENT=6;
ALTER TABLE `treatments_patienttreatment` AUTO_INCREMENT=1;
ALTER TABLE `inventory_item` AUTO_INCREMENT=6;
ALTER TABLE `staff_staff` AUTO_INCREMENT=1;
ALTER TABLE `reports_report` AUTO_INCREMENT=1;
ALTER TABLE `communication_message` AUTO_INCREMENT=1;

COMMIT;

