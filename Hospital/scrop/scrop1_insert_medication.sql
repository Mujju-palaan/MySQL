-- Stored Procedure for Medication Management
-- Write a stored procedure to insert data into MEDICATION table.

DELIMITER $$
create procedure scrop1_insert_medication(
	IN p_medication_name varchar(50)
    ,IN p_medication_type varchar(50)
    ,IN p_dosage varchar(50)
)

BEGIN
	-- select * from medication
	insert into medication(medication_name, medication_type, dosage)
    values(p_medication_name, p_medication_type, p_dosage);

END $$
DELIMITER ;

-- call scrop1_insert_medication('Zofer','Antiemetic','4 mg to 8 mg');