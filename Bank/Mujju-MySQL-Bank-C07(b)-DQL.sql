-- Chapter 7 - DQL (Data Query Language)
-- DQL ASSIGNMENT3 - SQL Logic for Dashboard Reporting in a Banking Application

-- 1. Customer Overview
-- Task: Write SQL queries to generate the following metrics:
-- Number of Customers: Write a query to count the total number of customers in the system.
select count(*) from customer;

-- Customer Email List: Write a query to retrieve the list of unique customer emails 
-- for marketing purposes.
select distinct email from customer;

-- Customer Account Balances: Write a query that lists customers along with their 
-- total account balances, grouped by customer. (select * from customer)
select 
	a.customer_id
	,CONCAT(a.first_name, '  ', a.last_name) as name
    ,sum(balance)
from customer a
inner join account b using(customer_id)
group by a.customer_id, a.first_name||'  '||a.last_name
;

-- Recent Customers: Write a query that lists customers who joined in the last 30 days.
select * from customer
where created_at = current_date() - interval 1 month
;

-- 2. Account Overview
-- Task: Write SQL queries to pull account-related insights:
-- Number of Accounts by Type: Write a query to count how many accounts exist for 
-- each account type (e.g., savings, checking).
select 
	account_type
    ,count(*)
from account
group by account_type
;

-- Total Account Balance: Write a query to calculate the total balance of all accounts 
-- (for a gauge or bar chart).
select
	account_id
    ,sum(balance)
from account
group by account_id;

-- Active vs Dormant Accounts: Write a query to identify active and dormant accounts 
-- based on recent transactions. (select * from transaction )
select 
	account_id
    ,transaction_type
    ,transaction_status
    ,case
		when transaction_status = 'completed' then 'active'
        else 'inactive'
	END as live_stats
from account
inner join transaction using(account_id);

-- Accounts with Overdrafts: Write a query to list accounts where the balance has gone below 0.
select * from account
where balance < 0;

-- 3. Transaction Overview
-- Task: Use SQL to pull transaction-related insights:
-- Total Transactions by Account: Write a query that retrieves the total number 
-- of transactions per account.
select 
	account_id
    ,count(transaction_id)
from transaction 
group by account_id;

-- Transaction Type Breakdown: Write a query to retrieve a breakdown of the number 
-- of debit vs credit transactions.
select  
	transaction_type
    ,count(*)
from transaction
group by transaction_type;

-- High-Value Transactions: Write a query that lists all transactions above 
-- a certain threshold (e.g., greater than 10,000 USD).
select amount from transaction
where amount > 10000;

-- Transactions by Month: Write a query that shows the number of transactions 
-- for each month (for a line graph).
select 
	extract(month from transaction_date)
	,count(*)
from transaction
group by extract(month from transaction_date);

-- 4. Loan Overview
-- Task: Create SQL queries to monitor loans:
-- Total Loan Amounts by Customer: Write a query that retrieves the total 
-- loan amounts for each customer.
select 
	customer_id
    ,sum(loan_amount)
from customer
inner join account using(customer_id)
inner join loan using(account_id) 
group by customer_id
;

-- Active vs Closed Loans: Write a query to count active loans 
-- (where loan_end_date is null) versus closed loans.
select 
	loan_id
    ,case
		when loan_end_date > current_date() then 'active'
        when loan_end_date = null then 'deactived'
        else 'deactived'
	END as stats
from loan;


-- Overdue Loans: Write a query that lists loans that are overdue based on 
-- the current date and loan_end_date.
select
	loan_id
	,case
		when loan_end_date > current_date() then 'Overdue'
        else 'paid'
	END as status
from loan
inner join account using(account_id);

-- 5. Employee Overview
-- Task: Use SQL to manage employee-related data:
-- Number of Employees per Branch: Write a query to retrieve the number
--  of employees working at each branch.
select 
	branch_id
    ,count(*)
from employee
group by branch_id;

-- Employee Salary Report: Write a query to retrieve the salary details for all employees.
select employee_id
	,sum(salary) 
from employee
group by employee_id;

-- Employee Loan Issuance Activity: Write a query that retrieves the number 
-- of loans issued by each employee.
select 
	customer_id
    ,count(loan_id)
from customer
inner join account using(customer_id)
inner join loan using(account_id)
group by customer_id;

-- 6. Branch Overview
-- Task: Write SQL queries to generate insights about bank branches:
-- List of Branches: Write a query that lists all branches along with their locations.
select branch_name, branch_location from branch;

-- Branch Account Balances: Write a query that retrieves the total balance of 
-- accounts managed by each branch.
select 
	branch_id
	,sum(balance) as total_balance
from account
inner join customer using(customer_id)
inner join branch using(branch_id)
group by branch_id;

-- Branch Loan Issuance: Write a query that shows the total loan amounts issued by each branch.
select 
	branch_id
	,sum(loan_amount) as total_loan
from account
inner join customer using(customer_id)
inner join branch using(branch_id)
inner join loan using(account_id)
group by branch_id;

-- Key Visuals and Corresponding SQL Queries:
-- Note: All dashboard queries must work against current month or current year filters

-- Bar Chart - Accounts by Type
-- Query: Write an SQL query to retrieve the number of accounts for each account type 
-- from the `ACCOUNT` table.
-- X-Axis: Account types.
-- Y-Axis: Number of accounts.
select ACCOUNT_TYPE
	,COUNT(*)
from account
GROUP BY ACCOUNT_TYPE;

-- Pie Chart - Transactions by Type
-- Query: Write a query to retrieve the number of debit and credit transactions 
-- from the `TRANSACTION` table.
-- Sections: Debit and Credit transactions.
SELECT 
	TRANSACTION_TYPE
    ,COUNT(*)
FROM TRANSACTION
GROUP BY TRANSACTION_TYPE;

-- Line Graph - Transactions by Month
-- Query: Write a query that retrieves the total number of transactions for 
-- each month from the `TRANSACTION` table.
-- X-Axis: Month (grouped by transaction_date).
-- Y-Axis: Number of transactions.
SELECT  
	extract(MONTH FROM TRANSACTION_DATE) AS MONTH
    ,COUNT(*)
FROM TRANSACTION
GROUP BY extract(MONTH FROM TRANSACTION_DATE);

-- Gauge - Total Account Balance
-- Query: Write an SQL query to calculate the total account balance from the `ACCOUNT` table.
-- Display: Total balance across all accounts.
SELECT SUM(BALANCE) FROM ACCOUNT;

-- Table - Employee Loan Issuance Activity
-- Query: Write an SQL query to retrieve the number of loans issued by each 
-- employee from the `LOAN` and `EMPLOYEE` tables.
-- Columns: Employee Name, Number of Loans Issued.
SELECT 
	EMPLOYEE_ID
    ,COUNT(*) AS LOAN_ISSUED
FROM EMPLOYEE
INNER JOIN LOAN ON EMPLOYEE_ID = CREATED_EMPLOYEE_ID
GROUP BY EMPLOYEE_ID;

-- Data Sources (Tables Mapped):
-- Customer Data: `CUSTOMER` table .
-- Account Data: `ACCOUNT` table, `ACCOUNT_HISTORY` table.
-- Transaction Data: `TRANSACTION` table.
-- Loan Data: `LOAN` table, `LOAN_PAYMENT` table.
-- Employee Data: `EMPLOYEE` table.
-- Branch Data: `BRANCH` table.
-- Audit Log Data: `AUDIT_LOG` table.


-- GOOD LUCK WITH YOUR ASSIGNMENT!!!
-- Don't forget to contact us if you need any further assistance with your assignments, and most importantly, for a manual review and approval of your work.