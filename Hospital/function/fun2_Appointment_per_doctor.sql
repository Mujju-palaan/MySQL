-- Function to Calculate Appointment Count per Doctor
-- Write a function that calculates the number of appointments scheduled for a specific doctor.

DELIMITER $$
create function fun2_Appointment_per_doctor(p_doctor_id int)
returns int
deterministic
BEGIN 
	declare Appointment_count int;
	--
    select count(*)
    into Appointment_count
    from appointment a
    where doctor_id = p_doctor_id
    ;
    
    return Appointment_count;

END $$
DELIMITER ;

select fun2_Appointment_per_doctor(1);