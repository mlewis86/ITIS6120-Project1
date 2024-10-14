-- Create the Emergency_Department database
CREATE DATABASE Emergency_Department;

-- Use the Emergency_Department database
USE Emergency_Department;

-- Create the Insurance table
CREATE TABLE Insurance (
    insurance_id INT PRIMARY KEY AUTO_INCREMENT,
    insurance_provider VARCHAR(100) NOT NULL,
    policy_number VARCHAR(50) NOT NULL UNIQUE
);

-- Create the Patients table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    sex CHAR(1) NOT NULL CHECK (sex IN ('M', 'F', 'O')),
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    insurance_id INT NOT NULL,
    CONSTRAINT fk_insurance FOREIGN KEY (insurance_id) REFERENCES Insurance(insurance_id)
);

-- Create the Providers table
CREATE TABLE Providers (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Visits table
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    provider_id INT NOT NULL,
    visit_time DATETIME NOT NULL,
    discharge_time DATETIME NOT NULL,
    reason_for_visit TEXT NOT NULL,
    triage_level VARCHAR(50) NOT NULL,
    CONSTRAINT fk_patient_visit FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    CONSTRAINT fk_provider_visit FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);

-- Create the Beds table
CREATE TABLE Beds (
    bed_id INT PRIMARY KEY AUTO_INCREMENT,
    bed_status VARCHAR(50) NOT NULL,
    patient_id INT NULL,
    CONSTRAINT fk_patient_bed FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Create the Billing table
CREATE TABLE Billing (
    billing_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    patient_id INT NOT NULL,
    insurance_id INT NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    insurance_covered_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    amount_due DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_visit_billing FOREIGN KEY (visit_id) REFERENCES Visits(visit_id),
    CONSTRAINT fk_patient_billing FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    CONSTRAINT fk_insurance_billing FOREIGN KEY (insurance_id) REFERENCES Insurance(insurance_id)
);

-- Create the Test_and_Procedure table
CREATE TABLE Test_and_Procedure (
    test_procedure_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    provider_id INT NOT NULL,
    test_name VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    results TEXT,
    CONSTRAINT fk_visit_test FOREIGN KEY (visit_id) REFERENCES Visits(visit_id),
    CONSTRAINT fk_provider_test FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);

-- Create the Prescriptions table
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    provider_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    CONSTRAINT fk_visit_prescription FOREIGN KEY (visit_id) REFERENCES Visits(visit_id),
    CONSTRAINT fk_provider_prescription FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);

-- Create the Symptoms table
CREATE TABLE Symptoms (
    symptom_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    symptom TEXT NOT NULL,
    CONSTRAINT fk_visit_symptom FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);

-- Create the Supplies table
CREATE TABLE Supplies (
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    supply_name VARCHAR(100) NOT NULL,
    quantity_available INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

-- Create the Diagnoses table
CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    provider_id INT NOT NULL,
    diagnosis_code VARCHAR(50) NOT NULL,
    diagnosis_description TEXT NOT NULL,
    CONSTRAINT fk_visit_diagnosis FOREIGN KEY (visit_id) REFERENCES Visits(visit_id),
    CONSTRAINT fk_provider_diagnosis FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);