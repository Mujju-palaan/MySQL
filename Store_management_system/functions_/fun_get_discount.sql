-- 2) Function to Get Available Discounts
--Write a function that retrieves active discount codes based on current date.
--select * from Discount

create or replace function fun_get_discount(iparam_date date)
	returns varchar
as $$

DECLARE available_discount varchar;

BEGIN 
	select discount_code 
	into available_discount
	from Discount
	where (SELECT DATE(created_at)) =  iparam_date;

	return available_discount;
END;
$$
language plpgsql;
-----WHY isn't it showing all the discount_codes

--select fun_get_discount('2025-01-18')

-- select discount_code 
-- 	from Discount
-- 	where (SELECT DATE(created_at)) =  '2025-01-18';

