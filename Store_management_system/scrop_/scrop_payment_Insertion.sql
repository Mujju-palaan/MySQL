-- 5)Stored Procedure for Payment Insertion
-- Write a stored procedure to insert new payment information for an order in the Payment Management screen. 
--Also update order status as piad in order table.

create or replace procedure scrop_payment_Insertion(
	IN iparam_payment_date date,
	IN iparam_amount_paid numeric,
	IN iparam_order_id int
)
language plpgsql
as $$
BEGIN
	----inert into payment
	insert into payment(payment_date, amount_paid, order_id )
	values(iparam_payment_date, iparam_amount_paid, iparam_order_id);

	----update order_status
	update orders set order_status = 'Paid'
	where order_id = iparam_order_id;

END;
$$;

--call scrop_payment_Insertion('2025-02-02', 50, 3);
-- select * from payment;
-- select * from orders;
