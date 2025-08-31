-- Store DDL(Data Definition Language) ASSIGNMENT
-- Mujju-postgres-Store-Chapter05-ddl
create database Store_management_system;
use Store_management_system;

-- Question 1: Create the CITY Table with Constraints
create table city(
	city_id INT auto_increment primary key
    ,country_name varchar(50) not null
    ,city_name varchar(50) not null
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
	,UNIQUE (country_name, city_name)
);
-- select * from city

-- Question 2: Create the STORE Table
create table store (
	store_id INT auto_increment primary key
    ,store_name varchar(255) not null
	,location varchar(255) not null
	,phone_number varchar(20) unique not null
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);
-- select * from store;

-- Question 3: Create the PRODUCT Table
create table product (
	product_id INT auto_increment primary key
	,product_name varchar(50) not null
	,category varchar(10) check (category in ('drinks','snacks','fruits')) not null
	,price numeric(10,2) not null
	,quantity_in_stock int not null
	,description text not null
	,sku varchar(255) not null
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);
-- select * from product;

-- Question 4: Create the SUPPLIER Table with a Foreign Key
create table supplier(
	supplier_id INT auto_increment primary key
	,supplier_name varchar(255) not null
	,contact_number varchar(20) not null
	,active_flag boolean default true not null
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);
-- select * from supplier;

-- Question 5: Define the SUPPLIER_PRODUCT Table
create table SUPPLIER_PRODUCT(
	supplier_product_id INT auto_increment primary key
	,supplier_id int
	,product_id int
	,foreign key (supplier_id) references supplier(supplier_id)  ON DELETE CASCADE
	,foreign key (product_id) references product(product_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 6: Create the INVENTORY Table
create table inventory(
	inventory_id INT auto_increment primary key  -- you haven't provided inventory_id on website
	,store_id int
	,product_id int
	,quantity_in_stock int not null
	,foreign key (store_id) references store(store_id)  ON DELETE CASCADE
	,foreign key (product_id) references product(product_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 7: Create the CUSTOMER Table with Constraints
create table customer(
	customer_id INT auto_increment primary key
	,first_name varchar(255) not null
	,last_name varchar(255) not null
	,gender char(1) check (gender in ('M','F')) not null
	,ID_type varchar(50) check (ID_type in ('passport','driving license')) not null
	,ID_number varchar(255) not null
	,email varchar(50) unique not null
	,phone_number varchar(50) unique not null
	,address varchar(255) not null
	,city_id int
	,foreign key (city_id) references city(city_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);
-- select * from customer;

-- Question 8: Create the ORDER Table
create table orders(
	order_id INT auto_increment primary key
	,order_date datetime default current_timestamp
	,total_amount numeric(10,2) not null
	,delivered_duration DATETIME DEFAULT CURRENT_TIMESTAMP
	,customer_id int not null
	,store_id int not null
	,order_status varchar(20) not null
	,foreign key (customer_id) references customer(customer_id)  ON DELETE CASCADE
	,foreign key (store_id) references store(store_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);
-- -added check (order_status in ('Accepted','Packing','Ready for Delivery','Shipping','Delivered','Paid','Closed'))

-- Question 9: Create the ORDER_PRODUCT Table
create table order_product(
	order_product_id INT auto_increment primary key
	,order_id int not null
	,product_id int not null
	,units int not null
	,unit_rate numeric(10,2) not null
	,total_amount numeric(10,2) not null
    ,foreign key (order_id) references orders(order_id)  ON DELETE CASCADE
	,foreign key (product_id) references product(product_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 10: Create the PAYMENT Table
create table payment(
	payment_id INT auto_increment primary key
	,payment_date datetime default current_timestamp not null
	,amount_paid numeric(10,2) not null
	,order_id int not null
	,foreign key (order_id) references orders(order_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 11: Define the EMPLOYEE Table with Relationships
create table employee(
	employee_id INT auto_increment primary key
	,first_name varchar(50) not null
	,last_name varchar(50) not null
	,email varchar(50) unique not null
	,hire_date date not null
	,salary numeric(10,2) not null
	,store_id int not null
	,foreign key (store_id) references store(store_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 12: Create the EMPLOYEE_LOGIN Table
create table employee_login(
	employee_login_id INT auto_increment primary key 	
	,employee_id int not null
	,login_id varchar(50) unique not null
	,password text not null
	,active_flag int check (active_flag in (0,1)) not null
	,last_login_datetime datetime default current_timestamp not null
	,foreign key (employee_id) references employee(employee_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 13: Create the DISCOUNT Table
create table discount(
	discount_id INT auto_increment primary key
	,discount_code varchar(100) unique not null
	,discount_percentage numeric(5,2) check (discount_percentage between 0 and 100) not null
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 14: Create the AUDIT_LOG Table
create table audit_log(
	audit_log_id INT auto_increment primary key
	,log_date date not null
	,action varchar(255) not null
	,employee_id int not null
	,foreign key (employee_id) references employee(employee_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 15: Create the RETURN_POLICY Table with Constraints
create table return_policy(
	policy_id INT auto_increment primary key
	,return_window_days int check(return_window_days > 0) not null
	,restocking_fee numeric(5,2) not null
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 16: Define the ORDER_DISCOUNT Table
create table order_discount(
	order_discount_id INT auto_increment primary key
	,order_id int not null
	,discount_id int not null
	,foreign key (order_id) references orders(order_id)  ON DELETE CASCADE
	,foreign key (discount_id) references discount(discount_id)  ON DELETE CASCADE
	,created_at datetime default current_timestamp not null
	,updated_at datetime default current_timestamp not null
);

-- Question 17: Add a Column to the EMPLOYEE Table
-- Write a SQL statement to add a phone_number column of type VARCHAR(15) to the EMPLOYEE table.
-- select * from employee;
alter table employee add column phone_number varchar(20) unique;

-- Question 18: Alter a Column in the CUSTOMER Table
-- Write a SQL statement to alter the email column in the CUSTOMER table, increasing its length to 255 characters.
-- select * from customer;
alter table customer modify column email varchar(255);

-- Question 19: Drop a Column from the PRODUCT Table
-- Write a SQL statement to drop the quantity_in_stock column from the PRODUCT table.
alter table product drop column quantity_in_stock;

-- select * from product;

-- Question 20: Rename the RETURN_POLICY Table
-- Write a SQL statement to rename the RETURN_POLICY table to STORE_POLICY.
alter table return_policy rename to store_policy;

-- select * from store_policy;

-- Question 21: Drop the STORE_POLICY Table
-- Write a SQL statement to drop the STORE_POLICY table.
drop table store_policy;

-- Question 22: Add a Primary Key to existing table
-- Add a composite primary key to the INVENTORY table on store_id+product_id columns.
-- select * from inventory;
-- ------if your table is not having PK--------
-- alter table inventory ADD CONSTRAINT pk_inventoryy primary key (store_id,product_id);

-- Question 23: Add a Primary Key to existing table
-- Add a composite primary key to the SUPPLIER_PRODUCT table on supplier_id+product_id columns.
-- select * from supplier_product
-- ------if your table is not having PK--------
-- alter table SUPPLIER_PRODUCT ADD CONSTRAINT pk_SUPPLIER_PRODUCT primary key (supplier_id,product_id);

-- Question 24: Alter the STORE Table to Add a Foreign Key
-- Write a SQL statement to add a city_id column to STORE Table along with foreign key referencing the CITY table.
-- select * from store;
-- alter table store add column city_id int references city(city_id)  ON DELETE CASCADE;

-- Question 25: Add a Foreign Key to the INVENTORY Table
-- Add a foreign key in the INVENTORY table to reference the SUPPLIER table.
-- select * from inventory;
-- select * from supplier;
-- alter table inventory add column supplier_id int not null;
-- alter table inventory ADD CONSTRAINT fk foreign key (supplier_id) references supplier(supplier_id)  ON DELETE CASCADE;

-- Question 26: Drop a Foreign Key on the EMPLOYEE Table
-- Remove the foreign key in the EMPLOYEE table that references the STORE table.
-- select * from employee;

-- SELECT constraint_name
-- FROM information_schema.table_constraints
-- WHERE table_name = 'employee' AND constraint_type = 'FOREIGN KEY';
-- -employee_store_id_fkey

alter table employee drop constraint employee_store_id_fkey;

-- Question 27: Add a CHECK Constraint on the ORDER_PRODUCT Table
-- Write a SQL statement to add a CHECK constraint to the ORDER_PRODUCT table ensuring that the units is greater than 0.
-- select * from ORDER_PRODUCT;
alter table order_product add constraint unit_check check (units > 0);

-- Question 28: Add a CHECK Constraint on the ORDER Table
-- Write a SQL statement to add a CHECK constraint to the ORDER table ensuring that the 
-- order_status is in (Accepted, Packing, Ready for Delivery, Shipping, Delivered, Paid, Closed).
-- select * from ORDERS
alter table orders add constraint check_status 
check (order_status in ('Accepted','Packing','Ready for Delivery','Shipping','Delivered','Paid','Closed'));

SELECT constraint_name
FROM information_schema.table_constraints
WHERE table_name = 'orders' AND constraint_type = 'CHECK';

-- Question 29: Add a UNIQUE Constraint on the ORDER_PRODUCT Table
-- Write a SQL statement to add a UNIQUE constraint on the ORDER_PRODUCT table to prevent duplicate product_id values for a given order_id.
-- select * from order_product;
alter table order_product add constraint unique_const unique (product_id,order_id);

-- Question 30: Add a DEFAULT Constraint on the ORDER_PRODUCT Table
-- Write a SQL statement to add a DEFAULT constraint on the ORDER_PRODUCT table to automatically 
-- calculate the total_amount as the product of units and unit_price.
ALTER TABLE ORDER_PRODUCT
ALTER COLUMN total_amount
SET DEFAULT 0;

-- Question 31: Add a default Constraint on the EMPLOYEE Table
-- Write a SQL statement to add a current system timestamp DEFAULT constraint to the EMPLOYEE table on created_at column.
-- select * from employee;
alter table employee alter column created_at set default Current_timestamp;

-- Question 32: Add Indexes to the PRODUCT and CUSTOMER Tables
-- Write SQL statements to:
-- Add an index on the product_name column in the PRODUCT table.
-- Add an index on the last_name column in the CUSTOMER table.
create index idx_product_name on product(product_name);

create index idx_last_name on CUSTOMER(last_name);

-- Question 33: Drop a INDEX on the CUSTOMER Table
-- Write a SQL statement to drop the index on the last_name column in the CUSTOMER table.
drop index idx_last_name;

-- Question 34: Enforce UNIQUE constraints on all applicable tables.
-- Apply UNIQUE constraints to columns across the entire database wherever duplicate data is not permitted.
alter table product add constraint unique_sku unique(sku);
alter table supplier add constraint unique_supplier unique(contact_number);
alter table customer add constraint unique_ID_number unique(ID_number);
-- other unique values created with tables


-- --GOOD LUCK WITH YOUR ASSIGNMENT!!!














