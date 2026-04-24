CREATE DATABASE IF NOT EXISTS doctor_note_taking_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE doctor_note_taking_db;

-- USERS (Doctors)
CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  uuid CHAR(36) NOT NULL UNIQUE,
  first_name VARCHAR(120) NOT NULL,
  last_name VARCHAR(120) NOT NULL,
  middle_name VARCHAR(120) NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(25) NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('doctor','admin') NOT NULL DEFAULT 'doctor',
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  last_login_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_users_phone (phone),
  INDEX idx_users_is_active (is_active)
) ENGINE=InnoDB;

-- PATIENTS
CREATE TABLE IF NOT EXISTS patients (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  uuid CHAR(36) NOT NULL UNIQUE,
  doctor_id BIGINT UNSIGNED NOT NULL,
  first_name VARCHAR(120) NOT NULL,
  last_name VARCHAR(120) NOT NULL,
  middle_name VARCHAR(120) NULL,
  date_of_birth DATE NULL,
  sex ENUM('male','female','other') NULL,
  phone VARCHAR(25) NULL,
  email VARCHAR(120) NULL,
  address_line VARCHAR(255) NULL,
  emergency_contact_name VARCHAR(120) NULL,
  emergency_contact_phone VARCHAR(25) NULL,
  blood_group VARCHAR(5) NULL,
  allergies TEXT NULL,
  chronic_conditions TEXT NULL,
  archived_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_patients_doctor
    FOREIGN KEY (doctor_id) REFERENCES users(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX idx_patients_doctor_id (doctor_id),
  INDEX idx_patients_first_name (first_name),
  INDEX idx_patients_last_name (last_name),
  INDEX idx_patients_name (last_name, first_name),
  INDEX idx_patients_phone (phone),
  INDEX idx_patients_email (email)
) ENGINE=InnoDB;

-- CONSULTATIONS (Structured notes)
CREATE TABLE IF NOT EXISTS consultations (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  uuid CHAR(36) NOT NULL UNIQUE,
  patient_id BIGINT UNSIGNED NOT NULL,
  doctor_id BIGINT UNSIGNED NOT NULL,
  visit_datetime DATETIME NOT NULL,
  chief_complaint TEXT NOT NULL,
  history_of_present_illness TEXT NULL,
  vitals JSON NULL,
  assessment TEXT NULL,
  diagnosis TEXT NULL,
  plan TEXT NULL,
  prescription TEXT NULL,
  follow_up_date DATE NULL,
  additional_notes TEXT NULL,
  archived_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_consultations_patient
    FOREIGN KEY (patient_id) REFERENCES patients(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_consultations_doctor
    FOREIGN KEY (doctor_id) REFERENCES users(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX idx_consultations_doctor_id (doctor_id),
  INDEX idx_consultations_visit_datetime (visit_datetime),
  INDEX idx_consultations_patient_visit (patient_id, visit_datetime)
) ENGINE=InnoDB;