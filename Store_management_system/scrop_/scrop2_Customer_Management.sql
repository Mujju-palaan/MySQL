-- 2)Stored Procedure for Customer Management
-- Create a stored procedure to insert customer information for the Customer Management screen.

DELIMITER $$
create procedure scrop2_Customer_Management(
	IN p_first_name varchar(50)
    ,IN p_last_name varchar(50)
    ,IN p_gender char(1)
    ,IN p_ID_type varchar(50)
    ,IN p_ID_number varchar(50)
    ,IN p_email varchar(50)
    ,IN p_phone_number varchar(50)
    ,IN p_address varchar(50)
    ,IN p_city_id int
)
BEGIN
	-- select * from customer;
    insert into customer
		(first_name, last_name, gender, ID_type, ID_number, email, phone_number, address, city_id)
    values
		(p_first_name, p_last_name, p_gender, p_ID_type, p_ID_number, p_email, p_phone_number
        , p_address, p_city_id)
	;
    
END $$
DELIMITER ;

-- call scrop2_Customer_Management('dr','mujeeb','M', 'passport', 'W050384', 'mujeeb@fmail.com', '000999888',
-- 	'123 -- hyderabad', 2);