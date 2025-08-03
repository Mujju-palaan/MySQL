-- 3)Stored Procedure for Salary Management version 1

-- Write a stored procedure to update the salary of a specific EMPLOYEE by adding a updated salary. 
-- The procedure should take employee_id and new salary as parameters.

DELIMITER $$
create procedure scrop_salary_management(
	IN p_employee_id int
    ,IN p_new_salary decimal(10,2)
)
BEGIN
	-- select * from employee;
	update employee set salary = p_new_salary 
    where employee_id = p_employee_id;
    
END $$
DELIMITER ;

call scrop_salary_management(1, 60000);