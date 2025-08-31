--Store DML(Data Manipulation Language) ASSIGNMENT
--⁠ ⁠Mujju-postgres-Store-Chapter06-dml


--Question 2: Insert a New Product
--Write a DML SQL statement to insert a new product into the PRODUCT table with the following details:

--select * from product;
insert into product(product_name, category, price, description,sku)
values ('Saudi Laban','drinks',5.49,'arab drink','DRINK-LABAN-SAUDI-001');

--Question 3: Insert Multiple Customers
--Insert two new customers into the CUSTOMER table with the following details:
--First customer: first_name: 'Alice', last_name: 'Johnson', email: 'alice.johnson@example.com', phone_number: '1234567890'
--Second customer: first_name: 'Bob', last_name: 'Smith', email: 'bob.smith@example.com', phone_number: '0987654321'
--select * from customer;
insert into customer(first_name, last_name, gender, id_type, id_number, email, phone_number, address, city_id)
values('Alice','Johnson','F','passport','W0607748','alice.johnson@example.com','12345678909','74th street NYC',1),
		('Bob','Smith','M','passport','W0227748','bob.smith@example.com','0987654321','Sharjah media city',2)
;
--Question 4: Insert an Order
--Write a DML SQL statement to insert a new order into the ORDER table:
--order_date: Current date,total_amount: 1499.99,customer_id: 1
--select * from orders;
insert into orders (total_amount, delivered_duration, customer_id, store_id, order_status)
values(1499.99, '04:04:04', 1,2,'Packing');


--Question 5: Update Product Information
--Write a SQL statement to update the price and description for the product with product_id = 1.
--select * from product;
update product set price=5.00, description='Harmful to health' where product_id = 1;

--Question 6: Delete a Customer
--Write a SQL statement to delete a customer where customer_id = 2.
--select * from customer;
delete from customer where customer_id = 2 ;

--Question 7: Insert Data Using Subquery
--Write a SQL statement to insert a new order into the ORDER_PRODUCT table using a subquery 
--to get the order_id and product_id for an order placed by the customer whose email = 'alice.johnson@example.com'.
-- select * from ORDER_PRODUCT;
-- select * from customer;
-- select * from orders;

INSERT INTO ORDER_PRODUCT (order_id, product_id, units, unit_rate, total_amount)
SELECT a.order_id, 11, 4, 45.00, 180.00
FROM orders a
INNER JOIN customer b ON a.customer_id = b.customer_id
WHERE b.email = 'alice.johnson@example.com';

--Question 8: Insert into SUPPLIER Table
--Write a SQL statement to insert a new supplier into the SUPPLIER table:
--supplier_name: 'Tech Supplies Inc.',contact_number: '5551234567',product_id: 1
--select * from SUPPLIER;
insert into SUPPLIER(supplier_name, contact_number)
values('Tech Supplies Inc.','78678378666')
;

--Question 9: Update an Order's Total Amount
--Write a SQL statement to update the total_amount in the ORDER table where order_id = 1, setting it to 1599.99.
--select * from orders;
update orders set total_amount = 1599.99 where order_id = 1;

--Question 10: Delete with JOIN
--Write a SQL statement to delete all orders that include the product with product_name = 'Popcorn' 
--using a JOIN between the PRODUCT and ORDER_PRODUCT tables.
-- select * from PRODUCT
-- select * from ORDER_PRODUCT

delete from PRODUCT 
where product_name in 
(select product_name from product a
inner join ORDER_PRODUCT b ON a.product_id=b.product_id
where product_name = 'Popcorn' );

--Question 11: Insert a New Store
--Write a SQL statement to insert a new store into the STORE table:
--store_name: 'Downtown Electronics',location: 'Main Street',phone_number: '5559876543'
-- select * from store;
insert into store(store_name, location, phone_number, city_id)
values ('Downtown Electronics','Main Street','5559876543',1);

--Question 12: Insert a Payment
--Write a SQL statement to insert a new payment into the PAYMENT table for an order:
--payment_date: Current date,amount_paid: 1599.99,order_id: 1
-- select * from payment;
insert into payment(amount_paid, order_id)
values (1599.99, 1);

--Question 13: Update with Subquery
--Write a SQL statement to update the total_amount of all orders where the customer has the last name 'Johnson'. 
--Use a subquery to find the customer_id.
-- select * from customer;
-- select * from orders;

update orders set total_amount = 999.99 where customer_id in
(select a.customer_id from orders a
inner join customer b ON a.customer_id = b.customer_id
where last_name = 'Johnson');

--Question 14: Insert into INVENTORY Table
--Write a SQL statement to insert a new inventory record into the INVENTORY table:
--store_id: 1,product_id: 1,quantity_in_stock: 30
-- select * from INVENTORY;
insert into INVENTORY(store_id,product_id,quantity_in_stock,supplier_id)
values(1,1,30,1);

--Question 15: Update Store Information
--Write a SQL statement to update the store_name and location of the store with store_id = 1 to 'Tech Superstore' and 'City Center'.
-- select * from store;
update store set store_name = 'Tech Superstore', location ='City Center' where  store_id = 1;

--Question 16: Select Into Backup Table
--Write a SQL statement to create a backup of all rows in the CUSTOMER table into a new table called CUSTOMER_BACKUP.
create table CUSTOMER_BACKUP AS select * from customer;

--Question 17: Add JSON Column to PRODUCT Table
--Write a SQL statement to add a meta_data column of type JSON to the PRODUCT table.
-- select * from product;
alter table product add column meta_data jsonb;

--Question 18: Insert into JSON Column
--Write a SQL statement to insert JSON data into the meta_data column of the PRODUCT table. 
--The JSON should contain keys like "warranty_period", "brand", and "manufacture_date".
insert into product(product_name, category, price, description,sku, meta_data)
values ('Milk','drinks',3.99,'Good for health','DRINK-MILK-11',
'{"warranty_period":"15 days","brand":"Heritage","manufacture_date":"12-01-2025"}')
;
--Question 19: Update JSON Column
--Write a SQL statement to update the meta_data JSONB column of the PRODUCT table by adding or 
--updating the "warranty_period" for a specific product.
-- select * from product;
UPDATE PRODUCT
SET meta_data = jsonb_set(meta_data, '{warranty_period}', '"12 months"', true)
WHERE product_id = 1;

--Question 20: Delete JSON Data
--Write a SQL statement to remove the "manufacture_date" field from the meta_data JSON column for a specific product.
UPDATE PRODUCT
SET meta_data = meta_data - 'policy_number'
WHERE PRODUCT_ID = 17;

--Question 21: Perform an UPSERT on CUSTOMER Table
--Write a SQL statement to insert a new customer or update the email if the customer_id already exists in the CUSTOMER table.
-- select * from customer;
INSERT INTO CUSTOMER (first_name, last_name, gender, id_type, id_number, email, phone_number, address, city_id)
VALUES ('John', 'Doe', 'M', 'passport', 'A12345678', 'john.doe@example.com', '1234567890', '123 Main St', 1)
ON CONFLICT (customer_id) 
DO UPDATE SET email = EXCLUDED.email
;

--Question 22: Delete with INNER JOIN
--Write a SQL statement to delete all products in the PRODUCT table that are referenced in the SUPPLIER table by joining on product_id.

--alter table supplier add column product_id int references product(product_id) ON DELETE CASCADE;
-- select * from product;
-- select * from SUPPLIER;

-- update supplier set product_id = 11 where supplier_id = 1;

-- UPDATE supplier
-- SET product_id = CASE supplier_id
-- WHEN 2 THEN 11
-- WHEN 3 THEN 11
-- WHEN 4 THEN 11
-- WHEN 5 THEN 11
-- WHEN 6 THEN 11
-- WHEN 7 THEN 11
-- WHEN 8 THEN 11
-- WHEN 9 THEN 11
-- WHEN 10 THEN 11
-- WHEN 11 THEN 11
-- ELSE product_id
-- END
-- WHERE supplier_id IN(2,3,4,5,6,7,8,9,10,11);

--select * from product;

delete from PRODUCT where product_id in 	
	(select product_id from supplier_product
		where product_id = 11);

--Question 23: Update with JOIN
--Write a SQL statement to update the quantity_in_stock in the INVENTORY table for all products in the 
--store with store_name = 'Tech Superstore'. Use a join between the STORE and INVENTORY tables.
-- select * from INVENTORY;
-- select * from store;

update INVENTORY set quantity_in_stock = quantity_in_stock + 111
where store_id in
(select a.store_id from store a 
inner join inventory b ON a.store_id=b.store_id
where store_name = 'Tech Superstore')
;

--Question 24: Insert a New Discount
--Write a SQL statement to insert a new discount into the DISCOUNT table:
--discount_code: 'SUMMER20',discount_percentage: 20.00
-- select * from DISCOUNT
insert into discount(discount_code, discount_percentage)
values ('SUMMER20',20.00);


--Question 25: Truncate the ORDER Table
--Write a SQL statement to truncate the ORDER table, removing all rows without generating individual delete triggers.
-- select * from orders

--Truncate table orders

--Question 26: SUPER Complex INSERT.
--Create a DATE_DIM table with columns: date_id, calendar_date, year, month, day_of_the_month, week_day_number, week_day_name, 
--yearly_week_number, month_start_date_flag, month_end_date_flag, year_start_date_flag, year_end_date_flag, holiday_flag
--The date_id should be populated in the YYYYMM format (e.g., 202401).
--Populate the DATE_DIM table with data for current year and the next year.

-- Create the DATE_DIM table
-- select * from DATE_DIM

-- Create table DATE_DIM (
--     date_id int unique NOT NULL PRIMARY KEY, -- YYYYMM
--     calendar_date DATE default current_date NOT NULL,                       
--     year INT NOT NULL,
--     month INT check(month in (1,2,3,4,5,6,7,8,9,10,11,12)) NOT NULL,
--     day_of_the_month INT check(day_of_the_month >= 1 AND day_of_the_month <=31) NOT NULL,                    
--     week_day_number INT check(week_day_number >= 1 AND week_day_number <=7) NOT NULL,
--     week_day_name VARCHAR(9) 
--     check(week_day_name in ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')) NOT NULL,
--     yearly_week_number INT check(yearly_week_number >= 1 AND yearly_week_number <=53) NOT NULL,
--     month_start_date_flag BOOLEAN NOT NULL,
--     month_end_date_flag BOOLEAN NOT NULL,
--     year_start_date_flag BOOLEAN NOT NULL,
--     year_end_date_flag BOOLEAN NOT NULL,
--     holiday_flag BOOLEAN NOT NULL
-- );

-- insert into DATE_DIM(date_id, year, month, day_of_the_month, week_day_number, week_day_name, yearly_week_number,
-- month_start_date_flag, month_end_date_flag, year_start_date_flag, year_end_date_flag, holiday_flag)
-- values(202403, 2024, 6, 22, 6, 'Sunday', 52, 'false', 'true', 'false', 'true', 'true'); 

-- insert into DATE_DIM(date_id, calendar_date, year, month, day_of_the_month, week_day_number, week_day_name, yearly_week_number,
-- month_start_date_flag, month_end_date_flag, year_start_date_flag, year_end_date_flag, holiday_flag)
-- values(202501, '2025-01-01', 2024, 6, 22, 6, 'Sunday', 52, 'false', 'true', 'false', 'true', 'true'); 

--select * from date_dim;

--GOOD LUCK WITH YOUR ASSIGNMENT!!!











