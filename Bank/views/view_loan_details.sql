-- View for Loan Details

-- Create a SQL view to summarize loan details, including: loan_id, customer_id, first_name, 
-- last_name, loan_amount, interest_rate, loan_start_date, and loan_end_date.
--  Include the total number of instalments and the sum of all instalment amounts for each loan.

create view view_loan_details AS
select 
	loan_id
    ,customer_id
    ,first_name
    ,last_name
    ,loan_amount
    ,interest_rate
    ,loan_start_date
    ,loan_end_date
    ,count(instalment_id)
    ,sum(instalment_amount)
from customer
inner join account using(customer_id)
inner join loan using(account_id)
inner join loan_instalments using(loan_id)
group by loan_id
    ,customer_id
    ,first_name
    ,last_name
;