-- 2)Function to Calculate Interest on Loans
-- Write a database function that calculates the monthly interest to be added to the 
-- principal amount of a loan each month, based on the loan_amount, interest_rate, 
-- and number_of_monthly_instalments.

DELIMITER $$
create function fun2_cal_intrest_on_loan(p_loan_id int)
returns decimal(10,2)
deterministic

BEGIN
	declare d_total_intrest decimal(10,2);
    
    select ((loan_amount* interest_rate)/100) * number_of_monthly_instalments
    into d_total_intrest
    from loan
    where loan_id = p_loan_id;
    
    return d_total_intrest;
    
END $$
DELIMITER ;

-- select fun2_cal_intrest_on_loan(1);