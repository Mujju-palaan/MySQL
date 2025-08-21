-- Stored Procedure for Doctor Management
-- Write a stored procedure to select data from DOCTOR table.

DELIMITER $$
create procedure scrop3_get_doctor_details(
	IN p_doctor_id int
)
BEGIN
	--
    select * from doctor
    where doctor_id = p_doctor_id;
    
END $$
DELIMITER ;

-- call scrop3_get_doctor_details(1);