-- Banking_Application_System
-- create database Bank;
-- use Bank;

-- Question 1: Create the CITY Table with Constraints

CREATE TABLE CITY (
    city_id int auto_increment PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    UNIQUE (country_name, city_name)
);
-- select * from city

-- Question 2: Create the BRANCH Table with Default Values

CREATE TABLE branch (
    branch_id int auto_increment PRIMARY KEY,
    branch_name VARCHAR(255) NOT NULL,
    branch_location VARCHAR(255) DEFAULT 'Main Branch',
    city_id INT,
	created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (city_id) REFERENCES CITY(city_id)
);
-- select * from branch

-- Question 3: Define the EMPLOYEE Table with Relationships

CREATE TABLE EMPLOYEE (
    employee_id int auto_increment PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    branch_id INT,
    city_id INT,
    created_at datetime default current_timestamp NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id),
    FOREIGN KEY (city_id) REFERENCES CITY(city_id)
);
-- select * from EMPLOYEE;

--  Question 4: Create the CUSTOMER Table

CREATE TABLE CUSTOMER (
    customer_id int auto_increment PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')) NOT NULL,
    ID_type VARCHAR(50) NOT NULL,
    ID_number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city_id INT,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY(city_id) REFERENCES CITY(city_id)
);
-- select * from customer


--  Question 5: Create the ACCOUNT Table with Constraints

CREATE TABLE ACCOUNT (	
    account_id int auto_increment PRIMARY KEY,
    account_type VARCHAR(50) NOT NULL CHECK (account_type IN ('savings', 'checking', 'loan', 'current')),
    balance DECIMAL(12, 2) NOT NULL CHECK (balance >= 0),
    customer_id INT NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);
-- select * from account


--  Question 6: Create the CARD Table

CREATE TABLE CARD (
    card_id  int auto_increment PRIMARY KEY,
    card_number VARCHAR(16) UNIQUE NOT NULL,
    card_type VARCHAR(50) NOT NULL,
    expiration_date DATE NOT NULL,
    max_credit_limit DECIMAL(12, 2) NOT NULL,
    available_credit_limit DECIMAL(12, 2) NOT NULL,
    account_id INT NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY(account_id) REFERENCES ACCOUNT(account_id)
);
-- select * from card;

--  Question 7: Create the TRANSACTION Table

CREATE TABLE TRANSACTION (
    transaction_id int auto_increment PRIMARY KEY,
    transaction_date DATE DEFAULT (NOW()) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_type VARCHAR(50) CHECK (transaction_type IN ('debit', 'credit')) NOT NULL,
    payment_mode VARCHAR(50) CHECK (payment_mode IN ('ATM', 'cash deposit', 'loan payment', 'fund transfer', 'debit card', 'fees', 'credit card')) NOT NULL,
    account_id INT NOT NULL,
    transaction_status VARCHAR(50) CHECK (transaction_status IN ('processing', 'declined', 'completed')) NOT NULL,
    description VARCHAR(150),
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY(account_id) REFERENCES ACCOUNT(account_id)
);
-- select * from transaction;


--  Question 8: Create the ACCOUNT_HISTORY Table

CREATE TABLE ACCOUNT_HISTORY (
    history_id int auto_increment PRIMARY KEY,
    account_id INT NOT NULL,
    balance_before DECIMAL(12, 2) NOT NULL,
    balance_after DECIMAL(12, 2) NOT NULL,
    latest_record BOOLEAN DEFAULT TRUE NOT NULL,
    transaction_id INT NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (account_id) REFERENCES ACCOUNT(account_id),
    FOREIGN KEY (transaction_id) REFERENCES TRANSACTION(transaction_id)
);

-- select * from account_history


--  Question 9: Create the LOAN Table with a Foreign Key

CREATE TABLE LOAN (
    loan_id int auto_increment PRIMARY KEY,
    loan_amount DECIMAL(12, 2) NOT NULL,
    number_of_monthly_instalments INT NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    loan_start_date DATE NOT NULL,
    loan_end_date DATE NOT NULL,
    customer_id INT NOT NULL,
    account_id INT NOT NULL,
    created_employee_id INT NOT NULL,
	created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (account_id) REFERENCES ACCOUNT(account_id),
    FOREIGN KEY (created_employee_id) REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
-- select * from loan;
    
--  Question 10: Define the LOAN_INSTALMENTS Table

CREATE TABLE LOAN_INSTALMENTS (
    instalment_id int auto_increment PRIMARY KEY,
    loan_id INT NOT NULL,
    instalment_amount DECIMAL(12, 2) NOT NULL,
    due_date DATE NOT NULL,
    paid_status BOOLEAN DEFAULT FALSE NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES LOAN(loan_id)
);
-- select * from loan_instalments;

--  Question 11: Create the LOAN_PAYMENT Table

CREATE TABLE LOAN_PAYMENT (
	LOAN_PAYMENT int auto_increment PRIMARY KEY,
    instalment_id INT NOT NULL,
    transaction_id INT NOT NULL,
    -- PRIMARY KEY (instalment_id, transaction_id),
    FOREIGN KEY (instalment_id) REFERENCES LOAN_INSTALMENTS(instalment_id),
    FOREIGN KEY (transaction_id) REFERENCES TRANSACTION(transaction_id)
);
-- select * from loan_payment

--  Question 12: Create the BENEFICIARY Table with Constraints

CREATE TABLE BENEFICIARY (
    beneficiary_id int auto_increment PRIMARY KEY,
    primary_consumer_id INT NOT NULL,
    beneficiary_bank VARCHAR(255) NOT NULL,
    beneficiary_name VARCHAR(255) NOT NULL,
    beneficiary_account_number VARCHAR(255) NOT NULL,
    beneficiary_swift VARCHAR(255) NOT NULL,
    beneficiary_iban VARCHAR(255) NOT NULL,
    nick_name VARCHAR(255) NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (primary_consumer_id) REFERENCES CUSTOMER(customer_id)
);
-- select * from BENEFICIARY;

--  Question 13: Create the FUND_TRANSFER Table with Constraints

CREATE TABLE FUND_TRANSFER (
    fund_transfer_id int auto_increment PRIMARY KEY,
    beneficiary_id INT ,
    transaction_id INT ,
    refund_transaction_id INT,
    transfer_timestamp timestamp default current_timestamp NOT NULL,
    transfer_status VARCHAR(50) CHECK (transfer_status IN ('processing', 'failed', 'completed')) NOT NULL,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (beneficiary_id) REFERENCES BENEFICIARY(beneficiary_id),
    FOREIGN KEY (transaction_id) REFERENCES TRANSACTION(transaction_id),
    FOREIGN KEY (refund_transaction_id) REFERENCES TRANSACTION(transaction_id)
);
-- select * from fund_transfer;

--  Question 14: Create the CUSTOMER_LOGIN Table
CREATE TABLE CUSTOMER_LOGIN (
	-- CUSTOMER_LOGIN_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    login_id VARCHAR(255) unique NOT NULL,
    password VARCHAR(255) NOT NULL,
    active_flag BOOLEAN NOT NULL,
    last_login_datetime TIMESTAMP default current_timestamp not null,
    created_at datetime DEFAULT current_timestamp NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
-- select * from CUSTOMER_LOGIN;


--  Question 15: Create the AUDIT_LOG Table
CREATE TABLE AUDIT_LOG (
    log_id  int auto_increment PRIMARY KEY,
    log_date timestamp default current_timestamp NOT NULL,
    action VARCHAR(255) NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id)
);
-- select * from AUDIT_LOG;

--  Question 16: Create the OVERDRAFT_POLICY Table with Constraints

CREATE TABLE OVERDRAFT_POLICY (
    policy_id int auto_increment PRIMARY KEY,
    max_overdraft_limit numeric(12, 2) CHECK (max_overdraft_limit >= 0) NOT NULL,
    interest_rate numeric(5, 2) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);
-- select * from overdraft_policy;

--  Question 17: Rename the OVERDRAFT_POLICY Table

-- RENAME TABLE OVERDRAFT_POLICY TO COMPANY_POLICY;

alter table OVERDRAFT_POLICY rename to COMPANY_POLICY;

-- select * from COMPANY_POLICY;

--  Question 18: Drop the COMPANY_POLICY Table

DROP TABLE COMPANY_POLICY;


--  Question 19: Add Indexes to the CUSTOMER and ACCOUNT Tables

-- Add index on last_name column in the CUSTOMER table
CREATE INDEX idx_last_name ON CUSTOMER(last_name);

-- Add index on account_type column in the ACCOUNT table
CREATE INDEX idx_account_type ON ACCOUNT(account_type);


--  Question 20: Add a CHECK Constraint on the ACCOUNT Table

ALTER TABLE ACCOUNT
    ADD CONSTRAINT chk_balance CHECK (balance >= 0);
-- select * from account

--  Question 21: Add a Primary Key to existing table

ALTER TABLE CUSTOMER_LOGIN
    ADD PRIMARY KEY (customer_id);


--  Question 22: Add a Foreign Key to the PAYMENT Table

-- ALTER TABLE PAYMENT
   -- ADD COLUMN account_id INT,
    -- ADD FOREIGN KEY (account_id) REFERENCES ACCOUNT(account_id);


--  Question 23: Add a Column to the EMPLOYEE Table

ALTER TABLE EMPLOYEE
    ADD COLUMN phone_number VARCHAR(15);


--  Question 24: Alter the CUSTOMER Table to Add a Foreign Key Column

ALTER TABLE CUSTOMER
    ADD COLUMN branch_id INT,
    ADD FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id);


--  Question 25: Alter a Column in the CUSTOMER Table
-- select * from customer;

ALTER TABLE CUSTOMER
    modify COLUMN email  text;


--  Question 26: Drop a Column from the LOAN Table

-- ALTER TABLE LOAN
   --  DROP COLUMN created_employee_id;


--  Question 27: Drop an Index from the ACCOUNT Table

-- DROP INDEX idx_account_type on account;


--  Question 28: Add a default Constraint on the EMPLOYEE Table

-- ALTER TABLE EMPLOYEE 
-- 	-- alter COLUMN created_at date
-- 	add constraint def DEFAULT CURRENT_date (created_at);


--  Question 29: Add a UNIQUE Constraint on the CUSTOMER Table

ALTER TABLE CUSTOMER
    ADD CONSTRAINT unique_id UNIQUE (ID_type, ID_number);


--  Question 30: Enforce UNIQUE constraints on all applicable tables

ALTER TABLE CUSTOMER ADD CONSTRAINT unique_customer_email UNIQUE (email);
ALTER TABLE CARD ADD CONSTRAINT unique_card_number UNIQUE (card_number);


-- -- DROP TABLE category
-- create table product_category(
-- 	category_id serial PRIMARY KEY,
--     category_name varchar(100) UNIQUE NOT NULL,
--     created_at date DEFAULT NOW() not null
-- );
-- -- select * from product_category

-- -- drop table product
-- create table product(
--     product_id serial PRIMARY KEY,
--     product_name varchar(100) UNIQUE NOT NULL,
--     category_id INT NOT NULL,
--     descp varchar(200) NULL,
--     price numeric(12,2) NOT NULL,
--     unit_of_measure varchar(50) NOT NULL,
--     available_stock int null,
--     reorder_stock_limit int null,
--     created_at timestamp DEFAULT NOW() not null,
--     CHECK (unit_of_measure in ('kg', 'grm', 'dozen', 'count','ltr')),
--     FOREIGN KEY (category_id) REFERENCES product_category(category_id)
--     );
    
-- alter table 
-- alter table product add column sku varchar(25) not null;

-- alter table product alter column descp type varchar(500);

-- alter table product add constraint
-- chk_product_unitPrice CHECK (price > 0);

-- alter table product alter column descp set not null;
-- -- create index    
-- create index idx_product_product_name on product (product_name);
    
 