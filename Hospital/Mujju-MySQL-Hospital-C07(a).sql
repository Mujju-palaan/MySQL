-- 1. SELECT Command
-- Select all columns from the PATIENT table.
select * from patient;

-- Select the first_name, last_name, and email of all patients.
Select first_name, last_name, email from patient;

-- Select all specialization from the DOCTOR table.
select specialization from doctor;

-- Select the appointment_date and status from the APPOINTMENT table.
Select appointment_date, status from  APPOINTMENT;

-- 2. WHERE Command
-- Select all patients where date_of_birth is before '1990-01-01'.
select * from patient
where date_of_birth < '1990-01-01';

-- Select all doctors whose specialization is 'Cardiology'.
select * from doctor
where specialization = 'Cardiology';

-- Select all appointments where status is 'Scheduled'.
select * from appointment
where status = 'Scheduled';

-- Select all patient admits where treatment_start_date is after '2022-01-01'.
select * from patient_admission
where treatment_start_date > '2022-01-01';

-- 3. ORDER BY Command
-- Select all patients and order them by last_name in ascending order.
Select * from patient
order by last_name asc;

-- Select all doctors and order them by first_name in descending order.
Select * from doctor
order by first_name desc;

-- Select all appointments and order them by appointment_date in descending order.
Select * from appointment
order by appointment_date desc;

-- Select all medications and order them by medication_name in ascending order.
Select * from medication
order by medication_name asc;

-- 4. LIMIT Command
-- Select the first 10 patients from the PATIENT table.
Select * from patient
limit 10;

-- Select the first 5 doctors from the DOCTOR table.
Select * from doctor
limit 5;

-- Select the top 3 appointments ordered by appointment_date.
Select * from appointment
order by appointment_date
limit 3;

-- Select the first 5 prescriptions from the PRESCRIPTION table.
select * from prescription
limit 5;


-- 5. DISTINCT Command
-- Select distinct specialization from the DOCTOR table.
select distinct specialization from  DOCTOR;

-- Select distinct status from the APPOINTMENT table.
select distinct status  from  APPOINTMENT;

-- Select distinct department_name from the DEPARTMENT table.
select distinct department_name  from  DEPARTMENT;

-- Select distinct last_name from the PATIENT table.
select distinct last_name  from  PATIENT;


-- 6. GROUP BY Command
-- Group by specialization from the DOCTOR table and count the number of doctors per specialization.
select specialization, count(*)
from doctor
group by specialization;

-- Group by status in the APPOINTMENT table and count the number of appointments per status.
select status, count(*)
from APPOINTMENT
group by status;

-- Group by department_name from the ROOM table and calculate the number of rooms in each type.
select department_name, count(room_type)
from ROOM
inner join department using(department_id)
group by department_name;

-- Group by medication_type in the MEDICATION table and calculate the total number of medications per type.
select medication_type, count(*)
from MEDICATION
group by medication_type;

-- 7. HAVING Command
-- Select specialization from the DOCTOR table and group by it, having more than 2 doctors per specialization.
select specialization, count(*)
from DOCTOR
group by specialization
having count(*) > 2;

-- Group by department_name and calculate the number of doctors in each department, having more than 3 doctors.
select department_name, count(DOCTOR_id)
from DOCTOR
inner join doctor_department using(doctor_id)
inner join department using(department_id)
group by department_name
having count(*) > 3;

-- Group by status in the APPOINTMENT table and filter the groups having more than 5 appointments.
select status, count(DOCTOR_id)
from APPOINTMENT
group by status
having count(*) > 5;

-- Group by medication_type and calculate the total medications, having more than 3 medications per type.
select medication_type, count(*)
from medication
group by medication_type
having count(*) > 3;

-- 8. INNER JOIN Command
-- Select all patients and their corresponding appointments using INNER JOIN between PATIENT and APPOINTMENT.
select 
	patient_id, first_name, last_name, appointment_date, status
from patient
inner join APPOINTMENT using(patient_id)
;

-- Select all treatments along with the corresponding doctor details using INNER JOIN between PATIENT_ADMIT and DOCTOR.


-- Select all prescriptions along with the corresponding medication details using INNER JOIN between PRESCRIPTION and MEDICATION.
select 
	medication_name, medication_type, dosage, start_date, end_date, morning_flag, noon_flag, evening_flag
from prescription
inner join medication using(medication_id)
;

-- Select all doctors and the departments they belong to using INNER JOIN between DOCTOR and DOCTOR_DEPARTMENT.
select 
	doctor_id
    ,concat(first_name, ' ', last_name) as doctor_name
    ,department_name
from doctor
inner join DOCTOR_DEPARTMENT using(doctor_id)
inner join DEPARTMENT using(DEPARTMENT_id)
;


-- 9. LEFT JOIN Command
-- Select all doctors and their corresponding departments using LEFT JOIN, including doctors without any departments.
-- Select all patients and their appointments using LEFT JOIN, including patients without appointments.
-- Select all nurses and their assingned rooms using LEFT JOIN, including nurses without assigned rooms.
-- Select all medication and the corresponding prescriptions using LEFT JOIN, including medication without prescriptions.

-- 10. COUNT, SUM, AVG Command
-- Count the total number of patients in the PATIENT table.
select count(*)
from patient;

-- Count the number of distinct specialization in the DOCTOR table.
select specialization, count(*)
from DOCTOR
group by specialization;

-- Calculate the sum of total_amount in the BILLING table.
select sum(total_amount)
from billing;

-- Calculate the average dosage for medications in the MEDICATION table.
select avg(dosage)
from MEDICATION;

-- 11. CASE Command
-- Select all appointments and use a CASE statement to show 'Upcoming' 
-- if the appointment_date is after the current date, and 'Past' otherwise.
select 
	appointment_id, 
    appointment_date,
    case 
		when appointment_date > current_date() then 'Upcoming'
        else 'Past'
	end as status
from appointment;

-- Select all patients and categorize them as 'Senior' if their date_of_birth is before date_of_birth, 
-- otherwise 'Adult'.
select 
	patient_id
    ,concat(first_name, ' ', last_name) as patient_name
    ,case
		when date_of_birth < date_of_birth then 'Senior'
		else 'Adult'
	end as categorize
from patient;

-- Use a CASE statement to categorize patient admits as 'Recent' 
-- if the treatment_start_date is within the last year, otherwise 'Old'.
select 
	patient_id
    ,case
		when treatment_start_date > DATE_sub(current_date(), INTERVAL 12 MONTH)  then 'Recent' 
        else 'old'
	end as categorize
from patient_admission;

-- Use a CASE statement in the APPOINTMENT table to label appointments as 'Critical' 
-- if the patient has undergone multiple doctor visits.
SELECT 
    a.appointment_id,
    a.doctor_id,
    a.appointment_date,
    a.status,
    a.patient_id,
    CASE 
        WHEN visit_count > 1 THEN 'Critical'
        ELSE 'Normal'
    END AS appointment_label
FROM appointment a
JOIN (
    SELECT patient_id, COUNT(*) AS visit_count
    FROM appointment
    GROUP BY patient_id
)v ON a.patient_id = v.patient_id;


-- 12. EXISTS and NOT EXISTS Command
-- Select all patients where an appointment exists in the APPOINTMENT table using EXISTS.
select * from patient a
where  exists ( select * from APPOINTMENT b
				where a.patient_id=b.patient_id )
;

-- Select all doctors where no appointments exist in the APPOINTMENT table using NOT EXISTS.
select * from doctor
where not exists (select * from appointment)
;

-- 13. SUBQUERY Command
-- Select all doctors whose doctor_id is in the result of a subquery selecting doctor_id from the APPOINTMENT table where status is 'Scheduled'.
select doctor_id from doctor
where doctor_id in (select doctor_id from APPOINTMENT
					where status = 'Scheduled')
;

-- Select all medications where the medication_id is in the result of a subquery selecting medication_id from the PRESCRIPTION table.
select * from medication
where medication_id in ( select medication_id from PRESCRIPTION);

-- Select all patients who have not scheduled an appointment using a subquery.
select * from patient
where patient_id not in (select patient_id from appointment
							where status = 'Scheduled');

-- Select all patient admits where the patient has been admitted more than once using a subquery.
Select * from  patient_admission
where patient_id in (select patient_id 
						from patient
                        group by patient_id
                        having count(*) > 1
						);

-- 14. RANK and DENSE_RANK Command
-- Rank patients based on the number of appointments using RANK().
WITH patient_visits AS (
    SELECT 
        patient_id,
        COUNT(appointment_id) AS total_visits
    FROM appointment
    GROUP BY patient_id
)
SELECT 
    patient_id,
    total_visits,
    RANK() OVER (ORDER BY total_visits DESC) AS visit_rank
FROM patient_visits
ORDER BY visit_rank, patient_id;

-- Use DENSE_RANK() to rank doctors based on their specialization.
select concat(first_name,' ',last_name) as doctor_name,
		specialization,
		DENSE_RANK() over(order by specialization)
from doctor;

-- Rank medications by their dosage using RANK().
select 
	medication_name
	,dosage
    ,rank() over(order by dosage)
from medication;


-- Use DENSE_RANK() to rank treatments by treatment_date.
select 
	treatment_start_date
    ,rank() over(order by treatment_start_date)
from patient_admission;

-- 15. PIVOT and UNPIVOT
-- Pivot the APPOINTMENT data by status and patient_id.
-- Unpivot the treatment details to show the treatment_description and doctor_id in a single row per patient.
-- Pivot the room data grouped by room_type and daily_rate.
-- Unpivot medication data by medication_name and dosage.

-- 16. UNION and UNION ALL Command
-- Select all doctors from different departments using UNION ALL.
-- Use UNION to combine scheduled and completed appointments.
-- Use UNION ALL to select all patient admits from two different years.

-- 17. COALESCE, IFNULL, NULLIF Command
-- Select all patients and use COALESCE to replace null emails with 'No Email'.
-- Use IFNULL to replace null phone_number values in the DOCTOR table.
-- Use NULLIF to compare treatment_start_date and appointment_date in the PATIENT_ADMIT table and return NULL if they are the same.
-- Select all nurses and replace null hire_date with 'Unknown' using COALESCE.

-- 18. STRING Functions
-- Select all patients' first_name in uppercase using the UPPER() function.
-- Select all doctors' specialization in lowercase using the LOWER() function.
-- Use CONCAT() to combine the first_name and last_name of doctors.
-- Select all patients' last_name and find the length of the name using LENGTH().

-- 19. DATE Functions
-- Select all patients and show their date_of_birth formatted as 'YYYY-MM-DD' using TO_CHAR().


-- Add 1 year to all appointment_date values in the APPOINTMENT table using AGE().


-- Subtract 1 month from all treatment_start_date values using INTERVAL.
select treatment_start_date from patient_admission;

-- Select all nurses and extract the year from their hire_date using EXTRACT().


-- 20. NUMERIC Functions
-- Select the dosage from the MEDICATION table and round it to the nearest integer using ROUND().
-- Select all total_amount from the BILLING table and use CEIL() to round up.
-- Use FLOOR() to round down the total_amount in the BILLING table.
-- Select the highest total_amount from the BILLING table using MAX().

-- 21. CAST and CONVERT Command
-- Select all patients and cast the patient_id as a string using CAST().
-- Convert total_amount in the BILLING table to DECIMAL using CONVERT().
-- Cast treatment_id in the TREATMENT table to INTEGER.
-- Convert the appointment_date from the APPOINTMENT table into TEXT.

-- 22. CONCAT and CONCAT_WS Functions
-- Use CONCAT() to join first_name and last_name with a space in between in the DOCTOR table.
-- Use CONCAT_WS() to combine the department_name and location with a comma in the DEPARTMENT table.
-- Use CONCAT() to combine the room_number and room_type from the ROOM table.
-- Use CONCAT_WS() to combine first_name, last_name, and email from the PATIENT table.

-- 23. LIKE and NOT LIKE
-- Select patients whose email ends with 'hospital.com' using LIKE.
select * from patient
where email like  '%hospital.com';

-- Select doctors where specialization contains 'Surgery' using LIKE.
select * from doctor
where specialization LIKE 'Surgery';

-- Select patients whose last_name does not start with 'J' using NOT LIKE.
select * from patient
where last_name NOT LIKE 'J%';

-- Select departments where department_name contains 'Oncology' using LIKE.
select * from department
where department_name LIKE 'Oncology';

-- 24. EXISTS and NOT EXISTS
-- Select doctors where appointments exist in the APPOINTMENT table using EXISTS.
-- Select patients where no prescriptions exist using NOT EXISTS.
-- Select rooms where treatments exist using EXISTS.
-- Select departments where no doctors are assigned using NOT EXISTS.

-- 25. JOIN Commands
-- Select all patients and their corresponding appointments using INNER JOIN between the PATIENT and APPOINTMENT tables.
-- Select all prescriptions and their corresponding medications using INNER JOIN between PRESCRIPTION and MEDICATION.
-- Select all nurses and their assigned departments using LEFT JOIN between NURSE and DEPARTMENT.
-- Select all treatments and their corresponding doctors using INNER JOIN between TREATMENT and DOCTOR.

-- 26. BETWEEN Command
-- Select all appointments where the appointment_date is between '2023-01-01' and '2023-12-31'.
select * from appointment
where appointment_date between '2023-01-01' and '2023-12-31';

-- Select all treatments where the treatment_date is between '2022-01-01' and '2022-12-31'.
select * from patient_admission
where treatment_start_date between '2022-01-01' and '2022-12-31';

-- Select all patients where the date_of_birth is between '1960-01-01' and '2000-12-31'.
select * from patient
where date_of_birth between '1960-01-01' and '2000-12-31';

-- Select all rooms where the capacity is between 2 and 10.
select * from room 
where room_number between 100 and 500;


-- 27. IN and NOT IN Command
-- Select all patients where the patient_id is in (1, 2, 3).
select * from patient
where patient_id in (1, 2, 3);

-- Select all doctors where the specialization is in ('Cardiology', 'Oncology').
select * from doctor
where specialization in ('Cardiology', 'Oncology');

-- Select all appointments where the status is not in ('Cancelled', 'No Show').
select * from appointment
where status not in ('Cancelled', 'No Show');

-- Select all departments where the department_id is in (1, 2, 5).
select * from department
where department_id in (1, 2, 5);

-- 28. UNION Command
-- Select patients from PATIENT and HOSPITAL_PATIENT using UNION.
-- Select doctors from two different departments using UNION.
-- Use UNION to combine appointments from two different years.
-- Use UNION ALL to combine treatments from multiple departments.

-- 29. ARRAY Command
-- Select all specialization and convert it into an array using ARRAY_AGG().
-- Use UNNEST() to expand arrays from the DEPARTMENT table.
-- Convert patient names into an array using ARRAY_AGG().
-- Use ARRAY functions to select and manipulate data from the TREATMENT table.