-- 1)Stored Procedure for Employee Information

-- Write a stored procedure that retrieves all rows from the EMPLOYEE table where the 
-- city is a specific value passed as a input parameter.

DELIMITER $$
Create procedure scrop_Emp_info(
	IN p_employee_id int
)
BEGIN 
	Select * from employee
    where employee_id = p_employee_id;
    
END $$
DELIMITER ;

-- call scrop_Emp_info(1);
