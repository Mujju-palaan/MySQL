-- 6)Stored Procedure for Customer Analysis

-- Develop a stored procedure to analyze customer revenue. This procedure should generate a report 
--displaying the month name, customer name, the number of orders for each specified month, 
--and the total revenue for that month. The output must include all months of the current year, 
--even if no orders were placed in certain months. Use the dim dimension table as the primary data source 
--and apply left joins with related tables to retrieve the necessary details. Incorporate the temporary table 
--technique within the stored procedure for efficient data processing.
--select * from orders;

--drop procedure scrop_store_revenue_analysis;
create or replace procedure scrop_store_revenue_analysis(
)
as $$
BEGIN
	----create tbl
	create temp table temp_store_revenue(
		date_id int,
		month_name varchar(20),
		store_name varchar(20),
		order_per_month int	,
		revenue_per_month numeric(10,2)
	);

	----insert tbl. select * from temp_store_revenue
	insert into temp_store_revenue(date_id, month_name, store_name, order_per_month, revenue_per_month)
	----select Query select * from date_dim_sample
	(select
	 dd.date_id
	,to_char(a.order_date, 'Month') 
	,b.store_name
	-- ,EXTRACT(month  FROM a.order_date) as month
	,count(a.order_id)
	,sum(a.total_amount)
	from date_dim_sample dd
	left join orders a On dd.calendar_date = a.order_date
	inner join store b using(store_id)
	where EXTRACT(year FROM order_date) = date_part('year', CURRENT_DATE)
	group by EXTRACT(month  FROM order_date),to_char(order_date, 'Month'), b.store_name, dd.date_id 
	order by EXTRACT(month  FROM order_date),to_char(order_date, 'Month')
	);

END;
$$ language plpgsql;

--call scrop_store_revenue_analysis();
--select * from temp_store_revenue;

---select * from orders
select 
	to_char(a.order_date, 'Month') AS Month
	,b.store_name
	-- ,EXTRACT(month  FROM a.order_date) as month
	,sum(a.total_amount) as revenue_per_month
	,count(*) 
	from orders a
left join store b using(store_id)
where EXTRACT(year FROM order_date) = date_part('year', CURRENT_DATE)
group by EXTRACT(month  FROM order_date),to_char(order_date, 'Month'),
	b.store_name
order by EXTRACT(month  FROM order_date),to_char(order_date, 'Month');
