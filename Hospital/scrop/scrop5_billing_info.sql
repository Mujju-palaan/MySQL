
-- Stored Procedure for Billing Information
-- Create a stored procedure to display detailed billing information for a specified patient. 
-- The output should include treatment details, patient data, billing data, and payment information. 
-- Mark a record as overdue if the total amount remains unpaid for more than 3 days after the bill creation date. 
-- If a single bill has multiple payments, present the receipt IDs as a comma-separated list.
-- drop procedure scrop5_billing_info;
DELIMITER $$
create procedure scrop5_billing_info(
	IN p_patient_id int
)
BEGIN 
	DECLARE d_count_p_id int;
    DECLARE d_payment_ids text;
	--
    select 
		count(patient_id) 
        into d_count_p_id
    from payment
    group by patient_id
	having patient_id = p_patient_id
    ;
    
    -- contat idss
    SELECT 
		GROUP_CONCAT(payment_id ORDER BY payment_date SEPARATOR ',') 
        into d_payment_ids
	FROM payment
	GROUP BY patient_id
    having patient_id = p_patient_id
    ;
    
	-- The output should include treatment details, patient data, billing data, and payment information. 
    select
    a.patient_id as p_id
    ,concat(a.first_name,' ',a.last_name) as patient_name
    ,aa.admit_type
    ,aa.treatment_start_date as T_start
    ,aa.treatment_end_date as T_end
    ,date(b.bill_date) as bill_date
    ,b.total_amount as bill_amount
    ,b.balance_amount
-- Mark a record as overdue if the total amount remains unpaid for more than 3 days after the bill creation date.
	,case
		when b.total_amount = (select sum(amount_paid) from payment where a.patient_id = p_patient_id)
        then 'paid'
	else 'Overdue'
    End as record
-- If a single bill has multiple payments, present the receipt IDs as a comma-separated list.
	,d_payment_ids
    from patient a
    join patient_admission aa using(patient_id)
    join billing b using(admission_id)
    join payment c using(billing_id)
    where a.patient_id = p_patient_id
    ;

END $$
DELIMITER ;

-- call scrop5_billing_info(1);