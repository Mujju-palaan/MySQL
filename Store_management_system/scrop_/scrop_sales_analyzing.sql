-- 7) Stored Procedure for Analyzing Sales by Store
-- Create a stored procedure to analyze store sales performance. The procedure should display the 
--store name, location, total sales, the number of transactions, and the average transaction value for a given date range. 
--It should also include comparisons to the previous period's sales and highlight stores with significant performance changes. 
--Use a temporary table to store intermediate calculations for efficient data processing and join data from relevant 
--tables such as stores, sales, and transactions.

-- total sales, 
-- the number of transactions,
-- the average transaction value for a given date range.

create or replace procedure scrop_sales_analyzing(
	-- IN iparam_
)
language plpgsql
as $$
BEGIN
	----create temp tbl
	create temp table temp_sales_analyzing(
		store_name varchar(255) not null, 
		location varchar(255) not null,
		sales_count_per_day int not null,
		total_sales numeric(10,2) not null,
		transactions_per_day int not null,					----no. of payments
		avg_transactions numeric(10,2) not null			----avg payment for a given date range.
	);

	----insert into temp tbl select * from store; select * from orders; select * from order_product; select * from payment;
	insert into temp_sales_analyzing(store_name, location, sales_count_per_day ,total_sales, transactions_per_day, avg_transactions)
	(select  a.store_name, a.location
			,COALESCE(count(b.order_id), 0) 
			,COALESCE(sum(b.total_amount), 0)
			,COALESCE(count(c.payment_id), 0)
			,COALESCE (avg(c.amount_paid), 0) 
	FROM store a
	inner join orders b using(store_id)
	inner join payment c using(order_id)
	group by a.store_name, a.location, c.payment_date)
	;
	--It should also include comparisons to the previous period's sales and highlight stores with significant performance changes. 

END;
$$;

--call scrop_sales_analyzing();
--select * from temp_sales_analyzing;