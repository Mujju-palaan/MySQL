-- 2) View for Order Details
-- Design a view to display order details, including the customer name, order date, and total amount,
-- for the Order Overview screen. Additionally, include a column that lists all purchased products in a single column,
-- separated by commas (e.g., Milk, Soda, Lays).
-- select * from order_product;
-- select * from product;
-- select * from orders;

--drop view view_order_details
create or replace view view_order_details as 
	select a.first_name||' '||a.last_name as customer_name,
			b.order_date, 
			b.total_amount,
			count(c.order_product_id),
			STRING_AGG(distinct d.product_name, ', ') AS pproduct_array
	from customer a
	inner join orders b using(customer_id)
	inner join order_product c using(order_id)
	inner join product d using(product_id)
	group by a.first_name||' '||a.last_name,
			b.order_date, b.total_amount
;
--select * from view_order_details;

