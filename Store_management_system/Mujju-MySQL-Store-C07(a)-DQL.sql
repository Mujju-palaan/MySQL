-- --Store Chapter 7 - DQL (Data Query Language)
-- --⁠ ⁠Mujju-postgres-Store-Chapter07-DQL
-- --DQL ASSIGNMENT1 - Store Management System

-- --1. SELECT Command

-- --a) Select all columns from the PRODUCT table.
select * from product;

-- --b) Select the product_name, price, and SKU from the PRODUCT table.
select product_name, price, sku from product;

-- --c) Select the first_name, last_name, and email from the CUSTOMER table.
select first_name, last_name, email from customer;

-- --d) Select the order_date and total_amount from the ORDER table.
select order_date, total_amount from orders;

-- --2. WHERE Command
-- --a) Select all customers where registration_date is after '2020-01-01'.
select * from customer where created_at = '2020-01-01';

-- --b) Select all products where price is greater than 3.
select * from product where price > 3;

-- --c) Select all orders where the total_amount is greater than 100.
select * from orders where total_amount > 100;

-- --d) Select all products where quantity_in_stock is less than 10.
select * from product where product_id < 10;


-- --3. ORDER BY Command
-- --a) Select all products and order them by product_name in ascending order.
select * from product order by product_name ASC;

-- --b) Select all customers and order them by last_name in descending order.
select * from customer order by last_name DESC;

-- --c) Select all orders and order them by order_date in ascending order.
select * from orders order by order_date ASC;

-- --d) Select all employees and order them by hire_date in descending order.
select * from employee order by hire_date desc;


-- --4. TOP Command
-- --a) Select the top 5 customers from the CUSTOMER table based on registration_date.
select * from customer order by created_at limit 5; 

-- --b) Select the top 10 products from the PRODUCT table ordered by price.
select * from product order by price desc limit 10;

-- --c) Select the top 3 orders from the ORDER table ordered by total_amount.
select * from orders order by total_amount desc limit 3;

-- --d) Select the top 5 employees from the EMPLOYEE table based on salary.
select * from employee order by salary limit 5;

-- --5. DISTINCT Command
-- --a) Select distinct category from the PRODUCT table.
select distinct category from product;

-- --b) Select distinct last_name from the CUSTOMER table.
select distinct last_name from CUSTOMER;

-- --c) Select distinct supplier_name from the SUPPLIER table.
select distinct supplier_name from supplier;

-- --d) Select distinct store_name from the STORE table.
select distinct store_name from store;

-- --6. GROUP BY Command
-- --a) Group by category from the PRODUCT table and count the number of products per category.
-- select * from product;

select count(product_id), category from product
group by category;

-- --b) Group by last_name from the CUSTOMER table and count the number of customers with the same last name.
-- select * from CUSTOMER;

select 
	count(*) 
	,last_name 
from customer
group by last_name
order by count(*) desc;

-- --c) Group by store_id from the STORE table and calculate the total quantity_in_stock of each store.
-- -- select * from STORE;
insert into store (store_name, location, phone_number, city_id)
values('Concu','Begumpet','78678378666a',2)
;

select store_id, sum(quantity_in_stock) as total_stock 
from store
inner join inventory using(store_id)
group by store_id
order by total_stock desc
;


-- --d) Group by product_id from the ORDER_PRODUCT table and sum the total units per product.
-- --select * from ORDER_PRODUCT
insert into ORDER_PRODUCT(order_id,product_id,units,unit_rate,total_amount)
values(2,1,4,100.00,400.00);

select product_id, sum(units) as total_units  
from ORDER_PRODUCT
group by product_id
order by total_units desc
;

-- --7. HAVING Command
-- --a) Group by category from the PRODUCT table and filter the results where the count of products is greater than 5.
-- --select * from product;

select category, count(*) as product_count 
from product
group by category
having count(*) > 5
;

-- --b) Group by last_name from the CUSTOMER table and having more than 3 customers with the same last name.
-- --select * from CUSTOMER;

select last_name, count(last_name) 
from CUSTOMER
group by last_name
having count(last_name) > 1
;

select last_name, count(last_name) 
from CUSTOMER
group by last_name
having count(last_name) > 3
;

-- --c) Group by store_id from the INVENTORY table, having a total quantity_in_stock greater than 50.
-- --select * from INVENTORY;

select 
	store_id, 
	sum(quantity_in_stock) as total_stock 
from INVENTORY
group by store_id
having sum(quantity_in_stock) > 50
order by total_stock desc
;

-- --d) Group by employee_id from the EMPLOYEE table and having a total salary greater than 50000.
-- --select * from EMPLOYEE;

select 
	employee_id, 
    sum(salary) as total_salary 
from EMPLOYEE
group by employee_id
having sum(salary) > 50000
order by total_salary desc
;

-- --8. INNER JOIN Command
-- --a) Select all orders along with customer details using INNER JOIN between the ORDER and CUSTOMER tables.
-- --select * from orders;
-- --select * from CUSTOMER;

select 
	a.order_id
    ,a.order_date
    ,a.total_amount
    ,a.order_id
    ,concat(b.first_name, ' ', b.last_name) as name 
from orders a
inner join customer b ON a.customer_id=b.customer_id
;

-- --b) Select all products and their corresponding suppliers using INNER JOIN between PRODUCT and SUPPLIER.
-- --select * from supplier_product;

select 
	a.product_id
    ,a.product_name
    ,a.category
    ,a.price
    ,c.supplier_name
    ,c.supplier_id 
from product a
inner join supplier_product b ON a.product_id=b.product_id
inner join supplier c ON b.supplier_id=c.supplier_id
;

-- --c) Select all payments and the corresponding order details using INNER JOIN between PAYMENT and ORDER.
-- --select * from orders;
-- --select * from payment

select 
	a.payment_id
	,a.amount_paid
    ,b.total_amount
    ,b.customer_id
    ,b.store_id
    ,b.order_status 
    from payment a
inner join orders b ON a.order_id = b.order_id
;

-- --d) Select all inventory records and their corresponding store details using INNER JOIN between INVENTORY and STORE.
-- --select * from store;

select 
	a.inventory_id
	,a.product_id
    ,a.quantity_in_stock
    ,a.supplier_id
    ,a.store_id
    ,b.store_name
    ,b.location
    ,b.city_id 
from inventory a
inner join store b ON a.store_id = b.store_id
;

-- --9. LEFT JOIN Command
-- --a) Select all customers and their orders using LEFT JOIN, including customers without orders.
-- --select * from orders
select 
	concat(a.first_name, ' ', a.last_name) as name
    ,a.gender
    ,a.id_type
    ,a.id_number
    ,a.email
    ,a.address
    ,a.city_id
    ,b.order_id 
from customer a
left join orders b On a.customer_id = b.customer_id
;

-- --b) Select all products and their suppliers using LEFT JOIN, including products without suppliers.
select 
	a.product_id
    ,a.product_name
    ,a.category
    ,a.price
    ,c.supplier_id
    ,c.supplier_name 
from product a
left join supplier_product b ON a.product_id=b.product_id
left join supplier c ON b.supplier_id=c.supplier_id
order by price desc
;

-- --c) Select all employees and the stores they work at using LEFT JOIN, including employees without a store assignment.
-- --select * from store
select 
	a.employee_id
    ,concat(a.first_name, ' ', a.last_name) as name
    ,a.salary
    ,b.store_name
    ,b.location 
from employee a
left join store b ON a.store_id = b.store_id
;

-- --d) Select all stores and their inventory using LEFT JOIN, including stores with no inventory.
select * 
from store a
left join inventory b ON a.store_id = b.store_id
;

-- --10. COUNT, SUM, AVG Command
-- --a) Count the total number of customers in the CUSTOMER table.
select count(*) from customer;

-- --b) Count the number of distinct products in the PRODUCT table.
-- --select * from product;
select distinct category from product;

select count(distinct category) from product;

-- --c) Calculate the sum of total_amount from the ORDER table.
-- --select * from orders;
select sum(total_amount) from orders;

-- --d) Calculate the average salary of employees in the EMPLOYEE table.
select avg(salary) from employee;

-- --11. CASE Command
-- --a) Select all products and use a CASE statement to show 'In Stock' if quantity_in_stock is greater than 0, otherwise 'Out of Stock'.

SELECT product_id,
    	product_name,
    	quantity_in_stock,
    	CASE 
        	WHEN quantity_in_stock > '0' THEN 'In Stock'
        	ELSE 'Out of Stock'
    	END AS stock_status
FROM PRODUCT
inner join inventory using(product_id)
;

-- --b) Select all orders and use a CASE statement to show 'High Value' if total_amount is greater than 500, otherwise 'Standard'.
-- --select * from orders;
select 
	order_id
    ,total_amount
    ,order_status
    ,CASE
		when total_amount > '500' then 'High Value'
		ELSE 'Standard'
	end as rangee
from orders
;

-- 		
-- --c) Use a CASE statement to categorize products by price: 'Expensive' if price is greater than 100, 
-- --'Affordable' if price is between 50 and 100, otherwise 'Cheap'.
-- --select * from product;
select 
	product_name
    ,category
    ,price
    ,case
		when price > '100' then 'Expensive'
		when price between '50' and '100' then 'Affordable'
		else 'Cheap'
	end as rangee
from product
;

-- --d) Use a CASE statement in the ORDER_PRODUCT table to label products as 'Low Quantity' 
-- --if quantity_ordered is less than 5, otherwise 'High Quantity'.
-- --select * from ORDER_PRODUCT;
select order_id
	,product_id
    ,units
    ,case
		when units < 5 then 'Low Quantity' 
		else 'High Quantity'
	end as label
from ORDER_PRODUCT
;

-- --12. EXISTS and NOT EXISTS Command
-- --a) Select all customers where an order exists in the ORDER table using EXISTS.
 select  
	concat(first_name, ' ', last_name) as name
    ,email
    ,phone_number 
from customer a
 where exists (
	select * from orders b
	where a.customer_id=b.customer_id
 ) ;

-- --b) Select all customers where no order exists in the ORDER table using NOT EXISTS.
select * from customer a
	where not exists(
		select * from orders b
		where a.customer_id=b.customer_id
	);

-- --c) Select all products where a supplier exists in the SUPPLIER table using EXISTS.
select * from product a
	where exists(
		select * from supplier_product b
		where a.product_id = b.product_id
	);

-- --d) Select all employees where no payments were processed using NOT EXISTS.
select * from orders a
	where not exists(
		select * from payment b
		where a.order_id = b.order_id
	);

-- --13. SUBQUERY Command
-- --a)Select all products whose product_id is in the result of a subquery selecting product_id from the ORDER_PRODUCT table.
-- --select * from ORDER_PRODUCT;
select * from product 
where product_id in (
		select product_id from order_product
		where unit_rate = 50.00
);

-- --b)Select all customers where the customer_id is in the result of a 
-- --subquery selecting customer_id from the ORDER table where total_amount is greater than 1000.
select * from customer
where customer_id in (
	select customer_id from orders
	where total_amount > 500
);

-- --c)Select all stores where the store_id is in the result of a 
-- --subquery selecting store_id from the INVENTORY table where quantity_in_stock is greater than 50.
select * from store
where store_id in (
	select store_id from INVENTORY
	where quantity_in_stock > 50
);

-- --d)Select all orders where the order_id is in the result of a 
-- --subquery selecting order_id from the PAYMENT table where amount_paid is greater than 500.
select * from orders
where order_id in(
	select order_id from payment
	where amount_paid > 500
);

-- --14. RANK and DENSE_RANK Command
-- --a) Rank customers based on the total number of orders using RANK().
select 
	order_id,
	total_amount,
	rank() over (partition by customer_id order by total_amount desc) as rankk
from orders
;

-- --b) Use DENSE_RANK() to rank products based on their price.
select product_name,
		category,
		price,
		dense_rank() over(partition by price order by price desc) as rankk
from product
;

-- --c) Rank employees based on their salary using RANK().
select 
	concat(first_name, ' ', last_name) as name, 
		email,
		salary,
		RANK() over (partition by salary order by salary desc)
from employee
;

-- --d) Use DENSE_RANK() to rank stores based on their total quantity_in_stock.
-- select 
-- 	store_name, 
-- 	location,
-- 	DENSE_RANK() over (partition by quantity_in_stock)
-- from store
-- ;

-- --15. PIVOT and UNPIVOT
-- --CREATE EXTENSION tablefunc;
-- --a) Pivot the ORDER_PRODUCT data by order_id and product_id.

-- --b) Unpivot the sales data to show the product_name, category, and price for each product.

-- --c) Pivot the customer data by registration_date and first_name.

-- --d) Unpivot store inventory data by store_name and quantity_in_stock.

-- --16. UNION and UNION ALL Command
-- --a)Select all products from the PRODUCT and INVENTORY tables using UNION.
alter table INVENTORY modify column quantity_in_stock  varchar(50);

-- select quantity_in_stock from product
-- union 
-- select quantity_in_stock from INVENTORY
-- ;

-- --b) Select all customers from different regions using UNION ALL.
select city_name from city where country_name='USA'
union all
select city_name from city where country_name='India'
;

-- --c) Use UNION to combine high-value and standard orders.
SELECT order_id, customer_id, order_date, total_amount, 'High-Value' AS order_type
FROM ORDERS
WHERE total_amount > 1000 
UNION
SELECT order_id, customer_id, order_date, total_amount, 'standard' AS order_type
FROM ORDERS
WHERE total_amount <= 1000
;  

-- --d) Use UNION ALL to select all products from two different categories.
select product_name,category from product
where category = 'drinks'
UNION ALL
	select product_name,category from product
	where category = 'snacks'
UNION ALL
	select product_name,category from product
	where category = 'fruits'
;

-- --17. COALESCE, ISNULL, NULLIF Command
-- a)Select all products and use COALESCE to replace null category values with 'Uncategorized'.
select COALESCE(category,'Uncategorized') as category
from product
;

-- --b) Use ISNULL to replace null email values in the CUSTOMER table with 'No Email Provided'.
UPDATE CUSTOMER
SET email = 'No Email Provided'
WHERE email IS NULL
;

-- --c) Use NULLIF to compare price and discount in the PRODUCT table and return NULL if they are the same.

-- --d) Select all employees and use COALESCE to replace null phone_number values with 'No Phone'.
select COALESCE(phone_number, 'No Phone')
from employee
;


-- --18. STRING Functions
-- --a) Select all products' product_name in uppercase using the UPPER() function.
select upper(product_name) from product;

-- --b) Select all customers' first_name in lowercase using the LOWER() function.
select lower(first_name) from customer;

-- --c) Use CONCAT() to combine the first_name and last_name of customers.
select concat(first_name, ' ', last_name) as name from customer;

-- --d) Select all products' product_name and find the length of the string using LEN().
select product_name, length(product_name) as name_length
from product
;

-- --19. DATE Functions
-- --a) Select all customers and show their registration_date formatted as 'YYYY-MM-DD' using FORMAT().
-- --select * from CUSTOMER;
SELECT 
    customer_id, 
    CONCAT(first_name, ' ', last_name) AS name, 
    DATE_FORMAT(created_at, '%Y-%m-%d') AS registration_date
FROM customer
;

-- 	
-- --b) Add 1 year to all hire_date values in the EMPLOYEE table using DATEADD().
select
	date_add(hire_date, INTERVAL 1 year) AS new_hire_date 
    from employee
;

-- --c) Subtract 1 month from all order_date values using DATEADD().
select 
	order_id
    ,date_sub(order_date, interval 1 month) as new_date
    from orders
;

-- --d) Select all orders and extract the year from the order_date using YEAR().
select year(order_date) as order_year from orders;

-- --20. NUMERIC Functions
-- --a) Select the total_amount from the ORDER table and round it to the nearest integer using ROUND().
  select round(total_amount) from orders;
--   
-- --b) Select all employees' salary and use CEILING() to round up their salary values.
select 
	salary
    ,CEILING(salary) 
from employee
;

-- --c) Use FLOOR() to round down the prices in the PRODUCT table.
select FLOOR(price) from product;

-- --d) Select the maximum total_amount from the ORDER table using MAX().
select max(total_amount) from orders;

-- --21. CAST and CONVERT Command
-- --a) Select all products and cast the product_id as a string using CAST().
select cast(product_id as char) from product;

-- --b) Convert the order_date in the ORDER table to VARCHAR using CONVERT().
select cast(order_date as char) from orders;

-- --c) Cast the price in the PRODUCT table to INT.
select price, cast(price as UNSIGNED) from product;

-- --d) Convert the payment_date from the PAYMENT table to DATETIME.
select payment_date, cast(payment_date as date) from payment;

-- --22. JSON Select
-- --a) Select all JSON data from a column in the INVENTORY table if it stores any JSON details.
select 
	meta_data 
from product 
where cast(meta_data as json) is not null
;

-- --b) Select specific keys from a JSON column in the AUDIT_LOG table.
-- SELECT 
--     meta_data->>'brand' AS Brand
-- FROM product where meta_data is not null;

-- --c) Parse a JSON column from the ORDER table to extract product details.
-- --select * from product;
-- select product_name,
-- 		meta_data->>'brand' as BRAND,
-- 		meta_data->>'warranty_period' as Warranty,
-- 		meta_data->>'manufacture_date' as Manufacture
-- 		from product
-- 		where meta_data is not null;

-- --d) Use JSON_VALUE() to select a specific key from a JSON column in the PRODUCT table.
-- select JSON_VALUE(meta_data, '$.brand') as BRAND from product
-- where meta_data is not null;

-- --23. CONCAT and CONCAT_WS Functions
-- --a) Use CONCAT() to join first_name and last_name with a space in between in the CUSTOMER table.
select concat(first_name,' ',last_name) as name from customer;

-- --b) Use CONCAT_WS() to combine the store_name and location with a comma in the STORE table.
select concat_ws(', ',store_name,location) from store;

-- --c) Use CONCAT() to combine the product_name and category from the PRODUCT table.
select concat(product_name, ' ', category) from PRODUCT;

-- --d) Use CONCAT_WS() to combine first_name, last_name, and email from the EMPLOYEE table.
select CONCAT_WS(', ',first_name, last_name, email) from EMPLOYEE;

-- --24. LIKE and NOT LIKE
-- --a) Select products where the product_name contains 'Laptop' using LIKE.
select product_name LIKE 'Laptop' from product;

select * from product where product_name LIKE 'Pepsi';

-- --b) Select customers where email ends with 'gmail.com' using LIKE.
select * from customer where email LIKE '%gamil.com';

select * from customer where email LIKE '%example.com';

-- --c) Select products where category does not start with 'E' using NOT LIKE.
select * from product where category NOT LIKE 'E%';

-- --d) Select stores where store_name contains 'Main' using LIKE.
select * from store where store_name LIKE 'Concu';

-- --25. EXISTS and NOT EXISTS
-- --a) Select all products where orders exist in the ORDER_PRODUCT table using EXISTS.
select * from product a
	where exists(
		select * from ORDER_PRODUCT b
		where a.product_id = b.product_id
	);
-- 	
-- --b) Select all customers where no orders exist using NOT EXISTS.
select * from customer a
	where not exists(
		select * from orders b 
		where a.customer_id = b.customer_id
	);
-- 	
-- --c) Select all stores where inventory exists in the INVENTORY table using EXISTS.
select * from store a
	where exists(
		select * from inventory b
		where a.store_id = b.store_id
	);

-- --d) Select all suppliers where no products exist using NOT EXISTS.
select * from supplier a
	where not exists(
		select * from supplier_product a
			inner join product b using(product_id)
			where a.product_id = b.product_id
	);

-- --26. JOIN Commands
-- --a) Select all customers and their corresponding orders using INNER JOIN between CUSTOMER and ORDER.
select 
	concat(first_name,' ',last_name) as name
    ,order_status from customer a
	inner join orders b 
	ON a.customer_id = b.customer_id
;
-- 	
-- --b) Select all products and their corresponding suppliers using INNER JOIN between PRODUCT and SUPPLIER.
select 
	a.product_name
	,a.category
    ,a.price
    ,c.supplier_name 
    from product a
	inner join supplier_product b ON a.product_id = b.product_id
	inner join supplier c ON b.supplier_id = c.supplier_id
;
    
-- 	
-- --c) Select all employees and the stores they work at using LEFT JOIN between EMPLOYEE and STORE.
select 
	concat(first_name, ' ', last_name) as name
    , salary
    , store_name
    , location 
from employee a
left join store b ON a.store_id = b.store_id
;
-- 	
-- --d) Select all orders and their corresponding payments using INNER JOIN between ORDER and PAYMENT.
select 
	a.order_id
    , a.total_amount
    , a.order_status
    , b.amount_paid 
from orders a
inner join payment b ON a.order_id=b.order_id
;

-- --27. BETWEEN Command
-- --a) Select all products where the price is between 50 and 100.
select * from product
	where price between  50 and 100
;
-- 	
-- --b) Select all orders where the total_amount is between 500 and 1000.
select * from orders
	where total_amount between 500 and 1000
;
-- 	
-- --c) Select all employees where the hire_date is between '2015-01-01' and '2020-01-01'.
select * from employee
	where hire_date between '2015-01-01' and '2020-01-01'
;

-- --d) Select all payments where the amount_paid is between 100 and 500.
select * from payment
	where amount_paid between 100 and 500
;


-- --28. IN and NOT IN Command
-- --a) Select all products where the category is in ('Electronics', 'Furniture', 'Clothing').
select * from product
	where category in ('Electronics', 'Furniture', 'Clothing')
;
-- 	
-- --b) Select all customers where the customer_id is in (101, 202, 303).
select * from customer
	where customer_id in (101, 202, 303)
;

-- --c) Select all orders where the order_id is not in (1, 2, 3).
select * from orders
	where order_id not in (1, 2, 3)
;
-- 	
-- --d) Select all stores where the location is in ('Downtown', 'Suburb', 'Mall').
select * from store 
	where location in ('Downtown', 'Suburb', 'Mall')
;


-- --29. UNION Command
-- --a) Select products from the PRODUCT and INVENTORY tables using UNION.
select product_id from product
union all
select product_id from inventory
order by product_id
;

-- --b) Select customers from different regions using UNION ALL.
-- --select * from customer
select city_id from customer a
union all 
select city_id from city
union all
select city_id from customer
where city_id is not null
;

-- --c) Use UNION to combine orders from two different years.

SELECT '2023' AS order_year
FROM ORDERS
WHERE 
    year(order_date) = 2023
UNION 
SELECT '2024' AS order_year
FROM ORDERS
WHERE 
    year(order_date) = 2024
;
-- 	
-- --d) Use UNION ALL to select all suppliers from two different locations.
select 'Hyderabad' as location from supplier
union all
select 'Delhi' as location from supplier
;

-- --30. ARRAY Command
-- --a) Select all category and convert it into an array using STRING_AGG().
-- SELECT 
--     STRING_AGG(distinct category, ', ') AS category_array
-- FROM product
-- ;
-- 	
-- --b) Use UNSTRING() to expand arrays from the PRODUCT table.


-- --c) Convert product names into an array using STRING_AGG() in the ORDER_PRODUCT table.
-- select 
-- 	STRING_AGG(distinct product_name, ', ') AS pproduct_array
-- 	from product;
-- 	
-- --d) Use ARRAY functions to select and manipulate data from the STORE table.
-- SELECT store_name[1] as store_name
-- FROM (select '{concu,mujju}'::text[] as store_name);

-- SELECT c1[3] FROM (SELECT '{32,50,28}'::text[] as c1);


-- --GOOD LUCK WITH YOUR ASSIGNMENT!!!
