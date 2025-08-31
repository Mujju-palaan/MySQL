--DQL ASSIGNMENT3 - Dashboard Reporting in a Store Management System

--1. Product Overview
--Task: Write SQL queries to generate the following metrics:
--a) Total Products in Stock: Write a query to count the total number of products currently available across all stores.
--select * from product;
--select * from store;
--select * from inventory;

select count(*) from product a
inner join inventory b using(product_id)
where b.quantity_in_stock > '0';

--b) Products by Category: Write a query to count the number of products for each category (for a bar or pie chart).
select count(product_name), category from product
group by category
order by count desc;

--c) Low Stock Products: Write a query to list products that have a stock quantity below a certain threshold (e.g., less than 10 units).
select a.product_name, b.quantity_in_stock from product a
inner join inventory b using(product_id)
where b.quantity_in_stock < '10';

--d) Recently Added Products: Write a query to list products added in the last 30 days.
--select * from product;
select product_id, product_name from product
where created_at in (SELECT CURRENT_DATE - INTERVAL '30 days')
;

--2. Customer Overview
--Task: Write SQL queries to pull customer-related insights:

--a) Total Number of Customers: Write a query to count the total number of customers in the system.
select * from customer;
select * from orders;
select count(*) from customer;

--b) Active Customers: Write a query to retrieve customers who have placed orders in the last 6 months.
select customer_id, first_name||' '||last_name as name, b.order_id from customer a
inner join orders b using(customer_id);

select count(*) as Active_Customers from customer a
inner join orders b using(customer_id);

--c) Customer Purchase History: Write a query that retrieves all orders made by each customer, 
--showing total amounts and order dates (for a table).
--select * from payment;
--select * from order_product;
--select * from payment

select customer_id, first_name||' '||last_name as name, b.order_id, c.total_amount, b.order_date, d.amount_paid from customer a
inner join orders b using(customer_id)
inner join order_product c using(order_id)
inner join payment d using(order_id)
; 

--d) Customer Registration: Write a query to list all customers who registered in the last month.
--select * from customer;
select customer_id, first_name||' '||last_name as name, created_at from customer
where created_at in (select current_date - interval '1 month')
;

--3. Order Overview
--Task: Use SQL to pull order-related insights:
--a) Total Orders by Month: Write a query that retrieves the number of orders placed each month.
select EXTRACT(MONTH FROM order_date) AS month, count(*) from orders
group by month
order by month;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(*) AS total_orders
FROM 
    orders
GROUP BY 
    EXTRACT(YEAR FROM order_date), 
    EXTRACT(MONTH FROM order_date)
ORDER BY 
    year, month;
--b) High-Value Orders: Write a query that lists all orders above a certain total amount (e.g., greater than 500 USD).
select order_id, order_date, total_amount from orders
where total_amount > 500;

select order_id, order_date, c.product_name, b.units, b.unit_rate, b.total_amount from orders a
inner join order_product b using(order_id)
inner join product c using(product_id)
where b.total_amount > 500;

--c) Orders by Product: Write a query that retrieves the total quantity ordered for each product (for a bar chart).
select product_name, sum(b.units) as total_quantity from product a
inner join order_product b using(product_id)
group by product_name
order by total_quantity desc;

--d) Pending Orders: Write a query that lists all orders that have not been fulfilled yet.
select * from orders
where order_status in ('Pending','Packing');

--4. Employee Overview
--Task: Write SQL queries to manage employee-related data:
--a) Number of Employees per Store: Write a query to retrieve the number of employees working at each store.
select employee_id, first_name||' '||last_name as name, b.store_name, b.store_id from employee a
inner join store b using(store_id);

--b) Employee Salary Report: Write a query to retrieve the salary details for all employees.
select first_name||' '||last_name as Employee, salary from employee;

--5. Inventory Overview
--Task: Write SQL queries to pull inventory data across stores:
--1) Inventory by Store: Write a query that retrieves the total quantity of products available at each store.
select a.store_id, a.store_name, b.quantity_in_stock from store a
inner join Inventory b using(store_id)
order by store_id;

--2) Out-of-Stock Products: Write a query to list products that are out of stock at any store.
--select * from inventory; , select * from store;, select * from product;
select e.store_name, a.quantity_in_stock, product_id 
from inventory a 
inner join product b using(product_id)
-- inner join order_product c using(product_id)
-- inner join orders d using(order_id)
inner join store e ON a.store_id=e.store_id
where a.quantity_in_stock <= '150';

--3) Inventory by Supplier: Write a query that lists the quantity of products supplied by each supplier to all stores.
select b.supplier_name,f.store_name ,c.product_name, a.quantity_in_stock 
from inventory a
inner join supplier_product bb using(product_id)
inner join supplier b ON bb.supplier_id=b.supplier_id
inner join product c ON bb.product_id=c.product_id
inner join order_product d ON c.product_id=d.product_id
inner join orders e using(order_id)
inner join store f ON e.store_id=f.store_id;

--------------------------------------Key Visuals and Corresponding SQL Queries:------------------------------------
--Note: All dashboard queries must work against current month or current year filters

--Pie Chart - Products by Category
--Query: Write an SQL query to retrieve the number of products for each category from the `PRODUCT` table.
--Sections: Product categories with the number of products as values.
--select * from product
select category, count(*) as Number_of_products from product
group by category
order by Number_of_products desc;

--Bar Chart - Orders by Month
--Query: Write a query that retrieves the number of orders placed in each month from the `ORDER` table, grouped by order date (by month).
--X-Axis: Order date (by month).
--Y-Axis: Number of orders.
select EXTRACT(year FROM order_date) as Year,EXTRACT(MONTH FROM order_date) as Month, count(order_date) from orders
group by order_date
order by month;

-- select * from orders;
--Multi Line Graph - Sales vs Collection Over Month

--Query: Write a query to compare total sales amounts (from the `ORDER` table) and collections (from the `PAYMENT` table) for each month.
--X-Axis: Month (grouped by order_date and payment_date).
--Y-Axis: Total sales and collection amounts. Two lines in the graph, one for sales and other for collections.
--Details: Sales data comes from the `total_amount` field in the `ORDER` table, 
--while collection data comes from the `amount_paid` field in the `PAYMENT` table.
select extract(month from a.order_date) as order_month ,extract(month from b.payment_date) as payment_month, 
sum(total_amount) as order_total, sum(b.amount_paid) as payment_total from orders a 
inner join payment b using(order_id)
group by (order_date,payment_date)
order by order_month, payment_month;

--Table - Customer Purchase History
--Query: Write an SQL query to retrieve order details from the `ORDER` and `CUSTOMER` tables,
--showing customer names, order dates, and total amounts.
--Columns: Customer Name, Order Date, Total Amount.
select first_name||' '||last_name as customer_name, b.order_date, b.total_amount from customer a
inner join orders b using(customer_id);


--Gauge - Total Store Inventory
--Query: Write an SQL query to calculate the total quantity of products in stock across all stores from the `INVENTORY` table.
--Display: Total quantity of products available.
select store_name, sum(b.quantity_in_stock::int) as stock 
from store a
inner join inventory b using(store_id)
group by store_name
order by stock desc;

--GOOD LUCK WITH YOUR ASSIGNMENT!!!

