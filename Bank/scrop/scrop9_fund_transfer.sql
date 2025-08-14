-- 9)Stored Procedure for Fund Transfer

-- Create a stored procedure to manage fund transfer details. 
-- The procedure should perform the following operations: insert a record into the fund transfer table, 
-- log the transaction in the transaction table, update the account balance, and record the changes 
-- in the account history.
-- call scrop9_fund_transfer(500,'debit','fund transfer',3,'completed','money transfer');

DELIMITER $$

create procedure scrop9_fund_transfer(
	IN p_amount int
    ,IN p_transaction_type varchar(50) 		-- ('debit', 'credit')
    ,IN p_payment_mode varchar(50)			-- ('ATM', 'cash deposit', 'loan payment', 'fund transfer', 
											-- 'debit card', 'fees', 'credit card')
    ,IN p_account_id int
    ,IN p_transaction_status varchar(50)	-- ('processing', 'declined', 'completed')
    ,IN p_description varchar(50)
)
BEGIN
	declare d_transaction_id int;
	declare d_beneficiary_id int;
	declare d_amount decimal(10,2);
    declare d_blalance_before decimal(10,2);
    declare d_blalance_after decimal(10,2);
        
        
    -- log the transaction in the transaction table (select * from transaction)
    insert into transaction
		(amount, transaction_type, payment_mode, account_id, transaction_status, description)
    values
		(p_amount, p_transaction_type, p_payment_mode, 
        p_account_id, p_transaction_status, p_description)
        ;
    
    -- set
    set d_transaction_id = last_insert_id();
    
    -- select
    select beneficiary_id 
    into d_beneficiary_id
    from beneficiary
    inner join loan on customer_id = primary_consumer_id
    where account_id = p_account_id
    ;
    
    	-- insert a record into the fund transfer table, (select * from fund_transfer)
    insert into fund_transfer
		(beneficiary_id, transaction_id, refund_transaction_id, transfer_status)
	values
		(d_beneficiary_id, d_transaction_id, d_transaction_id, p_transaction_status);

    
    -- accoun_id, amount (select * from account)
    select amount into d_amount
    from transaction
    where transaction_id = d_transaction_id;
    
    -- d_blalance_before
    select balance into d_blalance_before
    from account
    where account_id = p_account_id;
    
    --  update the account balance, (select * from account)
    update account
    set balance = balance + d_amount
    where account_id = p_account_id;
    
    -- d_blalance_after
    select balance into d_blalance_after
    from account
    where account_id = p_account_id;
    
    -- record the changes in the account history (select * from account_history)
    insert into account_history
		(account_id, balance_before, balance_after, transaction_id)
    values
		(p_account_id, d_blalance_before, d_blalance_after, d_transaction_id);
END $$
DELIMITER ;

