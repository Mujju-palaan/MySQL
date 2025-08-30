-- Stored Procedure for Payment Receipts
-- Create a stored procedure to insert payment receipt details and automatically update the 
-- associated bill status to indicate whether it is fully paid or partially paid.
DELIMITER $$
create procedure scrop8_payment_receipt(
	IN p_billing_id int
    ,IN p_patient_id int
    ,IN p_amount_paid decimal(10,2)
)

BEGIN
	declare d_payment_id int;
    declare d_billing_id int;
    
	-- insert payment receipt details (select * from payment)
    insert into payment(billing_id, patient_id, amount_paid)
    values(p_billing_id, p_patient_id, p_amount_paid);
    
    -- set
    set d_payment_id = last_insert_id();
    
    --
    select billing_id
	into d_billing_id
    from payment
    where payment_id = d_payment_id
    ;
    
    -- update the associated bill status to indicate whether it is fully paid or partially paid
    -- select * from billing
    update billing
    set balance_amount = balance_amount - p_amount_paid
		,description = case
						when balance_amount = 0 then 'Amount is fully paid '
                        else 'Amount is partially paid'
                        END
    where billing_id = d_billing_id
    ;

END $$
DELIMITER ;

-- call scrop8_payment_receipt(1, 1, 100);
