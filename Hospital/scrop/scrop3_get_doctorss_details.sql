-- Stored Procedure for Doctor Management
-- Procedure to select multiple doctors by IDs

DELIMITER $$

CREATE PROCEDURE scrop3_get_doctorss_details (
    IN p_doctor_ids VARCHAR(255)   -- Example: '1,2,3'
)
BEGIN
    SET @qry = CONCAT('SELECT * FROM doctor WHERE doctor_id IN (', p_doctor_ids, ')');
    
    PREPARE stmt FROM @qry;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$

DELIMITER ;

-- CALL scrop3_get_doctorss_details('1,3,5');
