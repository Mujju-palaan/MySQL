-- View for Patient Discharge Billing Information
-- Create a view to display treatment billing information, including treatment description, 
-- bill date, bill amount, paid amount, pay receipt id, and balance amount. 
-- If multiple payments have been made for a single bill, display the receipt IDs as a comma-separated list. 
-- There shall be one record per bill, repeating treatment information is ok.

create view vw_discharge_billing_info AS
select 
	concat(c.first_name, ' ',c.last_name) as patient_name
	,treatment_description
    ,bill_date
    ,total_amount
    ,total_amount - balance_amount as paid_amount
	,GROUP_CONCAT(d.payment_id ORDER BY d.payment_date SEPARATOR ',') AS receipt_ids
    ,balance_amount
from patient_admission a
inner join billing b using(admission_id)
inner join patient c using(patient_id)
inner join payment d using(billing_id)
group by d.patient_id
	,concat(c.first_name, ' ',c.last_name)
	,treatment_description
    ,bill_date
    ,total_amount
    ,total_amount - balance_amount
    ,balance_amount
;


-- select * from vw_discharge_billing_info;