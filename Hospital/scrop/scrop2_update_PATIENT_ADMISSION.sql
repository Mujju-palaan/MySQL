-- Stored Procedure for Patient Admit Management
-- Write a stored procedure to update data in PATIENT_ADMIT table.
-- Done

DELIMITER $$
create procedure scrop2_update_PATIENT_ADMISSION(
	IN p_patient_id int
    ,IN p_treatment_description varchar(50)
)
BEGIN
	-- select * from PATIENT_ADMISSION
    update PATIENT_ADMISSION
    set treatment_description = p_treatment_description
    where patient_id = p_patient_id;

END $$
DELIMITER ;

-- call scrop2_update_PATIENT_ADMISSION(1, 'Hand Fracture');
