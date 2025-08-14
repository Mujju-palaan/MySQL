-- 3)Function to display loan details

-- Write a database function that retrieves customer loan information based on the screen 
-- design provided at the bottom of this webpage.

DELIMITER $$
create function fun3_loan_details(p_loan_id int)
returns varchar(500)
deterministic
BEGIN
	declare d_cust_details varchar(500);
    
    select concat( 'LOAN ID: ' , loan_id,
					',LOAN AMOUNT: ', loan_amount,
                    ',ACCOUNT ID: ', account_id
				)
	into d_cust_details
	from loan
    where loan_id = p_loan_id
    ;
    
    return d_cust_details;

END $$
DELIMITER ;

-- select fun3_loan_details(2);