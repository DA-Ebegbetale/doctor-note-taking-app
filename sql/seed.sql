USE doctor_notes_app;

-- password: Doctor@123 (hashed using PHP password_hash)
INSERT INTO users (uuid, first_name, last_name, middle_name, email, phone, password_hash, role, is_active)
VALUES
('11111111-1111-1111-1111-111111111111', 'Demo', 'Doctor', '', 'doctor@example.com', '+2300000000', '$2y$10$wH8n4I2c1P5wKfL8Qj9YVuA5G4j8d7vN2bS3wQq1x7YtBz8yH6R0e', 'doctor', 1);