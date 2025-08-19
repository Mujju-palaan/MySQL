-- 1. Patient Overview
-- Metrics:
-- Total number of patients.
-- List of patients with date of birth and email.
-- Number of appointments per patient.

-- SQL Queries:
-- Count total patients.
select count(*) from patient;

-- Retrieve patient names, date of birth, and email.
select 
	concat(first_name,' ',last_name) as patient_name
    ,date_of_birth
    ,email
from patient;

-- Retrieve the number of appointments per patient (join PATIENT and APPOINTMENT).
select 
	b.patient_id
    ,concat(b.first_name,' ',b.last_name)
    ,count(admission_id)
from appointment apatient_admission
inner join PATIENT b using(patient_id)
group by b.patient_id, concat(b.first_name,' ',b.last_name)
;


-- 2. Doctor Overview
-- Metrics:
-- Total number of doctors.
-- Doctors by specialization.
-- Doctor assignments (how many departments per doctor).

-- SQL Queries:
-- Count total doctors.
select count(*) from doctor;

-- Retrieve doctors grouped by specialization.
select 
	specialization
    ,count(*)
from doctor
group by specialization
;

-- List doctor assignments per department (join DOCTOR, DOCTOR_DEPARTMENT, and DEPARTMENT).
select
	department_name
    ,count(*)
from department
inner join DOCTOR_DEPARTMENT using(department_id)
inner join DOCTOR using(doctor_id)
;

-- 3. Appointment Overview
-- Metrics:
-- Total appointments per doctor.
-- Recent appointments (within the last 3 months).
-- Appointments by status (Scheduled, Completed, Cancelled).

-- SQL Queries:
-- Count total appointments per doctor.
select 
	doctor_id
    ,count(appointment_id)
from appointment
group by doctor_id
;    
    
-- Retrieve recent appointments.
select * from appointment
where created_at = current_date()
order by 1 desc
limit 1 
;

-- Retrieve appointments grouped by status.
select 
	status
    ,count(*)
from appointment
group by status
;

-- 4. Room Overview
-- Metrics:
-- Room availability (by room type: General, ICU, Private).
-- Rooms by department.
-- Total number of rooms.

-- SQL Queries:
-- Count total rooms grouped by room type.
select
	room_type
    ,count(*)
from room
group by room_type
;

-- Retrieve rooms grouped by department (join ROOM and DEPARTMENT).
select
	department_id
    ,count(*)
from DEPARTMENT
inner join room using(department_id)
group by department_id
;

-- Count total rooms available in the system.
select count(*) from room;

-- 5. Treatment Overview
-- Metrics:
-- Treatments by doctor.
-- Patients receiving treatments (linked to doctors).
-- Recent treatments (conducted within the last year).

-- SQL Queries:
-- Retrieve treatments performed by each doctor (join TREATMENT, DOCTOR, and PATIENT).
-- Retrieve treatments linked to patients and doctors.
-- Retrieve treatments conducted in the last year.


-- 6. Audit Log Overview
-- Metrics:
-- List of recent system changes.
-- Changes made by doctors.
-- Number of logs per day.

-- SQL Queries:
-- Retrieve recent actions from the AUDIT_LOG table.
select * from audit_log
order by created_at desc
limit 1;

-- Retrieve actions performed by doctors (join AUDIT_LOG with DOCTOR).
select 
	concat(first_name,' ',last_name) as doctor_name
	,action
from doctor
inner join AUDIT_LOG ON doctor_id=user_id
order by 1;

-- Count the number of audit logs per day.
select 
	log_date
    ,count(*)
from audit_log
group by log_date;

-- Key Visuals and Corresponding SQL Queries:
-- Note: All dashboard queries must work against current month or current year filters

-- Bar Chart - Patient Admits
-- SQL Query: Retrieve admit counts grouped by month.
-- X-Axis: Month.
-- Y-Axis: Number of patient admits.
select 
	patient_id
    ,month(treatment_start_date) as month
    ,count(*)
from patient_admission
group by patient_id, month(treatment_start_date)
;

-- Pie Chart - Doctors by Specialization
-- SQL Query: Retrieve doctors grouped by their specialization.
-- Pie Sections: Number of doctors per specialization.
select
	Specialization
    ,count(*)
from doctor
group by Specialization
;

-- Line Graph - Doctor Visits by Month
-- SQL Query: Retrieve doctor appointments conducted per month.
-- X-Axis: Treatment date grouped by month.
-- Y-Axis: Number of appointments.
select
	month(appointment_date)
    ,count(*)
from appointment
group by month(appointment_date)
;

-- Table - Occupancy Summary
-- SQL Query: Retrieve patient names and room admit dates.
-- Columns: Calendar Date, Room Name, Patient Name.
-- Note: Retrieve data for a specified month across all rooms, including rooms without any patients.
select 
	monthname(a.created_at)
    ,b.room_number
    ,concat(d.first_name,' ',d.last_name)
    ,count(*)
from room_admit a
inner join room b using(room_id)
inner join patient_admission c using(admission_id)
inner join patient d using(patient_id)
group by monthname(a.created_at), b.room_number, concat(d.first_name,' ',d.last_name)
;

-- Gauge - In Patient VS Out Patient
-- SQL Query: Count the total number of in patient and out patient admits.
-- Display: Total patient count.
select 
	admit_type
    ,count(*)
from patient_admission
group by admit_type
;
