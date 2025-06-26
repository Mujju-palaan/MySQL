-- Mujju-pg-Bank-C06(a)-DML 
-- Banking_Application_System

-- Question 1: Insert Data into all Tables

-- 1. CITY Table
-- select * from city;
INSERT INTO CITY (country_name, city_name)
VALUES
('USA', 'Los Angeles'),
('Canada', 'Toronto'),
('Canada', 'Vancouver'),	
('UK', 'London'),
('UK', 'Manchester'),
('Germany', 'Berlin'),
('Germany', 'Munich'),
('France', 'Paris'),
('France', 'Marseille'),
('USA', 'New York')
;

-- 2. BRANCH Table
-- select * from BRANCH;
INSERT INTO BRANCH (branch_name, branch_location, city_id)
VALUES
('Main Branch', 'Downtown', 1),
('Westside Branch', 'West End', 2),
('North Branch', 'North Avenue', 3),
('East Branch', 'East Park', 4),
('Central Branch', 'City Center', 5),
('South Branch', 'South Mall', 6),
('Airport Branch', 'Airport Terminal', 7),
('Suburban Branch', 'Suburb Street', 8	),
('Business District Branch', 'Business Park', 9),
('Corporate Branch', 'Corporate Plaza', 10)
;

-- 3. EMPLOYEE Table
-- select * from EMPLOYEE;
INSERT INTO EMPLOYEE (first_name, last_name, hire_date, salary, branch_id, city_id, phone_number)
VALUES
('John', 'Doe', '2020-01-15', 50000.00, 1, 1, '123-456-7890'),
('Jane', 'Smith', '2021-03-10', 60000.00, 2, 2, '234-567-8901'),
('Sam', 'Brown', '2022-04-20', 45000.00, 3, 3, '345-678-9012'),
('Alice', 'Davis', '2019-05-05', 55000.00, 4, 4, '456-789-0123'),
('Bob', 'Miller', '2020-06-11', 47000.00, 5, 5, '567-890-1234'),
('Charlie', 'Wilson', '2021-07-01', 70000.00, 6, 6, '678-901-2345'),
('Emma', 'Taylor', '2022-08-15', 48000.00, 7, 7, '789-012-3456'),
('David', 'Anderson', '2018-09-25', 62000.00, 8, 8, '890-123-4567'),
('Olivia', 'Thomas', '2020-10-05', 53000.00, 9, 9, '901-234-5678'),
('Lucas', 'Jackson', '2021-11-12', 51000.00, 10, 10, '012-345-6789')
;

-- 4. CUSTOMER Table
-- select * from CUSTOMER order by customer_id;
INSERT INTO CUSTOMER (first_name, last_name, gender, ID_type, ID_number, email, phone_number, address, city_id, branch_id)
VALUES
('Michael', 'Johnson', 'M', 'Passport', '123456789', 'michael.johnson@email.com', '123-456-7890', '123 Elm St', 1, 1),
('Emily', 'Williams', 'F', 'Driver License', '987654321', 'emily.williams@email.com', '234-567-8901', '456 Oak St', 2, 2),
('James', 'Jones', 'M', 'National ID', '1122334455', 'james.jones@email.com', '345-678-9012', '789 Pine St', 3, 3),
('Sarah', 'Brown', 'F', 'Passport', '2233445566', 'sarah.brown@email.com', '456-789-0123', '321 Maple St', 4, 4),
('David', 'Miller', 'M', 'Driver License', '3344556677', 'david.miller@email.com', '567-890-1234', '654 Cedar St', 5, 5),
('Laura', 'Davis', 'F', 'National ID', '4455667788', 'laura.davis@email.com', '678-901-2345', '987 Birch St', 6, 6),
('Sophia', 'Garcia', 'F', 'Passport', '5566778899', 'sophia.garcia@email.com', '789-012-3456', '321 Willow St', 7, 7),
('Daniel', 'Rodriguez', 'M', 'Driver License', '6677889900', 'daniel.rodriguez@email.com', '890-123-4567', '654 Redwood St', 8, 8),
('Madison', 'Martinez', 'F', 'National ID', '7788990011', 'madison.martinez@email.com', '901-234-5678', '987 Pineapple St', 9, 9),
('Christopher', 'Hernandez', 'M', 'Passport', '8899001122', 'christopher.hernandez@email.com', '012-345-6789', '321 Maplewood St', 10, 10)
;

-- 5. ACCOUNT Table
-- select * from account;
INSERT INTO ACCOUNT (account_type, balance, customer_id)
VALUES
('checking', 1000.00, 1),
('savings', 5000.00, 2),
('checking', 1500.00, 3),
('loan', 10000.00, 4),
('savings', 3000.00, 5),
('checking', 2000.00, 6),
('current', 800.00, 7),
('loan', 12000.00, 8),
('savings', 15000.00, 9),
('checking', 2500.00, 10)
;


-- 6. CARD Table
-- select * from CARD;

INSERT INTO CARD (card_number, card_type, expiration_date, max_credit_limit, available_credit_limit, account_id)
VALUES
('1234567890123456', 'debit', '2026-12-31', 5000.00, 2000.00, 1),
('2345678901234567', 'credit', '2027-05-15', 10000.00, 8000.00, 2),
('3456789012345678', 'debit', '2025-10-01', 3000.00, 1500.00, 3),
('4567890123456789', 'credit', '2027-11-20', 15000.00, 10000.00, 4),
('5678901234567890', 'debit', '2026-07-10', 4000.00, 2500.00, 5),
('6789012345678901', 'credit', '2028-03-30', 20000.00, 18000.00, 6),
('7890123456789012', 'debit', '2024-08-25', 5000.00, 3000.00, 7),
('8901234567890123', 'credit', '2027-02-05', 8000.00, 5000.00, 8),
('9012345678901234', 'debit', '2025-04-22', 6000.00, 3500.00, 9),
('0123456789012345', 'credit', '2026-09-14', 12000.00, 7000.00, 10)
;

-- 7. TRANSACTION Table
-- select * from TRANSACTION;

INSERT INTO TRANSACTION (transaction_date, amount, transaction_type, payment_mode, account_id, transaction_status, description)
VALUES
('2024-01-01', 100.00, 'debit', 'ATM', 1, 'completed', 'ATM withdrawal'),
('2024-01-02', 500.00, 'credit', 'fund transfer', 2, 'completed', 'Transfer from account'),
('2024-01-03', 150.00, 'debit', 'debit card', 3, 'completed', 'Purchase at store'),
('2024-01-04', 1000.00, 'credit', 'loan payment', 4, 'completed', 'Loan repayment'),
('2024-01-05', 300.00, 'debit', 'ATM', 5, 'completed', 'ATM withdrawal'),
('2024-01-06', 700.00, 'credit', 'cash deposit', 6, 'completed', 'Cash deposit'),
('2024-01-07', 200.00, 'debit', 'fund transfer', 7, 'completed', 'Payment to vendor'),
('2024-01-08', 1500.00, 'credit', 'fees', 8, 'completed', 'Service fees'),
('2024-01-09', 400.00, 'debit', 'debit card', 9, 'completed', 'Online purchase'),
('2024-01-10', 250.00, 'credit', 'loan payment', 10, 'completed', 'Loan repayment')
;

-- 8. ACCOUNT_HISTORY Table
-- select * from ACCOUNT_HISTORY;

INSERT INTO ACCOUNT_HISTORY (account_id, balance_before, balance_after, transaction_id)
VALUES
(1, 1000.00, 900.00, 1),
(2, 5000.00, 4500.00, 2),
(3, 1500.00, 1350.00, 3),
(4, 10000.00, 9000.00, 4),
(5, 3000.00, 2700.00, 5),
(6, 2000.00, 1700.00, 6),
(7, 800.00, 600.00, 7),
(8, 12000.00, 10500.00, 8),
(9, 15000.00, 14600.00, 9),
(10, 2500.00, 2250.00, 10)
;

-- 9. LOAN Table
-- select * from LOAN;
-- select * from employee;

INSERT INTO LOAN (
    loan_amount, number_of_monthly_instalments, interest_rate, loan_start_date, 
    loan_end_date, account_id, created_employee_id
)
VALUES 
    (10000.00, 12, 5.00, '2024-01-01', DATE_ADD('2024-01-01', INTERVAL 12 MONTH), 1, 1),
    (12000.00, 18, 4.00, '2024-02-01', DATE_ADD('2024-02-01', INTERVAL 18 MONTH), 2, 2),
    (15000.00, 24, 6.00, '2024-03-01', DATE_ADD('2024-03-01', INTERVAL 24 MONTH), 3, 3),
    (20000.00, 30, 7.00, '2024-04-01', DATE_ADD('2024-04-01', INTERVAL 30 MONTH), 4, 4),
    (18000.00, 36, 5.50, '2024-05-01', DATE_ADD('2024-05-01', INTERVAL 36 MONTH), 5, 5),
    (22000.00, 12, 5.75, '2024-06-01', DATE_ADD('2024-06-01', INTERVAL 12 MONTH), 6, 6),
    (25000.00, 24, 6.25, '2024-07-01', DATE_ADD('2024-07-01', INTERVAL 24 MONTH), 7, 7),
    (30000.00, 48, 7.50, '2024-08-01', DATE_ADD('2024-08-01', INTERVAL 48 MONTH), 8, 8),
    (35000.00, 36, 8.00, '2024-09-01', DATE_ADD('2024-09-01', INTERVAL 36 MONTH), 9, 9),
    (40000.00, 24, 7.25, '2024-10-01', DATE_ADD('2024-10-01', INTERVAL 24 MONTH), 10, 10)
;



-- 10. LOAN_INSTALMENTS Table
-- select * from LOAN_INSTALMENTS;

INSERT INTO LOAN_INSTALMENTS (loan_id, instalment_amount, due_date)
VALUES
(1, 850.00, '2024-02-01'),
(2, 800.00, '2024-03-01'),
(3, 625.00, '2024-04-01'),
(4, 700.00, '2024-05-01'),
(5, 500.00, '2024-06-01'),
(6, 900.00, '2024-07-01'),
(7, 700.00, '2024-08-01'),
(8, 750.00, '2024-09-01'),
(9, 875.00, '2024-10-01'),
(10, 950.00, '2024-11-01')
;

--  Question 11: LOAN_PAYMENT Table
-- select * from loan_payment (select * from loan_instalments , select * from transaction )
insert into loan_payment(instalment_id, transaction_id)
values(1,1),
		(2,2),
		(3,3),
		(4,4),
		(5,5),
		(6,6),
		(7,7),
		(8,8),
		(9,9),
		(10,10)
;

--  Question 12: Create the BENEFICIARY Table with Constraints
-- select * from BENEFICIARY;
insert into BENEFICIARY(primary_consumer_id, beneficiary_bank, beneficiary_name, beneficiary_account_number, beneficiary_swift, 
beneficiary_iban, nick_name)
VALUES 
    (1, 'Bank of America', 'John Doe', '1234567890', 'BOFAUS3NXXX', 'US64BOFA1234567890123456', 'John Savings'),
    (2, 'Chase Bank', 'Alice Smith', '0987654321', 'CHASUS33XXX', 'US12CHAS9876543210987654', 'Alice Checking'),
    (3, 'Wells Fargo', 'Michael Johnson', '1122334455', 'WFBIUS6SXXX', 'US98WFBI1122334455667788', 'Mike WF'),
    (4, 'Citibank', 'Emma Brown', '5566778899', 'CITIUS33XXX', 'US34CITI5566778899001122', 'Emma Citi'),
    (5, 'HSBC', 'David White', '6677889900', 'HSBCUS33XXX', 'US78HSBC6677889900112233', 'David HSBC'),
    (6, 'PNC Bank', 'Sophia Martinez', '7788990011', 'PNCCUS33XXX', 'US23PNCC7788990011223344', 'Sophia PNC'),
    (7, 'TD Bank', 'James Wilson', '8899001122', 'TDBKUS33XXX', 'US45TDBK8899001122334455', 'James TD'),
    (8, 'Capital One', 'Olivia Garcia', '9900112233', 'CAPOUS33XXX', 'US56CAPO9900112233445566', 'Olivia CapOne'),
    (9, 'US Bank', 'Benjamin Lee', '0011223344', 'USBKUS44XXX', 'US67USBK0011223344556677', 'Ben US Bank'),
    (10, 'Santander Bank', 'Charlotte Adams', '1122334466', 'SVRSUS33XXX', 'US78SVRS1122334466557788', 'Charlotte Sant')
;	

--  Question 13: FUND_TRANSFER Table with Constraints
-- select * from fund_transfer;
insert into fund_transfer(beneficiary_id, transaction_id, refund_transaction_id, transfer_status)
VALUES 
    (1, 1, NULL, 'completed'),
    (2, 2, 2, 'processing'),
    (3, 3, 2, 'failed'),
    (4, 4, NULL, 'completed'),
    (5, 5, 5, 'failed'),
    (6, 6, NULL, 'completed'),
    (7, 7, 7, 'processing'),
    (8, 8,8, 'failed'),
    (9, 9, NULL, 'completed'),
    (10, 10, NULL, 'processing')
;

--  Question 14: Create the CUSTOMER_LOGIN Table
-- select * from CUSTOMER_LOGIN;
insert into CUSTOMER_LOGIN(customer_id, login_id, password, active_flag)
VALUES 
    (1, 'user1', 'password123', true),
    (2, 'user2', 'securePass456', false),
    (3, 'user3', 'hashPwd789', false),
    (4, 'user4', 'randomKey321', true),
    (5, 'user5', 'pass987word', false),
    (6, 'user6', 'encryptPass555', true),
    (7, 'user7', 'mySecurePwd999', true),
    (8, 'user8', 'strongPass888', false),
    (9, 'user9', 'pass432secure', true),
    (10, 'user10', 'safeWord123', false)
;

--  Question 15: Create the AUDIT_LOG Table
-- select * from AUDIT_LOG;
insert into AUDIT_LOG(action, employee_id)
VALUES 
    ('User Login', 1),
    ('Updated Profile', 2),
    ('Deleted Record', 3),
    ('Added New User', 4),
    ('Password Change', 5),
    ('Updated Settings', 6),
    ('Accessed Reports', 7),
    ('Exported Data', 8),
    ('Modified Permissions', 9),
    ('User Logout', 10)
;