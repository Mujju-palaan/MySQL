-- Trigger on Transaction Amount Changes

-- 1.Create a trigger on the TRANSACTION table that logs changes to the amount field into the 
-- AUDIT_LOG table. The log should capture the transaction_id, old_amount, new_amount, log_date, 
-- and employee_id
create table if not exists transaction_log(
	transaction_id int
	,old_amount numeric(10,2)
	,new_amount numeric(10,2)
	,log_date timestamp default current_timestamp
	,account_id int
);

DELIMITER $$
create trigger trg_transaction_log
after insert on transaction
for each row
-- select * from transaction
BEGIN
	declare d_old_amount decimal(10,2);
    
	select amount
    into d_old_amount
    from transaction
    where account_id = new.account_id
    order by transaction_id desc;
    
	insert into transaction_log
		(transaction_id, old_amount, new_amount, log_date, account_id)
	values
		(new.transaction_id, d_old_amount, new.amount, now(), new.account_id)
    ;

END $$
DELIMITER ;