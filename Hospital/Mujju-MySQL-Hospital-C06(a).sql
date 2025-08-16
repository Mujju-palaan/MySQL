-- Question 1: Insert Data into all Tables
-- Write SQL queries to populate each table created in the Chapter 5 assignment with at least 10 rows of data.

-- select * from DEPARTMENT
insert into DEPARTMENT (department_name, location )
values ('Cardiology', 'Building A, Floor 3'),  
		('Neurology', 'Building B, Floor 2'),  
		('Orthopedics', 'Building C, Floor 1'),  
		('Pediatrics', 'Building A, Floor 4'),  
		('Oncology', 'Building B, Floor 3'),  
		('Emergency', 'Main Building, Ground Floor'),  
		('Radiology', 'Building D, Floor 1'),  
		('Dermatology', 'Building E, Floor 2'),  
		('Urology', 'Building C, Floor 2'),  
		('Gastroenterology', 'Building A, Floor 5')
;  
		

--select * from doctor
insert into doctor(first_name, last_name, specialization, email, phone_number, per_visit_cost, active, login_id)
values ( 'Dr.Kefaya','Ghouri','Pediatricians','Kefaya.Ghouri@tansyacademy.com', '123433567890', 100, 't', 'dr_kefaya'),
		( 'Dr.Farheen', 'sultana', 'Gynecologists', 'Farheen.sultana@tansyacademy.com', '12345673234891', 80, 't', 'dr_farheen'),
		( 'Dr.Uzma','Sheikh','Orthopedic','Uzma.Sheikh@tansyacademy.com', '123433324567890', 90, 't', 'dr_uzma'),
		( 'Dr.Arsheen', 'Fatima', 'ENT specialists', 'Arsheen.Fatima@tansyacademy.com', '1234324355673234891', 69, 't', 'dr_arsheen'),
		('Dupont', 'Alice', 'Cardiologie', 'alice.dupont@example.com', '0712345678', 50, 't', 'alice_dupont'),  
		('Martin', 'Bob', 'Neurologie', 'bob.martin@example.com', '0723456789', 60, 't', 'bob_martin'),  
		('Thomas', 'David', 'Dermatologie', 'david.thomas@example.com', '0745678901', 55, 't', 'david_thomas'),  
		('Petit', 'Emma', 'Ophtalmologie', 'emma.petit@example.com', '0756789012', 65, 'f', 'emma_petit'),  
		('Durand', 'Henry', 'Radiologie', 'henry.durand@example.com', '0789012345', 80, 't', 'henry_durand'),  
		('Moreau', 'Isla', 'Oncologie', 'isla.moreau@example.com', '0790123456', 90, 'f', 'isla_moreau'),  
		('Simon', 'Jack', 'Medecine Generale', 'jack.simon@example.com', '0701234567', 40, 't', 'jack_simon');  

--select * from DOCTOR_DEPARTMENT;
insert into DOCTOR_DEPARTMENT(doctor_id, department_id) 
values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);


--select * from nurse;
insert into nurse(first_name, last_name, date_of_birth, email, phone_number,active,login_id)
values 	('Emily', 'Smith', '1985-06-15', 'emily.smith@example.com', '555-1234', '1', 'emily_smith'),  
		('Michael', 'Johnson', '1990-09-22', 'michael.johnson@example.com', '555-5678', '1', 'michael_johnson'),  
		('Sophia', 'Williams', '1988-12-05', 'sophia.williams@example.com', '555-9101', '1', 'sophia_williams'),  
		('Daniel', 'Brown', '1992-04-10', 'daniel.brown@example.com', '555-1122', '0', 'daniel_brown'),  
		('Olivia', 'Jones', '1987-07-30', 'olivia.jones@example.com', '555-3344', '1', 'olivia_jones'),  
		('James', 'Garcia', '1993-02-18', 'james.garcia@example.com', '555-5566', '1', 'james_garcia'),  
		('Isabella', 'Martinez', '1991-05-25', 'isabella.martinez@example.com', '555-7788', '0', 'isabella_martinez'),  
		('William', 'Davis', '1986-11-03', 'william.davis@example.com', '555-9900', '1', 'william_davis'),  
		('Mia', 'Rodriguez', '1994-08-12', 'mia.rodriguez@example.com', '555-2233', '1', 'mia_rodriguez'),  
		('Benjamin', 'Lopez', '1989-03-28', 'benjamin.lopez@example.com', '555-4455', '0', 'benjamin_lopez');  

--select * from ROOM;
insert into ROOM(room_number, room_type, daily_rate, department_id)
values ('101', 'General', 150, 1),  
		('102', 'General', 180, 2),  
		('201', 'ICU', 350, 3),  
		('202', 'ICU', 380, 4),  
		('301', 'Private', 250, 5),  
		('302', 'Private', 270, 6),  
		('401', 'General', 130, 7),  
		('402', 'General', 160, 8),  
		('501', 'Private', 300, 9),  
		('502', 'Private', 320, 10);  		

--select * from patient
insert into patient(first_name, last_name, date_of_birth, email, phone_number)
values 
		('Smith', 'Alice', '1985-03-12', 'alice.smith@example.com', '0612345678'),  
		('Johnson', 'Bob', '1992-07-25', 'bob.johnson@example.com', '0623456789'),  
		('Williams', 'Charlie', '1978-11-05', 'charlie.williams@example.com', '0634567890'),  
		('Brown', 'David', '2000-01-30', 'david.brown@example.com', '0645678901'),  
		('Jones', 'Emma', '1995-06-18', 'emma.jones@example.com', '0656789012'),  
		('Garcia', 'Frank', '1983-09-22', 'frank.garcia@example.com', '0667890123'),  
		('Miller', 'Grace', '1999-12-10', 'grace.miller@example.com', '0678901234'),  
		('Davis', 'Henry', '1987-04-03', 'henry.davis@example.com', '0689012345'),  
		('Rodriguez', 'Isla', '1990-08-14', 'isla.rodriguez@example.com', '0690123456'),  
		('Martinez', 'Jack', '2002-02-27', 'jack.martinez@example.com', '0601234567') 
;

--select * from PATIENT_ADMISSION
insert into PATIENT_ADMISSION(admit_type, treatment_description, treatment_start_date, treatment_end_date, patient_id)
values ('In Patient', 'Fracture treatment', '2025-02-01', '2025-02-10', 1),
		('Out Patient', 'Knee surgery', '2025-02-05', '2025-02-15', 2),
		('In Patient', 'Heart attack treatment', '2025-02-02', '2025-02-12', 3),
		('Out Patient', 'Appendectomy', '2025-02-03', '2025-02-13', 4),
		('In Patient', 'Stroke treatment', '2025-02-04', '2025-02-14', 5),
		('Out Patient', 'Hip replacement', '2025-02-06', '2025-02-16', 6),
		('In Patient', 'Severe allergic reaction', '2025-02-07', '2025-02-17', 7),
		('Out Patient', 'Cataract surgery', '2025-02-08', '2025-02-18', 8),
		('In Patient', 'Burn treatment', '2025-02-09', '2025-02-19', 9),
		('Out Patient', 'Spinal surgery', '2025-02-10', '2025-02-20', 10);

--select * from appointment;
insert into appointment(appointment_date, appointment_time, status, patient_id, doctor_id, room_id, incharge_nurse_id, admission_id)
values	('2025-02-01', '10:30:00', 'Scheduled', 1, 1, 1, 1, 1),
		('2025-02-01', '11:00:00', 'Completed', 2, 2, 2, 2, 2),
		('2025-02-02', '09:15:00', 'Cancelled', 3, 3, 3, 3, 3),
		('2025-02-02', '14:45:00', 'Scheduled', 4, 4, 4, 4, 4),
		('2025-02-03', '16:30:00', 'Completed', 5, 5, 5, 5, 5),
		('2025-02-03', '08:00:00', 'Scheduled', 6, 6, 6, 6, 6),
		('2025-02-04', '12:15:00', 'Cancelled', 7, 7, 7, 7, 7),
		('2025-02-04', '13:45:00', 'Scheduled', 8, 8, 8, 8, 8),
		('2025-02-05', '15:30:00', 'Completed', 9, 9, 9, 9, 9),
		('2025-02-05', '10:00:00', 'Scheduled', 10, 10, 10, 10, 10)
;

--select * from ROOM_ADMIT;
insert into ROOM_ADMIT(start_date, end_date, room_id, incharge_nurse_id, admission_id)
values ('2025-02-01', '2025-02-10', 1, 1, 1),
		('2025-02-05', '2025-02-15', 2, 2, 2),
		('2025-02-02', '2025-02-12', 3, 3, 3),
		('2025-02-03', '2025-02-13', 4, 4, 4),
		('2025-02-04', '2025-02-14', 5, 5, 5),
		('2025-02-06', '2025-02-16', 6, 6, 6),
		('2025-02-07', '2025-02-17', 7, 7, 7),
		('2025-02-08', '2025-02-18', 8, 8, 8),
		('2025-02-09', '2025-02-19', 9, 9, 9),
		('2025-02-10', '2025-02-20', 10, 10, 10);
	
--select * from MEDICATION;
insert into MEDICATION(medication_name, medication_type, dosage)
values ('Aspirin', 'Pain reliever', '500mg'),
		('Lisinopril', 'Antihypertensive', '10mg'),
		('Amoxicillin', 'Antibiotic', '250mg'),
		('Metformin', 'Antidiabetic', '500mg'),
		('Ibuprofen', 'Anti-inflammatory', '200mg'),
		('Simvastatin', 'Cholesterol-lowering', '20mg'),
		('Paracetamol', 'Pain reliever', '500mg'),
		('Alprazolam', 'Anxiolytic', '0.5mg'),
		('Furosemide', 'Diuretic', '40mg'),
		('Omeprazole', 'Proton pump inhibitor', '20mg');

--select * from PRESCRIPTION;
insert into PRESCRIPTION(prescription_date, medication_id, patient_id, doctor_id, start_date, end_date, 
morning_flag, noon_flag, evening_flag, admission_id)
values ('2025-02-01', 1, 1, 1, '2025-02-01', '2025-02-10', '1', '0', '0', 1),
		('2025-02-05', 2, 2, 2, '2025-02-05', '2025-02-15', '1', '1', '0', 2),
		('2025-02-02', 3, 3, 3, '2025-02-02', '2025-02-12', '0', '1', '0', 3),
		('2025-02-03', 4, 4, 4, '2025-02-03', '2025-02-13', '1', '0', '1', 4),
		('2025-02-04', 5, 5, 5, '2025-02-04', '2025-02-14', '0', '1', '1', 5),
		('2025-02-06', 6, 6, 6, '2025-02-06', '2025-02-16', '1', '0', '0', 6),
		('2025-02-07', 7, 7, 7, '2025-02-07', '2025-02-17', '1', '1', '0', 7),
		('2025-02-08', 8, 8, 8, '2025-02-08', '2025-02-18', '0', '0', '1', 8),
		('2025-02-09', 9, 9, 9, '2025-02-09', '2025-02-19', '1', '0', '1', 9),
		('2025-02-10', 10, 10, 10, '2025-02-10', '2025-02-20', '0', '1', '1', 10);

--select * from billing;
insert into billing(bill_date, bill_type, description, total_amount, balance_amount, admission_id)
values
		('2025-02-01', 'Room Charge', 'Room charges and treatment', 5000.00, 1000.00, 1),
		('2025-02-05', 'Doctor Appointment', 'Consultation and medications', 1500.00, 500.00, 2),
		('2025-02-02', 'Room Charge', 'Emergency care and surgery', 8000.00, 1500.00, 3),
		('2025-02-03', 'Room Charge', 'Surgical procedure and follow-up', 6000.00, 1200.00, 4),
		('2025-02-04', 'Diagnostic', 'X-ray and prescription', 800.00, 200.00, 5),
		('2025-02-06', 'Room Charge', 'Heart treatment and room charges', 10000.00, 3000.00, 6),
		('2025-02-07', 'Doctor Appointment', 'Check-up and medication', 500.00, 100.00, 7),
		('2025-02-08', 'Room Charge', 'Surgical procedure and ICU stay', 12000.00, 4000.00, 8),
		('2025-02-09', 'Diagnostic', 'Lab tests and consultation', 1200.00, 300.00, 9),
		('2025-02-10', 'Food', 'Meals during stay', 700.00, 150.00, 10)
;

--select * from PAYMENT
insert into PAYMENT(bill_id, patient_id, amount_paid, payment_date)
values (1, 1, 4000.00, '2025-02-01'),
		(2, 2, 1000.00, '2025-02-05'),
		(3, 3, 6500.00, '2025-02-02'),
		(4, 4, 4800.00, '2025-02-03'),
		(5, 5, 600.00, '2025-02-04'),
		(6, 6, 7000.00, '2025-02-06'),
		(7, 7, 400.00, '2025-02-07'),
		(8, 8, 8000.00, '2025-02-08'),
		(9, 9, 900.00, '2025-02-09'),
		(10, 10, 5500.00, '2025-02-10');


--select * from USER_LOGIN;
insert into USER_LOGIN(login_id, password, active_flag)
values (1, 'password123', 't'),
	(2, 'mypassword456', 't'),
	(3, 'securepass789', 't'),
	(4, 'pass1234', 't'),
	(5, 'testpassword001', 'f'),
	(6, 'adminpassword999', 't'),
	(7, 'password987', 't'),
	(8, 'userpass567', 'f'),
	(9, 'welcome123', 't'),
	(10, 'strongpassword852', 't');

--select * from audit_log;
insert into audit_log(log_date, action ,user_id)
values
		('2025-02-01', 'Login', 1),
		('2025-02-02', 'Logout', 2),
		('2025-02-03', 'Login', 3),
		('2025-02-04', 'Logout', 4),
		('2025-02-05', 'Login', 5),
		('2025-02-06', 'Logout', 6),
		('2025-02-07', 'Login', 7),
		('2025-02-08', 'Logout', 8),
		('2025-02-09', 'Login', 9),
		('2025-02-10', 'Logout', 10);

insert into appointment(appointment_date, appointment_time, status, patient_id, doctor_id, room_id, incharge_nurse_id, admission_id)
values	('2025-02-01', '10:30:00', 'Scheduled', 1, 1, 1, 1, 1),
		('2025-02-01', '11:00:00', 'Completed', 2, 2, 2, 2, 2),
		('2025-02-02', '09:15:00', 'Cancelled', 3, 3, 3, 3, 3),
		('2025-02-02', '14:45:00', 'Scheduled', 4, 4, 4, 4, 4),
		('2025-02-03', '16:30:00', 'Completed', 5, 5, 5, 5, 5),
		('2025-02-03', '08:00:00', 'Scheduled', 6, 6, 6, 6, 6),
		('2025-02-04', '12:15:00', 'Cancelled', 7, 7, 7, 7, 7),
		('2025-02-04', '13:45:00', 'Scheduled', 8, 8, 8, 8, 8),
		('2025-02-05', '15:30:00', 'Completed', 9, 9, 9, 9, 9),
		('2025-02-05', '10:00:00', 'Scheduled', 10, 10, 10, 10, 10)
;
