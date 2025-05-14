/*Create database called clinic*/
CREATE DATABASE clinic;

/*Create Specializations table*/
CREATE TABLE Specializations (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

/*Create Doctors table*/
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    specialization_id INT,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

/*Create Patients table*/
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

/*Create Appointments table*/
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

/*Create Prescriptions table*/
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

/*Create Medications table*/
CREATE TABLE Medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50)
);

/*Create many-to-many relation between Prescriptions and Medications*/
CREATE TABLE Appointment_Medication (
    prescription_id INT,
    medication_id INT,
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

/*Get all appointments with patient and doctor names*/
SELECT 
    a.appointment_id,
    p.full_name AS patient,
    d.full_name AS doctor,
    a.appointment_date,
    a.notes
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

/*View medications prescribed to a patient*/
SELECT 
    pa.full_name AS patient,
    m.name AS medication,
    m.dosage
FROM Patients pa
JOIN Appointments ap ON pa.patient_id = ap.patient_id
JOIN Prescriptions pr ON ap.appointment_id = pr.appointment_id
JOIN Appointment_Medication am ON pr.prescription_id = am.prescription_id
JOIN Medications m ON am.medication_id = m.medication_id;

