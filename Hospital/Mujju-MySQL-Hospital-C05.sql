-- create database Hospital;
-- use Hospital;


-- Question 1: Create the DEPARTMENT Table with a Foreign Key
create table if not exists department(
	department_id int auto_increment primary key
    ,department_name varchar(50) unique not null
    ,location varchar(50) not null
    ,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);


-- Question 2: Create the DOCTOR Table with Constraints
create table if not exists doctor(
	doctor_id int auto_increment primary key
    ,first_name varchar(255) not null
    ,last_name varchar(255) not null
    ,specialization varchar(255) not null
    ,email varchar(255) unique not null
    ,phone_number varchar(255) unique not null
    ,per_visit_cost decimal(10,2) not null
    ,active_flag boolean default 0 not null
    ,login_id varchar(255) not null
    ,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- Question 3: Define the DOCTOR_DEPARTMENT Table
create table if not exists DOCTOR_DEPARTMENT(
	doctor_id int
	,department_id int
    ,foreign key(doctor_id) references doctor(doctor_id)
    ,foreign key(department_id) references department(department_id)
    ,primary key(doctor_id, department_id)
);

-- Question 4: Create the NURSE Table
create table if not exists nurse(
	nurse_id int auto_increment primary key
    ,first_name varchar(255) not null
    ,last_name varchar(255) not null
    ,email varchar(255) unique not null
    ,phone_number varchar(255) unique not null
    ,hire_date date not null
    ,active_flag boolean not null
    ,login_id varchar(255) unique not null
    ,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- Question 5: Define the ROOM Table with Relationships
create table if not exists room(
	room_id int auto_increment primary key
    ,room_number char(3) unique not null
    ,room_type varchar(50) not null check (room_type in ( "General", "ICU", "Private"))
    ,daily_rate decimal(10,2) not null
    ,department_id int
    ,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(department_id) references department(department_id)
);

-- Question 6: Create the PATIENT Table
create table if not exists patient(
	patient_id int auto_increment primary key
    ,first_name varchar(50) not null
    ,last_name varchar(50) not null
    ,date_of_birth date not null
    ,email varchar(50) unique not null
    ,phone_number varchar(50) unique not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- Question 7: Create the PATIENT_ADMISSION Table
create table if not exists PATIENT_ADMISSION(
	admission_id int auto_increment primary key
    ,admit_type varchar(50) not null check(admit_type in ('Patient','Out Patient'))
    ,treatment_description varchar(50) not null
    ,treatment_start_date date not null
    ,treatment_end_date date 
    ,patient_id int not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(patient_id) references patient(patient_id)
);

-- Question 8: Create the APPOINTMENT Table
create table if not exists APPOINTMENT(
	appointment_id int auto_increment primary key
    ,appointment_date datetime default current_timestamp not null
    ,status varchar(50) not null check(status in( "Scheduled", "Completed", "Cancelled"))
    ,doctor_id int not null
    ,room_id int not null
    ,incharge_nurse_id int not null
    ,admission_id int not null
    ,patient_id int not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(doctor_id) references doctor(doctor_id)
    ,foreign key(room_id) references room(room_id)
    ,foreign key(incharge_nurse_id) references nurse(nurse_id)
    ,foreign key(admission_id) references PATIENT_ADMISSION(admission_id)
    ,foreign key(patient_id) references patient(patient_id)
);

-- Question 9: Create the ROOM_ADMIT Table
create table if not exists ROOM_ADMIT(
	admit_id int auto_increment primary key
    ,start_date datetime default current_timestamp
    ,end_date datetime 
    ,room_id int not null
    ,incharge_nurse_id int not null
    ,admission_id int not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(room_id) references room(room_id)
    ,foreign key(incharge_nurse_id) references nurse(nurse_id)
    ,foreign key(admission_id) references PATIENT_ADMISSION(admission_id)
);

-- Question 10: Create the MEDICATION Table
create table if not exists MEDICATION(
	medication_id int auto_increment primary key
    ,medication_name varchar(50) unique not null
    ,medication_type varchar(50) not null
    ,dosage varchar(50) not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- Question 11: Create the PRESCRIPTION Table
create table if not exists PRESCRIPTION(
	prescription_id int auto_increment primary key
    ,prescription_date datetime default current_timestamp not null
    ,medication_id int not null
    ,doctor_id int not null
    ,patient_id int not null
    ,start_date date not null
    ,end_date date not null
    ,morning_flag boolean not null
    ,noon_flag boolean not null
    ,evening_flag boolean not null
    ,admission_id int not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(medication_id) references medication(medication_id)
    ,foreign key(doctor_id) references doctor(doctor_id)
    ,foreign key(admission_id) references PATIENT_ADMISSION(admission_id)
    ,foreign key(patient_id) references patient(patient_id)
);

-- Question 12: Create the BILLING Table with Constraints
create table if not exists BILLING(
	billing_id int auto_increment primary key
    ,bill_date datetime default current_timestamp
    ,bill_type varchar(50) not null 
    check(bill_type in ('Appointment','Medicine','Room Charge','Diagnostic'))
    ,description varchar(50) not null 
    ,total_amount decimal(10,2) not null check(total_amount > 0)
    ,balance_amount decimal(10,2) not null
    ,admission_id int not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(admission_id) references PATIENT_ADMISSION(admission_id)
);

-- Question 13: Create the PAYMENT Table with Constraints
create table if not exists PAYMENT(
	payment_id int auto_increment primary key 
    ,billing_id int not null
    ,patient_id int not null
    ,amount_paid decimal(10,2) not null check(amount_paid > 0)
    ,payment_date datetime default current_timestamp not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(billing_id) references billing(billing_id)
    ,foreign key(patient_id) references patient(patient_id)
);

-- Question 14: Create the USER_LOGIN Table
create table if not exists USER_LOGIN(
	user_id int auto_increment primary key
    ,login_id varchar(50) not null
    ,password varchar(255) not null
    ,active_flag char(1) not null check(active_flag in (1,0))
    ,last_login_datetime datetime default current_timestamp
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- Question 15: Create the AUDIT_LOG Table
create table if not exists AUDIT_LOG(
	log_id int auto_increment primary key
    ,log_date  datetime default current_timestamp not null
    ,action varchar(50) not null
    ,user_type ENUM('doctor', 'nurse') NOT NULL 
    ,user_id int not null
	,created_at datetime default current_timestamp
    ,updated_at timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    ,foreign key(user_id) references doctor(doctor_id)
    ,foreign key(user_id) references nurse(nurse_id)
);

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

