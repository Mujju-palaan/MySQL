-- 4)Stored Procedure for Salary Management version 2

-- Design a database stored procedure to update employee salaries for multiple 
-- employee IDs provided as input. The procedure should also accept the salary increase 
-- percentage as an input parameter. Utilize JSON, XML, or SQL table variables to manage 
-- and process multiple employee records. Temporary tables can be used if required. 
-- Input parameters: employee_ids and increase_percent.

DELIMITER $$
create procedure scrop_salary_management(
	IN employee_ids json
    ,IN increase_percent decimal(10,2)
)

BEGIN
	-- temp table (select * from temp_table_emp_ids) drop table temp_table_emp_ids;
	create TEMPORARY  table if not exists  temp_table_emp_ids(employee_id int);
    -- ---------------------------------------------------
    
    -- insert 
    insert into temp_table_emp_ids(employee_id)
    
    WITH data as (
		select employee_ids  as json_array
    )
    select jt.value
    from data,
    JSON_TABLE(
		data.json_array, '$[*]'
        COLUMNS (
			value int path '$'
        )
    ) as jt;
    
-- ---------------------------------------------------
-- update (select * from employee)    
UPDATE employee a
JOIN temp_table_emp_ids b ON a.employee_id = b.employee_id
SET a.salary = a.salary + a.salary * (increase_percent / 100)
;
    
END $$
DELIMITER ;

-- call scrop_salary_management('[9,10]',10);