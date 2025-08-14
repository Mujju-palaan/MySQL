-- 10)Stored Procedure to Reverse a Fund Transfer

-- Develop a stored procedure to handle fund transfer refunds. The procedure should execute the
-- following actions. update the fund transfer record, log the refund in the transaction table,
-- adjust the account balance, and document the changes in the account history.


DELIMITER $$

create procedure scrop10_refund_transfer(
	IN p_beneficiary_id int
    ,IN p_transaction_id int
    ,IN p_refund_transaction_id int
    ,IN p_transfer_status varchar(50)		-- ('processing', 'failed', 'completed')
)
BEGIN
	declare d_amount decimal(10,2);
    declare d_account_id int;
    declare d_blalance_before decimal(10,2);
    declare d_blalance_after decimal(10,2);
    
    	-- insert a record into the fund transfer table, (select * from fund_transfer)
    insert into fund_transfer
		(beneficiary_id, transaction_id, refund_transaction_id, transfer_status)
	values
		(p_beneficiary_id, p_transaction_id, p_refund_transaction_id, p_transfer_status);
    
    
    -- log the transaction in the transaction table (select * from transaction)
    update transaction
    set description = 'Amount Refunded'
    where transaction_id = p_transaction_id;
    
    -- accoun_id, amount (select * from account)
    select amount into d_amount
    from transaction
    where transaction_id = p_transaction_id;
    
    select account_id into d_account_id
    from transaction
    where transaction_id = p_transaction_id;
    
    -- d_blalance_before
    select balance into d_blalance_before
    from account
    where account_id = d_account_id;
    
    --  update the account balance, (select * from account)
    update account
    set balance = balance + d_amount
    where account_id = d_account_id;
    
    -- d_blalance_after
    select balance into d_blalance_after
    from account
    where account_id = d_account_id;
    
    -- record the changes in the account history (select * from account_history)
    insert into account_history
		(account_id, balance_before, balance_after, transaction_id)
    values
		(d_account_id, d_blalance_before, d_blalance_after, p_transaction_id);
END $$
DELIMITER ;

    -- call scrop10_refund_transfer(2, 2, 2, 'completed');
