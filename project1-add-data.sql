INSERT INTO Insurance (insurance_provider, policy_number)
VALUES 
    ('Aetna', 'AA789356'),
	('Blue Cross Blue Shield', 'BC430023'),
	('Aetna', 'AA123877'),
    ('Medicare', 'MC123098'),
    ('Medicaid', 'ME544321'),
    ('Blue Cross Blue Shield', 'BC475890'),
    ('United Healthcare', 'UH123456'),
    ('Medicare', 'MC000008'),
	('United Healthcare', 'UH234321'),
    ('Cigna', 'CI345671'),
	('Medicaid', 'ME444555'),
    ('Cigna', 'CI456789');

INSERT INTO Patients (first_name, last_name, date_of_birth, sex, address, phone_number, email, insurance_id)
VALUES 
    ('Jared', 'Johnson', '1965-07-12', 'M', '123 Elm St', '456-1234', 'jjohn@gmail.com', 1),
    ('Sharon', 'Smith', '2000-12-10', 'F', '456 Kyle St', '565-1679', 'ssmith@yahoo.com', 2),
    ('Michael', 'Jordan', '1958-09-02', 'M', '789 Lakewood St', '123-4355', 'mjordan@gmail.com', 3),
    ('Nick', 'Williams', '1988-06-25', 'M', '165 Rich Lane', '654-2314', 'nwilliams@yahoo.com', 4),
    ('Hazel', 'Matthews', '1990-01-17', 'F', '246 Palm Dr', '123-4567', 'hmatthews@gmail.com', 5),
    ('Haley', 'James', '1973-03-29', 'F', '208 Jones Dr', '345-8560', 'hjames@gmail.com', 6),
    ('Ella', 'Roberts', '2015-05-20', 'F', '123 Maple St', '555-9876', 'eroberts@gmail.com', 7),
    ('Tom', 'Harris', '1982-08-11', 'M', '456 Cedar St', '444-3210', 'tharris@gmail.com', 8),
    ('Kate', 'Brown', '1975-04-30', 'F', '789 Birch St', '333-7654', 'kbrown@gmail.com', 9),
    ('Chris', 'Davis', '1990-11-01', 'M', '321 Oak St', '222-1234', 'cdavis@gmail.com', 10),
    ('Julia', 'White', '1985-07-14', 'F', '654 Pine St', '111-0000', 'jwhite@gmail.com', 11),
    ('Rick', 'Black', '1969-02-25', 'M', '987 Spruce St', '666-8888', 'rblack@gmail.com', 12);


INSERT INTO Providers (first_name, last_name, specialty, phone_number, email)
VALUES 
    ('Allie', 'White', 'Pediatrics', '321-5432', 'awhite@yahoo.com'),
    ('Stewart', 'James', 'Cardiology', '321-1234', 'sjames@gmail.com'),
    ('Cathy', 'Curtis', 'Neurology', '987-4321', 'ccurtis@gmail.com'),
	('Frank', 'Neal', 'Emergency Medicine', '335-4476', 'fneal@gmail.com'),
	('Hannah', 'Johnston', 'Surgery', '111-2576', 'hjohnston@gmail.com'),
	('David', 'Beal', 'Emergency Medicine', '432-1111', 'dbeal@yahoo.com'),
    ('Michael', 'Thompson', 'Cardiology', '321-9876', 'mthompson@yahoo.com'),
    ('Emily', 'Clark', 'Surgery', '987-6543', 'eclark@gmail.com');

INSERT INTO Visits (patient_id, provider_id, visit_time, discharge_time, reason_for_visit, triage_level)
VALUES 
    (1, 2, '2024-10-01 12:00:00', '2024-10-01 14:45:00', 'Chest pain', 'High'),
    (2, 4, '2024-10-02 03:15:00', '2024-10-02 06:00:00', 'Shortness of breath', 'Medium'),
    (3, 3, '2024-10-03 12:45:00', '2024-10-03 13:30:00', 'Severe headache', 'Low'),
    (4, 2, '2024-10-04 14:00:00', '2024-10-04 18:15:00', 'Chest pain', 'High'),
    (5, 5, '2024-10-05 09:15:00', '2024-10-05 15:00:00', 'Broken arm', 'High'),
    (6, 2, '2024-10-06 17:45:00', '2024-10-06 21:00:00', 'Chest pain', 'High'),
    (7, 1, '2024-10-01 09:00:00', '2024-10-01 11:00:00', 'Panic attack', 'Low'),
    (9, 4, '2024-10-01 12:30:00', '2024-10-01 15:00:00', 'Chest discomfort', 'Medium'),
    (8, 7, '2024-10-02 10:00:00', '2024-10-02 12:00:00', 'Chest discomfort', 'Medium'),
    (12, 4, '2024-10-02 14:00:00', '2024-10-02 16:30:00', 'Anxiety', 'Low'),
    (10, 6, '2024-10-03 11:30:00', '2024-10-03 13:15:00', 'Back pain', 'Medium'),
    (11, 6, '2024-10-03 15:00:00', '2024-10-03 17:00:00', 'Knee pain', 'High'),
    (1, 8, '2024-10-04 09:15:00', '2024-10-04 10:45:00', 'Broken arm', 'High'),
    (7, 1, '2024-10-04 11:00:00', '2024-10-04 12:30:00', 'Breathing issues', 'High');

INSERT INTO Beds (bed_status, patient_id)
VALUES 
    ('Occupied', 1),
    ('Occupied', 2),
    ('Available', NULL),
    ('Available', NULL),
    ('Occupied', 3),
    ('Occupied', 4),
    ('Occupied', 5),
    ('Available', NULL),
    ('Occupied', 6);

INSERT INTO Billing (visit_id, patient_id, insurance_id, total_cost, insurance_covered_amount, amount_due)
VALUES 
    (1, 1, 1, 550.00, 400.00, 150.00),
    (2, 2, 2, 320.00, 250.00, 70.00),
    (3, 3, 3, 700.00, 500.00, 200.00),
    (4, 4, 4, 450.00, 350.00, 100.00),
    (5, 5, 5, 600.00, 500.00, 100.00),
    (6, 6, 6, 300.00, 250.00, 50.00),
    (7, 7, 7, 250.00, 200.00, 50.00),
    (8, 8, 8, 420.00, 300.00, 120.00),
    (9, 9, 9, 360.00, 280.00, 80.00),
    (10, 10, 10, 480.00, 400.00, 80.00),
    (11, 11, 11, 500.00, 450.00, 50.00),
    (12, 12, 12, 300.00, 250.00, 50.00),
	(13, 1, 1, 300.00, 250.00, 50.00),
    (14, 7, 7, 300.00, 250.00, 50.00);


INSERT INTO Test_and_Procedure (visit_id, provider_id, test_name, status, results)
VALUES 
    (1, 2, 'ECG', 'Completed', 'Normal'),
    (2, 4, 'Chest X-Ray', 'Completed', 'Clear'),
    (3, 3, 'MRI Brain', 'Completed', 'Normal'),
    (4, 2, 'Blood Test', 'Completed', 'Normal'),
    (5, 5, 'X-Ray', 'Completed', 'Fracture detected'),
    (6, 2, 'ECG', 'Completed', 'Normal'),
    (7, 1, 'Blood Test', 'Completed', 'Normal'),
    (8, 4, 'ECG', 'Completed', 'Normal'),
    (9, 7, 'CT Scan', 'Completed', 'Anxiety confirmed'),
    (10, 4, 'X-Ray', 'Completed', 'No abnormalities'),
    (11, 6, 'MRI', 'Completed', 'Normal'),
    (12, 6, 'Pulmonary Function Test', 'Completed', 'Mild obstruction'),
	(13, 8, 'X-Ray', 'Completed', 'Fracture detected'),
	(14, 1, 'Pulmonary Function Test', 'Completed', 'No abnormalities');

INSERT INTO Prescriptions (visit_id, provider_id, medication_name, dosage)
VALUES 
    (1, 2, 'Aspirin', '100mg'),
    (2, 4, 'Albuterol', '2 puffs'),
    (3, 3, 'Ibuprofen', '200mg'),
    (4, 2, 'Lisinopril', '10mg'),
    (5, 5, 'Acetaminophen', '500mg'),
    (6, 2, 'Nitroglycerin', '0.4mg'),
    (8, 4, 'Albuterol', '2 puffs'),
    (9, 7, 'Sertraline', '50mg'),
    (10, 4, 'Ibuprofen', '400mg'),
    (11, 6, 'Lisinopril', '10mg'),
    (12, 6, 'Prednisone', '5mg'),
    (13, 8, 'Ibuprofen', '50mg'),
    (14, 1, 'Sertraline', '25mg');


INSERT INTO Symptoms (visit_id, symptom)
VALUES 
    (1, 'Sharp chest pain'),
    (2, 'Shortness of breath'),
    (2, 'Coughing'),
    (3, 'Throbbing headache'),
    (4, 'Chest pain'),
    (5, 'Severe pain in arm'),
    (6, 'Persistent chest discomfort'),
	(7, 'Anxiety'),
    (7, 'Chest pain'),
    (8, 'Chest tightness'),
    (8, 'Shortness of breath'),
    (9, 'Anxiety'),
    (9, 'Palpitations'),
    (10, 'Knee pain and swelling'),
    (11, 'Back pain and stiffness'),
    (12, 'Difficulty breathing'),
    (12, 'Anxiety'),
    (13, 'Severe pain in arm'),
    (14, 'Difficulty breathing');


INSERT INTO Supplies (supply_name, quantity_available, unit_price)
VALUES 
    ('Syringe', 500, 0.50),
    ('Bandage', 1000, 0.20),
    ('Gloves', 2000, 0.15),
    ('Scalpel', 300, 1.00),
    ('Gauze', 800, 0.10),
    ('Thermometer', 150, 2.00);


INSERT INTO Diagnoses (visit_id, provider_id, diagnosis_code, diagnosis_description)
VALUES 
    (1, 2, 'I20', 'Stable angina'),
    (2, 4, 'J45', 'Asthma'),
    (3, 3, 'G43', 'Migraine'),
    (4, 2, 'I25', 'Coronary artery disease'),
    (5, 5, 'S42', 'Fracture of humerus'),
    (6, 2, 'I20', 'Angina pectoris'),
    (7, 1, 'Z00', 'No diagnosis'),
    (8, 4, 'I20', 'Stable angina'),
    (9, 7, 'F41', 'Generalized anxiety disorder'),
    (10, 4, 'M17', 'Osteoarthritis of the knee'),
    (11, 6, 'M54', 'Dorsalgia'),
    (12, 6, 'J44', 'Chronic obstructive pulmonary disease'),
    (13, 8, 'M54', 'Fracture of humerus'),
    (14, 1, 'F41', 'Generalized anxiety disorder');
