-- 1)Function to Calculate Total Loan Balance per Customer

-- Write a database function to calculate the total outstanding loan balance for a customer 
-- based on their loans. Use SQL variables within the function to implement this logic.

DELIMITER $$

create function fun1_total_loan_balance_per_cust(p_customer_id int)
returns decimal(10,2)
DETERMINISTIC
BEGIN
	declare d_total_loan decimal(10,2);
    
	-- select * from loan
	select sum(loan_amount)
    into d_total_loan
    from loan
    group by customer_id
    having customer_id = p_customer_id;
    
    return d_total_loan;
    
END $$
DELIMITER ;

-- select fun1_total_loan_balance_per_cust(1);