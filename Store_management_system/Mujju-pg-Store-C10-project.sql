-- Chapter 10 - Projects
-- Final Capstone Project 1: Store Management System in Postgres SQL Server

-- Assignment Tasks:
-- Stored Procedure Tasks:
---------------------------------------------------------------------------------------------------------------------------------------
-- 1)Stored Procedure for Product Management Data Grid
-- Write a stored procedure to retrieve all product details for the Product Management screen,
-- including product_name, price, and quantity_in_stock.
-----select product_name, price, quantity_in_stock from product;

create or replace procedure scrop_get_product_details(
	in iparam_product_id int
)
language plpgsql
as $$

declare product_rec record;

Begin
	for product_rec in
	select product_name, price, quantity_in_stock from product
	where product_id = iparam_product_id

	loop
		RAISE NOTICE 'Product Name: %, Price: %, Stock: %', product_rec.product_name,product_rec.price,product_rec.quantity_in_stock;
 	end loop;

END;
$$;

--call scrop_get_product_details(1);

create or replace function FUN_get_product_details(iparam_product_id int)
returns table(
	iparam_product_name varchar,
	iparam_price numeric,
	iparam_quantity_in_stock varchar
)
as $$
BEGIN
	RETURN QUERY
	select product_name, price, quantity_in_stock 
	from product
	where product_id = iparam_product_id;
	
END;
$$ language plpgsql;

--select * from FUN_get_product_details(1);


---------------------------------------------------------------------------------------------------------------------------------------
-- 2)Stored Procedure for Customer Management
-- Create a stored procedure to insert customer information for the Customer Management screen.


create or replace procedure scrop_dml_insert_customer(
	In iparam_first_name varchar,
	IN iparam_last_name varchar,
	IN iparam_gender char,
	IN iparam_id_type varchar,
	IN iparam_id_number varchar,
	IN iparam_email varchar,
	IN iparam_phone_number varchar,
	IN iparam_address varchar,
	In iparam_city_id int
)
language plpgsql
AS $$

BEGIN
	--insert customer
	insert into customer(first_name, last_name, gender, id_type, id_number, email, phone_number, address, city_id)
	values(iparam_first_name, iparam_last_name, iparam_gender, iparam_id_type, iparam_id_number, iparam_email,
		iparam_phone_number, iparam_address, iparam_city_id);

END;
$$;

--call scrop_dml_insert_customer('DR','Kefaya','F','passport','Q34554','dr.kef@tansycloud.com','234545645', 'kompally', 1)

--select * from customer;
---------------------------------------------------------------------------------------------------------------------------------------
-- 3)Stored Procedure for Product Management
-- Create a stored procedure to update product information for the Product Management screen.
	
create or replace procedure scrop_dml_update_product(
	IN iparam_product_id int,
	IN iparam_product_price numeric(10,2)
)
language plpgsql
AS $$

BEGIN
	update product set price = iparam_product_price
	where product_id = iparam_product_id;

END;
$$;

--call scrop_dml_update_product(17,6.99);

--select * from product;
---------------------------------------------------------------------------------------------------------------------------------------
-- 4)Stored Procedure for Order Management
-- Write a stored procedure to create a new order. This procedure should insert data into 
-- the ORDER and ORDER_PRODUCT tables while updating the INVENTORY table to deduct the available stock accordingly.

-- drop procedure if exists scrop_insert_order_orderProduct_update_inventoryStock;

create or replace procedure scrop_insert_order_orderProduct_update_inventoryStock(
	IN iparam_order_date date,
	IN iparam_total_amount numeric,  -----iparam_units*iparam_unit_rate
	IN iparam_delivered_duration time,
	IN iparam_customer_id int,
	IN iparam_store_id int,
	IN iparam_order_status varchar, ---( Delivered,Paid,Shipping,Closed,Ready for Delivery,Accepted,Packing)
	-- IN iparam_order_id int,
	IN iparam_product_id int,	
	IN iparam_units	int,			---kitte units
	IN iparam_unit_rate numeric 	--- price of unit
)
language plpgsql
as $$
DECLARE last_order_id INT;
		available_stock int;
		updated_stock int;

BEGIN
	
	
	---- insert data into orders select * from orders
	insert into orders(order_date, total_amount, delivered_duration, customer_id, store_id, order_status)
	values
	(iparam_order_date, iparam_total_amount, iparam_delivered_duration,
	iparam_customer_id, iparam_store_id, iparam_order_status)
	returning order_id into last_order_id;

	---- Get the auto-increment order_id
    -- SET last_order_id = LAST_INSERT_ID();

	----insert data into order_product
	insert into order_product(order_id, product_id, units, unit_rate, total_amount)
	values
	(last_order_id, iparam_product_id,iparam_units, iparam_unit_rate, iparam_total_amount);
	----last_order_id ye likhee jab se error aara
	
	-----validate
	select quantity_in_stock::int into available_stock
	from INVENTORY
	where product_id = iparam_product_id;
	
	IF available_stock IS NULL THEN
	RAISE EXCEPTION 'Product ID % not found in inventory', iparam_product_id;
	ELSIF available_stock < iparam_units THEN
		RAISE EXCEPTION 'Not enough stock for product ID %. Available: %, Required: %'
		, iparam_product_id, available_stock, iparam_units;
	END IF;
	
	----updating the INVENTORY table to deduct the available stock accordingly.
	select  (quantity_in_stock::int - iparam_units)
	into updated_stock from INVENTORY
	where product_id = iparam_product_id;
	
	update INVENTORY set quantity_in_stock = updated_stock::varchar
	where product_id = iparam_product_id;

END;
$$;

----My problem is inserting without hard coding,
---- 1) How to insert new order_id in order_product which is already present in scrop? (solved)
---- Get the auto-increment order_id
    --SET last_order_id = LAST_order_id();
---- 2)insted of hard coding total_amount, it should automatic calculate (Units*price) ?????

CALL scrop_insert_order_orderproduct_update_inventorystock(
	'2025-03-02',	--<IN iparam_order_date date>,
	500,			--<IN iparam_total_amount  numeric>,
	'16:00:00',		--<IN iparam_delivered_duration  time without time zone>,
	1,				--<IN iparam_customer_id  integer>,
	1,				--<IN iparam_store_id  integer>,
	'Delivered',	--<IN iparam_order_status  character varying>,
	-- 5,				--<IN iparam_order_id  integer>,
	2,				--<IN iparam_product_id  integer>,
	5,				--<IN iparam_units  integer>,
	100				--<IN iparam_unit_rate  numeric>
);

-- select * from orders;
-- select * from order_product;
-- select * from inventory;

---------------------------------------------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------

--View Tasks:
-- 1) View for Store Details
--Create a view to display store details.

create view view_store_details as
	select store_name, location, b.city_name, b.country_name, a.phone_number, a.quantity_in_stock
	from store a
	inner join city b using(city_id);

--select * from view_store_details;

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


-- 3) View for Inventory Overview
--Write a view to display the available inventory at each store, showing product name, store name, and quantity in stock.
	
create view view_inventory_overview AS	
	select c.product_name, a.store_name, b.quantity_in_stock
	from  store a
	inner join inventory b ON a.store_id=b.store_id
	inner join product c ON b.product_id = c.product_id
	;

--select * from view_inventory_overview;


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



---------------------------------------------------------------------------------------------------------------------------------------
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


--------------------------------------------------------------------------------------------------------------------------------------
--Trigger Task:
--1) Trigger on Order Total Amount Change
--Create a trigger on the ORDER table that logs any changes made to the total_amount field into the AUDIT_LOG table.
--Ensure it captures the order_id, old_total, new_total, and log_date.
--select * from orders;

---cteate tbl
create table AUDIT_ORDER_LOG(
	log_id int GENERATED ALWAYS AS IDENTITY,
	order_id int,
	old_total numeric(10,2),
	new_total numeric(10,2),
	log_date date default current_timestamp
);

---function
create or replace function TRG_FUN_trg_update_total_amount()
returns trigger

as $$
BEGIN
	IF OLD.total_amount is distinct from new.total_amount then
		INSERT INTO AUDIT_ORDER_LOG(order_id, old_total, new_total)
		VALUES (OLD.order_id, OLD.total_amount, NEW.total_amount);
	END IF;
	RETURN NEW;	

END;
$$ language plpgsql;

----create trigger
create trigger trg_update_total_amount
AFTER update on orders
for each row 
WHEN(OLD.total_amount is distinct from new.total_amount)
EXECUTE FUNCTION TRG_FUN_trg_update_total_amount();

-----updating orders tbl
update orders set total_amount = 100
where order_id = 3;
--select * from AUDIT_ORDER_LOG;


--Submission Guidelines:
--Each SQL object (procedure, view, function, trigger) should be in a separate .sql file named after the object.
--Provide a report explaining the purpose of each SQL object and its relationship to the UI elements.


