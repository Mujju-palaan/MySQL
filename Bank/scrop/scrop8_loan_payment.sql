-- 8)Stored Procedure for Loan Payment
-- Create a stored procedure to manage loan payments. The procedure should execute the following tasks: 
-- log the payment in the transaction table, record the details in the loan payment table, 
-- update the loan instalment records, adjust the account balance, and document the changes in the account history. 
-- If the payment clears the loan in full, update the loan's end date in the LOAN table. 
-- To accommodate payments covering multiple months, accept instalment IDs as input and distribute the funds 
-- across the specified monthly instalment buckets accordingly.

DELIMITER $$

create procedure scrop8_loan_payment (
	IN p_amount
    ,IN p_transaction_type
    ,IN p_payment_mode
    ,IN p_account_id
    ,IN p_description
)
BEGIN
	-- log the payment in the transaction table (select * from transaction)
    insert into tranaction 
		(amount, transaction_type, payment_mode, account_id, description)
	select
		(p_amount, p_transaction_type, p_payment_mode, p_account_id, p_description);
    
    
    -- update the loan instalment records (select * from loan_instalments)
    insert into loan_instalments 
		(loan_id, instalment_amount, due_date, paid_status)
	select
    
    -- record the details in the loan payment table (select * from loan_payment)
    
    
    -- adjust the account balance, and document the changes in the account history
    
    -- If the payment clears the loan in full, update the loan's end date in the LOAN table. 
    
END $
DELIMITER ;