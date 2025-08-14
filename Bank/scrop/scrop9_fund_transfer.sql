-- 9)Stored Procedure for Fund Transfer

-- Create a stored procedure to manage fund transfer details. 
-- The procedure should perform the following operations: insert a record into the fund transfer table, 
-- log the transaction in the transaction table, update the account balance, and record the changes 
-- in the account history.

DELIMITER $$

create procedure scrop9_fund_transfer(
	IN p_beneficiary_id int
    ,IN p_transaction_id int
    ,IN p_refund_transaction_id int
    ,IN p_transfer_status varchar(50)		-- ('processing', 'failed', 'completed')
)
BEGIN
	declare d_amount decimal(10,2);
    declare d_account_id int;
    declare d_account_id int;
    
	-- insert a record into the fund transfer table, (select * from fund_transfer)
    insert into fund_transfer
		(beneficiary_id, transaction_id, refund_transaction_id, transfer_status)
	values
		(p_beneficiary_id, p_transaction_id, p_refund_transaction_id, p_transfer_status);
    
    
    -- log the transaction in the transaction table (select * from transaction)
    update transaction
    set description = 'Amount Refunded'
    where transaction_id = p_transaction_id;
    
    -- accoun_id, amount
    select amount into d_amount
    where transaction_id = p_transaction_id;
    
    select account_id into d_account_id
    where transaction_id = p_transaction_id;
    
    select balance into d_balance
    where account_id = d_account_id;
    
    --  update the account balance, (select * from account)
    update account
    set balance = balance + d_amount
    where account_id = d_account_id;
    
    -- record the changes in the account history (select * from account_history)
    
    
END $$
DELIMITER ;