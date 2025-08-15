-- Question 1: Insert Data into all Tables
-- Write SQL queries to populate each table created in the Chapter 5 assignment with at least 10 rows of data.

-- Question 2: Insert a New Patient
-- Write a DML SQL statement to insert a new record into the PATIENT table with the following details:

-- first_name: 'Alice'
-- last_name: 'Johnson'
-- date_of_birth: '1980-05-22'
-- email: 'alice.johnson@example.com'
-- phone_number: '9876543210'
-- Question 3: Insert Multiple Doctors
-- Insert two records into the DOCTOR table with the following details:

-- First doctor: first_name: 'Dr. Robert', last_name: 'Smith', specialization: 'Cardiology', email: 'robert.smith@example.com', phone_number: '1234567890'
-- Second doctor: first_name: 'Dr. Emily', last_name: 'Brown', specialization: 'Neurology', email: 'emily.brown@example.com', phone_number: '1234567891'
-- Question 4: Insert an Appointment
-- Write a DML SQL statement to insert a new record into the APPOINTMENT table for a specific patient and doctor:

-- appointment_date: '2024-09-10'
-- status: 'Scheduled'
-- patient_id: 1
-- doctor_id: 2
-- Question 5: Update Patient Information
-- Write a SQL statement to update the email and phone number of the patient with patient_id = 1.

-- Question 6: Delete an Appointment
-- Write a SQL statement to delete an appointment where appointment_id = 5.

-- Question 7: Insert Data Using Subquery
-- Insert a new appointment into the APPOINTMENT table using a subquery to find the patient_id of the patient whose last_name is 'Johnson' and doctor_id of the doctor with specialization 'Cardiology'.

-- Question 8: Update Doctor's Specialization
-- Write a SQL statement to update the specialization of the doctor with doctor_id = 2 to 'Pediatrics'.

-- Question 9: Insert into DOCTOR_DEPARTMENT Table
-- Insert a record into the DOCTOR_DEPARTMENT table, associating doctor_id 2 with department_id 3.

-- Question 10: Insert Multiple Departments
-- Write a SQL statement to insert two new departments into the DEPARTMENT table:

-- First department: department_name: 'Radiology', location: 'Building A'
-- Second department: department_name: 'Pediatrics', location: 'Building B'
-- Question 11: Update with INNER JOIN
-- Write a SQL statement to update the total_amount in the BILLING table by increasing it by 500 for all patients who have an appointment with a doctor in the 'Cardiology' specialization. Use an INNER JOIN between BILLING, PATIENT, APPOINTMENT, and DOCTOR tables.

-- Question 12: Delete with INNER JOIN
-- Write a SQL statement to delete all appointments where the patient's last_name is 'Johnson' and the doctor is specialized in 'Neurology', using an INNER JOIN between the APPOINTMENT, PATIENT, and DOCTOR tables.

-- Question 13: Update with Subquery
-- Write a SQL statement to update the appointment_date in the APPOINTMENT table to '2024-09-15' for all appointments where the patient has a pending bill (total_amount > 0) in the BILLING table.

-- Question 14: Insert a New Prescription
-- Write a SQL statement to insert a new prescription into the PRESCRIPTION table for a patient, doctor, and medication:

-- prescription_date: '2024-09-25'
-- medication_id: 1
-- patient_id: 1
-- doctor_id: 2
-- Question 15: Update Prescription Information
-- Write a SQL statement to update the medication_id for a prescription where prescription_id = 3.

-- Question 16: Delete a Treatment Record
-- Write a SQL statement to delete a treatment record where the treatment_id = 4.

-- Question 17: Insert a New Nurse
-- Write a SQL statement to insert a new nurse into the NURSE table with the following details:

-- first_name: 'Nina'
-- last_name: 'Williams'
-- email: 'nina.williams@example.com'
-- hire_date: '2022-03-01'
-- Question 18: Insert Data into ROOM Table
-- Write a SQL statement to insert a new room into the ROOM table:

-- room_number: '303'
-- room_type: 'ICU'
-- department_id: 1
-- Question 19: Select Into Backup Table
-- Write a SQL statement to create a backup of all rows in the PATIENT table into a new table called PATIENT_BACKUP.

-- Question 20: Add JSON Column to PATIENT Table
-- Write a SQL statement to add a meta_data column of type JSON to the PATIENT table.

-- Question 21: Insert into JSON Column
-- Write a SQL statement to insert JSON data into the meta_data column of the PATIENT table for a specific patient. The JSON should contain keys like "insurance_provider", "policy_number", and "policy_expiry_date".

-- Question 22: Update JSON Column
-- Write a SQL statement to update the meta_data JSON column of the PATIENT table by adding or updating the "policy_expiry_date" for a specific patient.

-- Question 23: Delete JSON Data
-- Write a SQL statement to remove the "policy_number" field from the meta_data JSON column for a specific patient.

-- Question 24: Update Billing Information
-- Write a SQL statement to update the total_amount in the BILLING table where billing_id = 2 by increasing it by 200.

-- Question 25: Delete a Room
-- Write a SQL statement to delete a room where room_id = 5.

-- Question 26: Truncate the APPOINTMENT Table
-- Write a SQL statement to truncate the APPOINTMENT table, removing all rows without generating individual delete triggers.

-- Question 27: PostgreSQL UPSERT (INSERT ON CONFLICT)
-- Write a SQL statement to insert a new doctor record or update the email if the doctor_id already exists.

-- Question 28: SUPER Complex INSERT.
-- Write a single INSERT SQL statement to add multiple records for all doctors into the APPOINTMENTS table with null patient id, for every Sunday of the current month:

-- Create a DATE_DIM table with columns: date_id, calendar_date, year, month, day_of_the_month, week_day_number, week_day_name, yearly_week_number, month_start_date_flag, month_end_date_flag, year_start_date_flag, year_end_date_flag, holiday_flag
-- The date_id should be populated in the YYYYMM format (e.g., 202401).
-- Populate the DATE_DIM table with data for current year and the next year.
