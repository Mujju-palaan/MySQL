Assignment Tasks:
Stored Procedure Tasks:

1)Stored Procedure for Employee Information

Write a stored procedure that retrieves all rows from the EMPLOYEE table where the city is a specific value passed as a input parameter.
--- Done

2)Stored Procedure for City Management

Write a stored procedure to insert a new record into the CITY table. The procedure should take country_name and city_name as input parameters.
--- Done

3)Stored Procedure for Salary Management version 1

Write a stored procedure to update the salary of a specific EMPLOYEE by adding a updated salary. The procedure should take employee_id and new salary as parameters.
--- Done

4)Stored Procedure for Salary Management version 2

Design a database stored procedure to update employee salaries for multiple employee IDs provided as input. The procedure should also accept the salary increase percentage as an input parameter. Utilize JSON, XML, or SQL table variables to manage and process multiple employee records. Temporary tables can be used if required. Input parameters: employee_ids and increase_percent.
--- Done

5)Stored Procedure for Customer Data Grid

Create a database stored procedure to retrieve comprehensive customer details, including phone_number and email, for displaying in the Customer Management screen's data grid. The procedure should also calculate and return the customer's cash balance, credit balance, and loan balance. Implement pagination for the UI grid using temporary tables, with the UI grid page number passed as an input parameter.
--- Done

6)Stored Procedure for Loan Payments

Create a database stored procedure to fetch all loan instalments for a specific customer by accepting customer_id as an input parameter. The procedure should join the CUSTOMER, LOAN, and LOAN_INSTALMENTS tables to retrieve relevant details, including loan_id, instalment_amount, due_date, paid_date, and loan_start_date.
--- Done

7)Stored Procedure for Banking Transactions
Develop an SQL stored procedure to process banking debit and credit transactions. The procedure should execute the following tasks: log the transaction in the transaction table, update the account balance, and document the changes in the account history. Additionally, if the transaction pertains to a credit card purchase, ensure the CARD table is updated accordingly.
--- Done

8)Stored Procedure for Loan Payment

Create a stored procedure to manage loan payments. The procedure should execute the following tasks: log the payment in the transaction table, record the details in the loan payment table, update the loan instalment records, adjust the account balance, and document the changes in the account history. If the payment clears the loan in full, update the loan's end date in the LOAN table. To accommodate payments covering multiple months, accept instalment IDs as input and distribute the funds across the specified monthly instalment buckets accordingly.
--- Done

9)Stored Procedure for Fund Transfer

Create a stored procedure to manage fund transfer details. The procedure should perform the following operations: insert a record into the fund transfer table, log the transaction in the transaction table, update the account balance, and record the changes in the account history.
--- Done

10)Stored Procedure to Reverse a Fund Transfer

Develop a stored procedure to handle fund transfer refunds. The procedure should execute the following actions. update the fund transfer record, log the refund in the transaction table, adjust the account balance, and document the changes in the account history.
--- Done

11)Stored Procedure for Customer Login
Create a database stored procedure to validate user login, fetch customer details, and update the last_login_datetime. The procedure should return an error if the login ID is not found or the password does not match. Ensure the stored encrypted password is decrypted during the validation process.
--- Done

View Tasks:
1)View for Customer Information

Create a db view that retrieves the first_name, last_name, email, and phone_number of all customers along with their corresponding city names.
--- Done

2)View for Account Details

Create a database view that displays account details, customer_id, first_name, last_name, account_id, account_type, and balance. Include the city name and country name using appropriate joins.
--- Done

3)View for Loan Details

Create a SQL view to summarize loan details, including: loan_id, customer_id, first_name, last_name, loan_amount, interest_rate, loan_start_date, and loan_end_date. Include the total number of instalments and the sum of all instalment amounts for each loan.
--- Done

Function Tasks:
1)Function to Calculate Total Loan Balance per Customer

Write a database function to calculate the total outstanding loan balance for a customer based on their loans. Use SQL variables within the function to implement this logic.


2)Function to Calculate Interest on Loans

Write a database function that calculates the monthly interest to be added to the principal amount of a loan each month, based on the loan_amount, interest_rate, and number_of_monthly_instalments.


3)Function to display loan details

Write a database function that retrieves customer loan information based on the screen 
design provided at the bottom of this webpage.


Trigger Task:
Trigger on Transaction Amount Changes

1.Create a trigger on the TRANSACTION table that logs changes to the amount field into the 
AUDIT_LOG table. The log should capture the transaction_id, old_amount, new_amount, log_date, 
and employee_id.


2.Insert and Update Triggers on ACCOUNT_HISTORY table -Create a trigger on the 
 table to ensure that there is only one record per account_id where the latest_record 
 boolean value is set to TRUE.