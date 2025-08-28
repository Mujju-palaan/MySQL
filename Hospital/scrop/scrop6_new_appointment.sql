
-- Stored Procedure for New Appointments
-- Create a stored procedure to insert patient appointment details while ensuring that the assigned 
-- doctor or room is not double-booked. Additionally, automatically generate a billing record based 
-- on the doctor's per-visit fee.
-- drop procedure scrop6_new_appointment;
DELIMITER $$
create procedure scrop6_new_appointment(
	IN p_appointment_date datetime		-- '2026-02-01 10:30:00'
    ,IN p_status varchar(50)			-- 'Scheduled'
    ,IN p_doctor_id int		
    ,IN p_room_id int
    ,IN p_incharge_nurse_id int
    ,IN p_admission_id int
    ,IN p_patient_id int
)
BEGIN
	declare d_room_count int;
    declare d_doctor_count int;
    declare d_appointment_id int;
    declare d_admission_id int;
    declare d_fee decimal(10,2);
    
	 -- 1. Check if doctor is already booked at the same time
    SELECT COUNT(*) 
    INTO d_doctor_count
    FROM appointment
    WHERE doctor_id = p_doctor_id
      AND p_appointment_date between appointment_date AND (appointment_date + INTERVAL 30 MINUTE);

    IF d_doctor_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Doctor already booked for this time slot';
    END IF;
    
     -- 2. Check if room is already booked at the same time
    SELECT COUNT(*) 
    INTO d_room_count
    FROM appointment a
    join room_admit b using(room_id)
    WHERE a.room_id = p_room_id
      AND (p_appointment_date BETWEEN b.start_date AND b.end_date)
      ;

    IF d_room_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Room already booked for this time slot';
    END IF;
    
    -- 3. Get doctor per_visit_fee
    SELECT per_visit_cost 
    INTO d_fee
    FROM doctor
    WHERE doctor_id = p_doctor_id;

	-- 4. new appointment (select * from appointment)
    insert into appointment
		(appointment_date, status, doctor_id, room_id, incharge_nurse_id, admission_id, patient_id)
	values
		(p_appointment_date, p_status, p_doctor_id, p_room_id, p_incharge_nurse_id, p_admission_id, p_patient_id)
	;
    
    -- 5. set
    set d_appointment_id = last_insert_id();
     
    -- 6. 
    select admission_id 
    into d_admission_id
    from appointment
    where appointment_id = d_appointment_id;
    
    -- 7. select * from billing
    insert into billing(bill_date, bill_type, description, total_amount, balance_amount, admission_id)
    values(current_timestamp(), 'Appointment', 'Doctor consultation', d_fee, d_fee, d_admission_id)
    ;
    

END $$
DELIMITER ;

-- call scrop6_new_appointment('2026-03-01 10:30:00', 'Scheduled', 1,1,1,1,1 );

