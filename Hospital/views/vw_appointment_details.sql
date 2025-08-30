-- View for Appointment Details
-- Create a view to display appointment details including patient name, doctor name, 
-- doctor specialization, appointment date, room name and status.

create view vw_appointment_details AS
select 
	concat(d.first_name, ' ', d.last_name) as patient_name
    ,concat(c.first_name, ' ', c.last_name) as doctor_name
    ,c.specialization
    ,a.appointment_date
    ,b.room_number
    ,a.status
    from appointment a
    inner join room b using(room_id)
    inner join doctor c using(doctor_id)
    inner join patient d using(patient_id)
    ;
    
    -- select * from vw_appointment_details;