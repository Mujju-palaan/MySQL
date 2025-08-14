-- 11)Stored Procedure for Customer Login
-- Create a database stored procedure to validate user login, fetch customer details, 
-- and update the last_login_datetime. The procedure should return an error if the 
-- login ID is not found or the password does not match. Ensure the stored encrypted 
-- password is decrypted during the validation process.

DELIMITER $$
create procedure scrop11customer_login(
	IN p_login_id varchar(50)
    ,IN p_password varchar(50)
)

BEGIN
	declare d_count int;
    
	-- select count
    select count(*)
    into d_count
    from customer_login
    where login_id = p_login_id AND password = p_password;
    
	-- fetch customer details, (select * from customer_login)
    if d_count > 0
    then 
		update customer_login
		set last_login_datetime = current_timestamp()
		where login_id = p_login_id;
        SELECT 'Login successful login_id',p_login_id  AS message;
    else
		SELECT CONCAT('login_id or password does not match 
		login_id: ', p_login_id, ', password: ', p_password) AS message;
	END if;
    
END $$
DELIMITER ;

-- call scrop11customer_login('user1', 'password123');