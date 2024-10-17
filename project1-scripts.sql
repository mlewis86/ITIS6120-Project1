-- Update Patient address and insurance_id
UPDATE Patients
SET address = '456 Oak Lane',
    policy_number = 'MC123098'
WHERE patient_id = 1;

-- Delete all symptoms from a specific visit
DELETE FROM Symptoms
WHERE visit_id = 2;

-- Insert deleted symptom information back into the Symptoms table
INSERT INTO Symptoms (visit_id, symptom)
VALUES
    (2, 'Shortness of breath'),
    (2, 'Coughing');

-- Search patients by patient_id
SELECT *
FROM Patients
WHERE patient_id = 1;

-- Search patients by name
SELECT *
FROM Patients
WHERE last_name = 'Smith';

-- Search patients by visit date
SELECT p.first_name, p.last_name, v.visit_time, v.reason_for_visit
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
WHERE DATE(v.visit_time) = '2024-10-01';

-- List patients and diagnosis with a certain diagnosis
SELECT p.first_name, p.last_name, d.diagnosis_description
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
JOIN Diagnoses d ON v.visit_id = d.visit_id
WHERE d.diagnosis_code = 'F41';

-- List patients seen by a certain doctor
SELECT p.first_name, p.last_name, pr.first_name AS doctor_first_name, pr.last_name AS doctor_last_name
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
JOIN Providers pr ON v.provider_id = pr.provider_id
WHERE pr.first_name = 'Frank' AND pr.last_name = 'Neal';

-- List diagnoses of patients who have visited twice within the shorted time interval
SELECT p.first_name, p.last_name, v1.visit_time AS first_visit, v2.visit_time AS second_visit, d.diagnosis_description
FROM Patients p
JOIN Visits v1 ON p.patient_id = v1.patient_id
JOIN Visits v2 ON p.patient_id = v2.patient_id
JOIN Diagnoses d ON v1.visit_id = d.visit_id
WHERE v1.visit_time < v2.visit_time
AND v2.visit_time - v1.visit_time = (
    SELECT MIN(v2.visit_time - v1.visit_time)
    FROM Visits v1, Visits v2
    WHERE v1.patient_id = v2.patient_id
    AND v1.visit_time < v2.visit_time
);

-- Search patients by their id and list their visit time, reason for visit and diagnosis description
SELECT p.first_name, p.last_name, v.visit_time, v.reason_for_visit, d.diagnosis_description
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
LEFT JOIN Diagnoses d ON v.visit_id = d.visit_id
WHERE p.patient_id = 1;

-- Find all patients with multiple visits
SELECT p.first_name, p.last_name, COUNT(v.visit_id) AS number_of_visits
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
GROUP BY p.patient_id
HAVING COUNT(v.visit_id) > 1;

-- List all patients who have a certain prescribed medication
SELECT p.first_name, p.last_name, pr.medication_name, pr.dosage
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
JOIN Prescriptions pr ON v.visit_id = pr.visit_id
WHERE pr.medication_name = 'Aspirin';

-- Find all available beds
SELECT bed_id, bed_status
FROM Beds
WHERE bed_status = 'Available';

-- Find the total cost of all visits for a certain patient
SELECT p.first_name, p.last_name, SUM(b.total_cost) AS total_cost
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
JOIN Billing b ON v.billing_id = b.billing_id
WHERE p.patient_id = 1
GROUP BY p.first_name, p.last_name;

-- List all providers and the number of patients they have had
SELECT pr.first_name, pr.last_name, COUNT(DISTINCT v.patient_id) AS total_patients
FROM Providers pr
JOIN Visits v ON pr.provider_id = v.provider_id
GROUP BY pr.provider_id;

-- List the patients with the highest medical bills
SELECT p.first_name, p.last_name, SUM(b.amount_due) AS total_due
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
JOIN Billing b ON v.billing_id = b.billing_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_due DESC
LIMIT 5;

-- Find the most common diagnosis
SELECT d.diagnosis_description, COUNT(d.diagnosis_id) AS diagnosis_count
FROM Diagnoses d
GROUP BY d.diagnosis_description
ORDER BY diagnosis_count DESC
LIMIT 1;

-- Find all patients treated by providers with a certain specialty
SELECT p.first_name, p.last_name, pr.specialty
FROM Patients p
JOIN Visits v ON p.patient_id = v.patient_id
JOIN Providers pr ON v.provider_id = pr.provider_id
WHERE pr.specialty = 'Emergency Medicine';

-- Find the average cost of visit per each triage level
SELECT v.triage_level, ROUND(AVG(b.total_cost), 2) AS average_cost
FROM Visits v
JOIN Billing b ON v.billing_id = b.billing_id
GROUP BY v.triage_level;

-- Providers who treat more than the average number of patients and how many patients they treat
SELECT pr.provider_id, pr.first_name, pr.last_name, COUNT(v.patient_id) AS number_of_patients
FROM Providers pr
JOIN Visits v ON pr.provider_id = v.provider_id
GROUP BY pr.provider_id
HAVING 
    COUNT(v.patient_id) > (
        SELECT AVG(patient_count)
        FROM (
            SELECT COUNT(patient_id) AS patient_count
            FROM Visits
            GROUP BY provider_id
        ) AS provider_patient_counts
    );
