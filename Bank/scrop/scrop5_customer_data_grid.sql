-- 5)Stored Procedure for Customer Data Grid

-- Create a database stored procedure to retrieve comprehensive customer details, 
-- including phone_number and email, for displaying in the Customer Management screen's data grid. 
-- The procedure should also calculate and return the customer's cash balance, credit balance, 
-- and loan balance. Implement pagination for the UI grid using temporary tables, with the UI grid 
-- page number passed as an input parameter.
 
DELIMITER $$

create procedure scrop5_customer_data_grid(
	IN p_customer_id int
) 
BEGIN	
	-- temp table (select * from temp_customer_grid)
    create temporary table if not exists temp_customer_grid(
		customer_name varchar(50)
        ,phone_number varchar(50)
        ,email varchar(50)
        ,cash_balance decimal(10,2)
        ,credit_balance decimal(10,2)
        ,loan_balance decimal(10,2)
    );
    
    -- insertcustomer
    insert into temp_customer_grid
		(customer_name,phone_number,email,cash_balance,credit_balance,loan_balance )
	select
		concat(a.first_name, ' ', a.last_name)  as customer_name
        ,a.phone_number
        ,a.email
        ,b.balance
        ,c.available_credit_limit
        ,loan_amount
	from customer a
    inner join account b using(customer_id)
    inner join card c using(account_id)
    inner join loan d using(account_id)
    inner join loan_instalments e using(loan_id)
    inner join loan_payment f using(instalment_id)
    where customer_id = p_customer_id
    ;

END $$
DELIMITER ;
 
 -- call scrop5_customer_data_grid(1);