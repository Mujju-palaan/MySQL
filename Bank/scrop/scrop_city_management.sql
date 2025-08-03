-- 2)Stored Procedure for City Management

-- Write a stored procedure to insert a new record into the CITY table. 
-- The procedure should take country_name and city_name as input parameters.

DELIMITER $$

Create procedure scrop_city_management(
	IN p_country_name varchar(50),
    IN p_city_name varchar(50)
)
BEGIN 
	-- select * from city;
    insert into city(country_name, city_name)
    values(p_country_name, p_city_name);
END $$
DELIMITER ;

-- call scrop_city_management('India','Hyderabad');