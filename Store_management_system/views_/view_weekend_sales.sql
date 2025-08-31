
-- 4) View for Weekend Sales
--Create a view to showcase weekend sales analysis, highlighting the top ten products sold during the 
--weekend along with details such as revenue, location, product name, and product category.

create or replace view view_weekend_sales AS
	select a.store_name,
	a.location,
	b.product_name,
	b.category,
	sum(units * unit_rate) as revenue,
	RANK() OVER (order by sum(units * unit_rate)) as rank,
	d.order_date
	from store a
	inner join inventory aa using(store_id)
	inner join product b using(product_id)
	inner join order_product c ON b.product_id=c.product_id
	inner join orders d using(order_id)
	where extract(DOW FROM order_date) in (0, 6) ---day of week (sun,mon,tue -----..nth day)
	group by a.store_name, a.location, b.product_name, b.category,order_date
	limit 10
;


--select * from view_weekend_sales;

--select extract(week from cast(order_date as date)) from orders;

--select order_date,EXTRACT(DOW FROM order_date) in (0,6) from orders;  ---day of week (sun,mon,tue -----..nth day)


