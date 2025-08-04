-- 6)Stored Procedure for Loan Payments

-- Create a database stored procedure to fetch all loan instalments for a specific customer 
-- by accepting customer_id as an input parameter. The procedure should join the CUSTOMER, LOAN, 
-- and LOAN_INSTALMENTS tables to retrieve relevant details, including loan_id, instalment_amount, 
-- due_date, paid_date, and loan_start_date.

DELIMITER $$
create procedure scrop6_loan_payment(
	IN p_customer_id varchar(50)
)
BEGIN
	-- 
    select 
		concat(first_name, ' ', last_name) as customer_name
        ,loan_id
        ,instalment_amount
        ,due_date
        ,paid_status
        ,loan_start_date
	from customer a 
    inner join account aa using(customer_id)
    inner join loan b using(account_id)
    inner join LOAN_INSTALMENTS c using(loan_id)
    where customer_id = p_customer_id
    ;
    
END $$
DELIMITER ;

-- call scrop6_loan_payment(1);