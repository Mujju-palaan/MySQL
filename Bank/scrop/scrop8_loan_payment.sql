-- 8)Stored Procedure for Loan Payment
-- Create a stored procedure to manage loan payments. The procedure should execute the following tasks: 
-- log the payment in the transaction table, record the details in the loan payment table, 
-- update the loan instalment records, adjust the account balance, and document the changes in the account history. 
-- If the payment clears the loan in full, update the loan's end date in the LOAN table. 
-- To accommodate payments covering multiple months, accept instalment IDs as input and distribute the funds 
-- across the specified monthly instalment buckets accordingly.

DELIMITER $$
create procedure scrop8_loan_payment (
	IN p_amount decimal(10,2)
    ,IN p_transaction_type varchar(50)		-- ('debit', 'credit')
    ,IN p_payment_mode varchar(50)			-- ('ATM', 'cash deposit', 'loan payment', 'fund transfer', 
											-- 'debit card', 'fees', 'credit card')
    ,IN p_account_id int
    ,IN p_transaction_status varchar(50)	-- ('processing', 'declined', 'completed')
    ,IN p_description varchar(50)
)
BEGIN
	DECLARE d_transaction_id int;
    DECLARE d_balance_before DECIMAL(10,2);
    DECLARE d_balance_after DECIMAL(10,2);
    DECLARE d_instalment_id INT;
    DECLARE d_loan_amount DECIMAL(10,2);
    
	-- log the payment in the transaction table (select * from transaction)
    insert into transaction 
		(amount, transaction_type, payment_mode, account_id, transaction_status, description)
	select
		p_amount, p_transaction_type, p_payment_mode, p_account_id, p_transaction_status, p_description
        ;
    
    -- set d_transaction_id
    SET d_transaction_id = LAST_INSERT_ID();
    
    -- update the loan instalment records (select * from loan_instalments)
    insert into loan_instalments 
		(loan_id, instalment_amount, due_date, paid_status)
	select
		loan_id
        ,p_amount
        ,current_date
        ,true
	from transaction
    inner join account using(account_id)
    inner join loan using(customer_id)
	where transaction_id = d_transaction_id
    ;
    
	-- set d_transaction_id
    SET d_instalment_id = LAST_INSERT_ID();
    
    -- record the details in the loan payment table (select * from loan_payment)
    insert into loan_payment(instalment_id, transaction_id)
    select d_instalment_id, d_transaction_id;
    
    -- d_balance_before
    select balance into d_balance_before
    from account
    where account_id = p_account_id; 
    
    -- update account (select * from account)
    if p_transaction_type = 'credit' then 
		update account 
        set balance = balance + p_amount
        where account_id = p_account_id;
	else
		update account 
        set balance = balance - p_amount
        where account_id = p_account_id;
	END if;
    
	-- d_balance_after
    select balance into d_balance_after
    from account
    where account_id = p_account_id; 
    
    -- adjust the account balance, and document the changes in the account history
	-- (select * from account_history)
    insert into account_history
		(account_id, balance_before, balance_after, transaction_id)
	select
		p_account_id
        ,d_balance_before
        ,d_balance_after
        ,d_transaction_id
	;
    
    -- If the payment clears the loan in full, update the loan's end date in the LOAN table.
    -- (select * from loan)
    select loan_amount into d_loan_amount
    from loan
    where account_id = p_account_id; 
    
    IF p_amount = d_loan_amount then
		UPDATE loan 
        set loan_end_date = current_date
        where account_id = p_account_id; 
        -- RAISE NOTICE 'Loan fully paid and end date updated, 
-- 			LOAN AMOUNT: %, PAID AMOUNT: %', d_loan_amount, p_amount ;
-- 	else
-- 		RAISE EXCEPTION 'Total loan instalments not paid, 
-- 			LOAN AMOUNT: %, PAID AMOUNT: %', d_loan_amount, p_amount ;
--     END IF;

	-- MySQL alternative to RAISE NOTICE: Use SELECT
		SELECT CONCAT('Loan fully paid and end date updated. LOAN AMOUNT: ', d_loan_amount, ', PAID AMOUNT: ', p_amount) AS message;
	ELSE
		SELECT CONCAT('Total loan instalments not paid. LOAN AMOUNT: ', d_loan_amount, ', PAID AMOUNT: ', p_amount) AS message;
	END IF;
    
END $$
DELIMITER ;

-- CALL scrop8_loan_payment(1000.00, 'debit', 'loan payment', 5, 'completed', 'EMI payment');
