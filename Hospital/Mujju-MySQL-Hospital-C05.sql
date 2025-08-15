-- Question 1: Create the DEPARTMENT Table with a Foreign Key
-- Define a DEPARTMENT table:

-- department_id as a primary key with auto-increment functionality.
-- department_name as a string of maximum length 255 characters, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 2: Create the DOCTOR Table with Constraints
-- Create a DOCTOR table with the following specifications:

-- doctor_id as a primary key with auto-increment functionality.
-- first_name as a string with a maximum length of 255 characters, not null.
-- last_name as a string with a maximum length of 255 characters, not null.
-- specialization as a string with a maximum length of 255 characters, not null.
-- email as a unique string, not null.
-- per_visit_cost as a decimal (10, 2), not null.
-- active as a boolean, default to yes, not null.
-- login_id can use alpha numeric login id or email as login id, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.

-- Question 3: Define the DOCTOR_DEPARTMENT Table
-- Write the SQL statement to create a many-to-many relationship between doctors and departments. This will require the DOCTOR_DEPARTMENT table, which includes:

-- doctor_id as a foreign key referencing the DOCTOR table.
-- department_id as a foreign key referencing the DEPARTMENT table.


-- Question 4: Create the NURSE Table
-- Create a NURSE table:

-- nurse_id as a primary key with auto-increment functionality.
-- first_name as a string with a maximum length of 255 characters, not null.
-- last_name as a string with a maximum length of 255 characters, not null.
-- email as a unique string, not null.
-- hire_date as a date field, not null.
-- active as a boolean, not null.
-- login_id can use alpha numeric login id or email as login id, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 5: Define the ROOM Table with Relationships
-- Write the SQL statement to create a ROOM table that includes:

-- room_id as a primary key with auto-increment functionality.
-- room_number as a string of maximum length 50 characters, not null.
-- room_type as a string (e.g., "General", "ICU", "Private"), not null.
-- daily_rate as a decimal (10, 2), not null.
-- created_date as a timestamp field, default it to current timestamp, not null.
-- Question 6: Create the PATIENT Table
-- Write a DDL SQL statement to create a PATIENT table with the following requirements:

-- patient_id as a primary key with auto-increment functionality.
-- first_name as a string of maximum length 255 characters, not null.
-- last_name as a string of maximum length 255 characters, not null.
-- date_of_birth as a date field, not null.
-- email as a unique string, not null.
-- phone_number as a string, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 7: Create the PATIENT_ADMISSION Table
-- Define a PATIENT_ADMISSION table with the following specifications:

-- admission_id as a primary key with auto-increment functionality.
-- admit_type as a string, not null.
-- treatment_description as a string of maximum length 255 characters, not null.
-- treatment_start_date as a date field, not null.
-- treatment_end_date as a date field, null.
-- patient_id as a foreign key referencing the PATIENT table, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.
-- Add a CHECK constraint to ensure the admit_type is In Patient Or Out Patient.


-- Question 8: Create the APPOINTMENT Table
-- Define an APPOINTMENT table with the following details:

-- appointment_id as a primary key with auto-increment functionality.
-- appointment_date as a date field, not null.
-- appointment_time as a time field, not null.
-- status as a string (e.g., "Scheduled", "Completed", "Cancelled"), not null.
-- doctor_id as a foreign key referencing the DOCTOR table, not null.
-- room_id as a foreign key referencing the ROOM table, not null.
-- incharge_nurse_id as a foreign key referencing the NURSE table.
-- admission_id as a foreign key referencing the PATIENT_ADMISSION table, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 9: Create the ROOM_ADMIT Table
-- Define an ROOM_ADMIT table with the following details:

-- admit_id as a primary key with auto-increment functionality.
-- start_date as a date field, not null.
-- end_date as a date field, null.
-- room_id as a foreign key referencing the ROOM table, not null.
-- incharge_nurse_id as a foreign key referencing the NURSE table.
-- admission_id as a foreign key referencing the PATIENT_ADMISSION table, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 10: Create the MEDICATION Table
-- Write a DDL SQL statement to create a MEDICATION table with the following details:

-- medication_id as the primary key with auto-increment functionality.
-- medication_name as a string of maximum length 255 characters, not null.
-- medication_type as a string of maximum length 100 characters, not null.
-- dosage as a string, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 11: Create the PRESCRIPTION Table
-- Write a DDL SQL statement to create a PRESCRIPTION table:

-- prescription_id as the primary key with auto-increment functionality.
-- prescription_date as a date field, not null.
-- medication_id as a foreign key referencing the MEDICATION table, not null.
-- doctor_id as a foreign key, not null.
-- start_date as a date field, not null.
-- end_date as a date field, not null.
-- morning_flag as a boolean, not null.
-- noon_flag as a boolean, not null.
-- evening_flag as a boolean, not null.
-- admission_id as a foreign key referencing the PATIENT_ADMISSION table, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 12: Create the BILLING Table with Constraints
-- Write a DDL SQL statement to create a BILLING table:

-- billing_id as a primary key with auto-increment functionality.
-- bill_date as date, not null.
-- bill_type as string , not null.
-- description as string , null.
-- total_amount as a decimal (10, 2), not null.
-- balance_amount as a decimal (10, 2), not null.
-- admission_id as a foreign key referencing the PATIENT_ADMISSION table, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.
-- Add a CHECK constraint to ensure the bill_type is Doctor Appointment or Medicine or Room Charge or Diagnostic or Food or Miscellaneous.
-- Add a CHECK constraint to ensure the total_amount is greater than 0.


-- Question 13: Create the PAYMENT Table with Constraints
-- Write a DDL SQL statement to create a PAYMENT table:

-- payment_id as a primary key with auto-increment functionality.
-- bill_id as a foreign key referencing the BILLING table, not null.
-- patient_id as a foreign key referencing the PATIENT table, not null.
-- amount_paid as a decimal (10, 2), not null.
-- payment_date as a datetime, not null.
-- Add a CHECK constraint to ensure the amount_paid is greater than 0.


-- Question 14: Create the USER_LOGIN Table
-- Write a DDL SQL statement to create an USER_LOGIN table:

-- user_id as a primary key with auto-increment functionality.
-- login_id can use alpha numeric login id or email as login id, not null.
-- password must encrypt the password before storing it in the database table, not null.
-- active_flag use numeric, 0 or 1, you can lock the customer login when required, not null.
-- last_login_datetime as a timestamp, last successfull login date for a given user.
-- active as boolean, default to yes, not null.
-- created_date as a timestamp field, default it to current timestamp, not null.


-- Question 15: Create the AUDIT_LOG Table
-- Define an AUDIT_LOG table to track changes in the hospital management system:

-- log_id as a primary key with auto-increment functionality.
-- log_date as a date field, not null.
-- action as a string to describe the action performed.
-- user_id as a foreign key referencing the DOCTOR or NURSE table.


-- Question 16: Add a Column to the DOCTOR Table
-- Write a SQL statement to add a phone_number column of type VARCHAR(15) to the DOCTOR table.

-- Question 17: Alter a Column in the PATIENT Table
-- Write a SQL statement to alter the email column in the PATIENT table, increasing its length to 300 characters.

-- Question 18: Drop a Column from the USER_LOGIN Table
-- Write a SQL statement to drop the active column from the USER_LOGIN table.

-- Question 19: Rename the USER_LOGIN Table
-- Write a SQL statement to rename the USER_LOGIN table to USER.

-- Question 20: Drop the USER Table
-- Write a SQL statement to drop the USER table.

-- Question 21: Add a Primary Key
-- Set up a composite primary key using doctor_id and department_id on DOCTOR_DEPARTMENT table.

-- Question 22: Add a Foreign Key to the PRESCRIPTION Table
-- Add a foreign key in the PRESCRIPTION table to reference the DOCTOR table.

-- Question 23: Add a CHECK Constraint on the TREATMENT Table
-- Write a SQL statement to add a CHECK constraint to the TREATMENT table ensuring that the treatment_date is not in the future.

-- Question 24: Add a UNIQUE Constraint on the DEPARTMENT Table
-- Write a SQL statement to add a UNIQUE constraint to the DEPARTMENT table ensuring that the department_name is not repeated.

-- Question 25: Add a DEFAULT Constraint on the AUDIT_LOG Table
-- Write a SQL statement to add a DEFAULT constraint to the AUDIT_LOG table to set the default value of log_date to system date.

-- Question 26: Add Indexes to the PATIENT and DOCTOR Tables
-- Write SQL statements to:

-- Add an index on the last_name column in the PATIENT table.
-- Add an index on the specialization column in the DOCTOR table.
-- Question 27: Drop an Index from the DOCTOR Table
-- Write a SQL statement to drop the index on the specialization column in the DOCTOR table.

-- Question 28: Enforce UNIQUE constraints on all applicable tables.
-- Apply UNIQUE constraints to columns across the entire database wherever duplicate data is not permitted.

