-- Chapter 10 - Projects
-- Final Capstone Project 1: Store Management System in Postgres SQL Server

-- Assignment Tasks:
-- Stored Procedure Tasks:
---------------------------------------------------------------------------------------------------------------------------------------
-- 1)Stored Procedure for Product Management Data Grid
-- Write a stored procedure to retrieve all product details for the Product Management screen,
-- including product_name, price, and quantity_in_stock.


---------------------------------------------------------------------------------------------------------------------------------------
-- 2)Stored Procedure for Customer Management
-- Create a stored procedure to insert customer information for the Customer Management screen.


---------------------------------------------------------------------------------------------------------------------------------------
-- 3)Stored Procedure for Product Management
-- Create a stored procedure to update product information for the Product Management screen.
	

---------------------------------------------------------------------------------------------------------------------------------------
-- 4)Stored Procedure for Order Management
-- Write a stored procedure to create a new order. This procedure should insert data into 
-- the ORDER and ORDER_PRODUCT tables while updating the INVENTORY table to deduct the available stock accordingly.

-- drop procedure if exists scrop_insert_order_orderProduct_update_inventoryStock;


-- select * from orders;
-- select * from order_product;
-- select * from inventory;

---------------------------------------------------------------------------------------------------------------------------------------
-- 5)Stored Procedure for Payment Insertion
-- Write a stored procedure to insert new payment information for an order in the Payment Management screen. 
-- Also update order status as piad in order table.

-- select * from payment;
-- select * from orders;

---------------------------------------------------------------------------------------------------------------------------------------
-- 6)Stored Procedure for Customer Analysis

-- Develop a stored procedure to analyze customer revenue. This procedure should generate a report 
-- displaying the month name, customer name, the number of orders for each specified month, 
-- and the total revenue for that month. The output must include all months of the current year, 
-- even if no orders were placed in certain months. Use the dim dimension table as the primary data source 
-- and apply left joins with related tables to retrieve the necessary details. Incorporate the temporary table 
-- technique within the stored procedure for efficient data processing.
-- select * from orders;


-----------------------------------------------------------------------------------------------------------------------
-- 7) Stored Procedure for Analyzing Sales by Store
-- Create a stored procedure to analyze store sales performance. The procedure should display the 
-- store name, location, total sales, the number of transactions, and the average transaction value for a given date range. 
-- It should also include comparisons to the previous period's sales and highlight stores with significant performance changes. 
-- Use a temporary table to store intermediate calculations for efficient data processing and join data from relevant 
-- tables such as stores, sales, and transactions.

-- total sales, 
-- the number of transactions,
-- the average transaction value for a given date range.


---------------------------------------------------------------------------------------------------------------------------------

-- View Tasks:
-- 1) View for Store Details
-- Create a view to display store details.

create view view_store_details as
	select store_name, location, b.city_name, b.country_name, a.phone_number, a.quantity_in_stock
	from store a
	inner join city b using(city_id);

-- select * from view_store_details;

-- 2) View for Order Details
-- Design a view to display order details, including the customer name, order date, and total amount,
-- for the Order Overview screen. Additionally, include a column that lists all purchased products in a single column,
-- separated by commas (e.g., Milk, Soda, Lays).
-- select * from order_product;
-- select * from product;
-- select * from orders;

-- drop view view_order_details
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
-- select * from view_order_details;


-- 3) View for Inventory Overview
-- Write a view to display the available inventory at each store, showing product name, store name, and quantity in stock.
	
create view view_inventory_overview AS	
	select c.product_name, a.store_name, b.quantity_in_stock
	from  store a
	inner join inventory b ON a.store_id=b.store_id
	inner join product c ON b.product_id = c.product_id
	;

-- select * from view_inventory_overview;


-- 4) View for Weekend Sales
-- Create a view to showcase weekend sales analysis, highlighting the top ten products sold during the 
-- weekend along with details such as revenue, location, product name, and product category.

create or replace view view_weekend_sales AS
	select a.store_name,
	a.location,
	b.product_name,
	b.category,
	sum(units * unit_rate) as revenue,
	RANK() OVER (order by sum(units * unit_rate)) as rankk,
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


-- select * from view_weekend_sales;

-- select extract(week from cast(order_date as date)) from orders;

-- select order_date,EXTRACT(DOW FROM order_date) in (0,6) from orders;  ---day of week (sun,mon,tue -----..nth day)



---------------------------------------------------------------------------------------------------------------------------------------
-- Function Tasks:
-- 1) Function to Calculate Total Orders for Customer
-- Write a function that calculates the total number of orders placed by a specific customer.



-- 2) Function to Get Available Discounts
-- Write a function that retrieves active discount codes based on current date.
-- select * from Discount


--------------------------------------------------------------------------------------------------------------------------------------
-- Trigger Task:
-- 1) Trigger on Order Total Amount Change
-- Create a trigger on the ORDER table that logs any changes made to the total_amount field into the AUDIT_LOG table.
-- Ensure it captures the order_id, old_total, new_total, and log_date.
-- select * from orders;


