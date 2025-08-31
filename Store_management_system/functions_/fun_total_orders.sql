--Function Tasks:
-- 1) Function to Calculate Total Orders for Customer
--Write a function that calculates the total number of orders placed by a specific customer.

create or replace function fun_total_orders(iparam_customer_id INT	)
	returns int
as $$

DECLARE total_orders int;

BEGIN
	select count(*) 
	into total_orders
	from orders
	where customer_id = iparam_customer_id;

	return total_orders;
END;
$$ language plpgsql;

--select * from fun_total_orders(1);

