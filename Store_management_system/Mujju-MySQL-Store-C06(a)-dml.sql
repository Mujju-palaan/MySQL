-- Store DML(Data Manipulation Language) ASSIGNMENT
-- Mujju-postgres-Store-Chapter06-dml
-- -- use Store_management_system;

-- Question 1: Insert Data into all Tables
-- Write SQL queries to populate each table created in the Chapter 5 assignment with at least 10 rows of data.
insert into city(country_name,city_name)
values ('USA','New York'),
		('India','Hyderabad'),
		('India','Delhi'),
		('India','Mumbai'),
		('India','Banglore'),
		('UAE','Dubai'),
		('CAN','Toronto'),
		('AUS','Sydney'),
		('Poland','Warsaw'),
		('Pakistan','lahore');
-- select * from city

-- select * from store
insert into store(store_name,location,phone_number,city_id)
values ('Croma','kukatpally','12345678901',1),
		('Concu','Sainikpuri','12345678902',2),
		('Shadab','Charminar','12345678903',3),
		('Khurana','Begumpet','12345678904',4),
		('Park Hayat','Banjar Hills','12344567890',5),
		('Big Bazar','Abids','12345678905',6),
		('Zudio','IDPL','12345678906',7),
		('Reliance','Kompally','12345678907',8),
		('jio Mart','Kompally','12345678908',9),
		('Wall Mart','Kompally','12345678909',10)
;

-- alter table store add column quantity_in_stock int;

-- UPDATE store
-- SET quantity_in_stock = CASE store_id
-- WHEN 1 THEN 111
-- WHEN 2 THEN 222
-- WHEN 3 THEN 333
-- WHEN 4 THEN 444
-- WHEN 5 THEN 555
-- WHEN 6 THEN 666
-- WHEN 7 THEN 777
-- WHEN 8 THEN 888
-- WHEN 9 THEN 999
-- WHEN 10 THEN 1011
-- WHEN 11 THEN 1111
-- ELSE quantity_in_stock
-- END
-- WHERE store_id IN(1,2,3,4,5,6,7,8,9,10,11)
-- ;
-- alter table store drop column quantity_in_stock;

-- select * from product;
INSERT INTO product(product_name, category, price , description, sku)
values
	('Coca-Cola', 'drinks', 1.49, 'A classic cola soft drink.', 'DRINK-COCA-001'),
    ('Pepsi', 'drinks', 1.49, 'Refreshing cola beverage.', 'DRINK-PEPSI-002'),
    ('Orange Juice', 'drinks', 2.99, 'Freshly squeezed orange juice.', 'DRINK-OJ-003'),
    ('Lemonade', 'drinks', 2.49, 'Refreshing lemon drink.', 'DRINK-LEMON-004'),
    ('Green Tea', 'drinks', 1.99, 'Healthy antioxidant-rich tea.', 'DRINK-GT-005'),
	('Potato Chips', 'snacks', 1.99, 'Crispy salted chips.', 'SNACK-CHIPS-001'),
    ('Popcorn', 'snacks', 2.49, 'Buttery movie-style popcorn.', 'SNACK-POPCORN-002'),
    ('Pretzels', 'snacks', 1.79, 'Crunchy salted pretzels.', 'SNACK-PRETZELS-003'),
    ('Chocolate Bar', 'snacks', 1.49, 'Rich milk chocolate.', 'SNACK-CHOC-004'),
    ('Trail Mix', 'snacks', 3.99, 'Nut and dried fruit mix.', 'SNACK-TRAIL-005'),
	 ('Apple', 'fruits', 0.99, 'Crisp and sweet red apple.', 'FRUIT-APPLE-001'),
    ('Banana', 'fruits', 0.79, 'Fresh and ripe banana.', 'FRUIT-BANANA-002'),
    ('Orange', 'fruits', 0.89, 'Juicy and tangy orange.', 'FRUIT-ORANGE-003'),
    ('Grapes', 'fruits', 2.49, 'Seedless green grapes.', 'FRUIT-GRAPES-004'),
    ('Pineapple', 'fruits', 3.99, 'Tropical and tangy pineapple.', 'FRUIT-PINEAPPLE-005')
;

-- select * from supplier;
insert into supplier(supplier_name, contact_number)
values ('Global Supplies Co.', '123-456-7890'),
    ('Fresh Produce Inc.', '234-567-8901'),
    ('Tech Parts Ltd.', '345-678-9012'),
    ('Eco Goods Supplies', '456-789-0123'),
    ('Urban Essentials', '567-890-1234'),
    ('Greenfield Supplies', '678-901-2345'),
    ('QuickFix Distributors', '789-012-3456'),
    ('Summit Industrial Supply', '890-123-4567'),
    ('Apex Wholesale', '901-234-5678'),
    ('BrightPath Logistics', '012-345-6789')
;

-- select * from SUPPLIER_PRODUCT;
insert into SUPPLIER_PRODUCT(supplier_id, product_id)
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

-- select * from inventory;
insert into inventory(store_id, product_id, quantity_in_stock, supplier_id)
values(1,1,123444,1),
		(2,2,123,2),
		(3,3,3444,3),
		(4,4,44444,4),
		(5,5,5555,5),
		(6,6,66666,6),
		(7,7,77777,7),
		(8,8,8888,8),
		(9,9,9999,9),
		(10,10,123444,10)
;

-- select * from customer;
insert into customer(first_name,last_name,gender,id_type,id_number,email,phone_number,address,city_id)
values('Alice', 'Walker', 'F', 'passport', 'P123456789', 'alice.walker@example.com', '123-456-7890', '45 Maple Lane', 1),
    ('Bob', 'Johnson', 'M', 'driving license', 'DL987654321', 'bob.johnson@example.com', '234-567-8901', '12 Pine Avenue', 2),
    ('Clara', 'Smith', 'F', 'passport', 'P987654321', 'clara.smith@example.com', '345-678-9012', '78 Oak Drive', 3),
    ('David', 'Brown', 'M', 'driving license', 'DL123456789', 'david.brown@example.com', '456-789-0123', '56 Birch Street', 4),
    ('Emma', 'Taylor', 'F', 'passport', 'P112233445', 'emma.taylor@example.com', '567-890-1234', '34 Elm Road', 5),
    ('Frank', 'Williams', 'M', 'driving license', 'DL556677889', 'frank.williams@example.com', '678-901-2345', '90 Cedar Lane', 1),
    ('Grace', 'Martinez', 'F', 'passport', 'P223344556', 'grace.martinez@example.com', '789-012-3456', '12 Spruce Avenue', 2),
    ('Henry', 'Davis', 'M', 'driving license', 'DL667788990', 'henry.davis@example.com', '890-123-4567', '23 Redwood Street', 3),
    ('Isabella', 'Clark', 'F', 'passport', 'P334455667', 'isabella.clark@example.com', '901-234-5678', '78 Willow Lane', 4),
    ('Jack', 'Lee', 'M', 'driving license', 'DL778899001', 'jack.lee@example.com', '012-345-6789', '45 Redwood Avenue', 5)
;

-- select * from orders;
-- check (order_status in ('Accepted','Packing','Ready for Delivery','Shipping','Delivered','Paid','Closed'))
insert into orders(order_date, total_amount, delivered_duration, customer_id, store_id, order_status)
values ('2025-01-15', 150.75, '2025-01-15 02:00:00', 1, 1, 'Accepted'),
    ('2025-02-20', 85.50, '2025-02-20 03:30:00', 2, 2, 'Packing'),
    ('2025-03-10', 230.00, '2025-03-10 01:15:00', 3, 3, 'Delivered'),
    ('2025-04-05', 120.99, '2025-04-05 12:15:00', 4, 4, 'Ready for Delivery'),
    ('2025-05-25', 95.00, '2025-05-25 04:45:00', 5, 5, 'Delivered'),
    ('2025-06-12', 310.40, '2025-06-12 02:20:00', 6, 1, 'Shipping'),
    ('2025-07-07', 50.00, '2025-07-07 14:45:00', 7, 2, 'Paid'),
    ('2025-08-18', 200.00, '2025-08-18 05:50:00', 8, 3, 'Closed'),
    ('2025-09-22', 175.00, '2025-09-22 03:10:00', 9, 4, 'Delivered'),
    ('2025-10-30', 65.99, '2025-10-30 13:13:00', 10, 5, 'Accepted')
;


-- select * from order_product;
insert into order_product(order_id, product_id, units, unit_rate, total_amount)
values (1, 1, 3, 50.00, 150.00),
    (1, 2, 2, 75.00, 150.00),
    (2, 3, 5, 20.00, 100.00),
    (2, 4, 4, 30.00, 120.00),
    (3, 5, 2, 115.00, 230.00),
    (4, 6, 1, 120.99, 120.99),
    (5, 7, 3, 31.67, 95.00),
    (6, 8, 4, 77.60, 310.40),
    (7, 9, 2, 25.00, 50.00),
    (8, 10, 8, 25.00, 200.00)
;

-- select * from payment
insert into payment(payment_date, amount_paid, order_id)
values ('2025-01-16', 150.00, 1),
    ('2025-02-21', 100.00, 2),
    ('2025-03-11', 230.00, 3),
    ('2025-04-06', 120.99, 4),
    ('2025-05-26', 95.00, 5),
    ('2025-06-13', 310.40, 6),
    ('2025-07-08', 50.00, 7),
    ('2025-08-19', 200.00, 8),
    ('2025-09-23', 175.00, 9),
    ('2025-10-31', 65.99, 10)
;

-- select * from employee;
insert into employee(first_name, last_name, email, hire_date, salary, store_id, phone_number)
values ('John', 'Doe', 'john.doe@example.com', '2025-01-10', 55000.00, 1, '123-456-7890'),
    ('Jane', 'Smith', 'jane.smith@example.com', '2024-11-15', 48000.00, 2, '234-567-8901'),
    ('Emily', 'Johnson', 'emily.johnson@example.com', '2023-08-20', 60000.00, 3, '345-678-9012'),
    ('Michael', 'Brown', 'michael.brown@example.com', '2025-02-05', 47000.00, 4, '456-789-0123'),
    ('Sarah', 'Williams', 'sarah.williams@example.com', '2024-07-30', 52000.00, 5, '567-890-1234'),
    ('David', 'Jones', 'david.jones@example.com', '2025-03-12', 53000.00, 1, '678-901-2345'),
    ('Olivia', 'Miller', 'olivia.miller@example.com', '2024-09-10', 46000.00, 2, '789-012-3456'),
    ('James', 'Davis', 'james.davis@example.com', '2025-01-25', 56000.00, 3, '890-123-4567'),
    ('Sophia', 'Garcia', 'sophia.garcia@example.com', '2024-12-15', 54000.00, 4, '901-234-5678'),
    ('William', 'Martinez', 'william.martinez@example.com', '2025-02-28', 58000.00, 5, '012-345-6789')
;

-- select * from employee_login;
insert into employee_login(employee_id, login_id, password, active_flag)
values  (1, 'john.doe123', 'encrypted_password_1', 1),
    (2, 'jane_smith@company.com', 'encrypted_password_2', 1),
    (3, 'emily.johnson@example.com', 'encrypted_password_3', 1),
    (4, 'michael_brown45', 'encrypted_password_4', 0),
    (5, 'sarah_williams2024', 'encrypted_password_5', 1),
    (6, 'david.jones1', 'encrypted_password_6', 1),
    (7, 'olivia.miller@company.com', 'encrypted_password_7', 1),
    (8, 'james_davis89', 'encrypted_password_8', 1),
    (9, 'sophia.garcia@domain.com', 'encrypted_password_9', 0),
    (10, 'william_martinez22', 'encrypted_password_10', 1)
;

-- select * from discount
insert into discount(discount_code, discount_percentage)
values ('DISC10', 10),
    ('SUMMER15', 15),
    ('WINTER20', 20),
    ('HOLIDAY5', 15.35),
    ('NEWYEAR25', 25),
    ('EASTER30', 30),
    ('VIP40', 40),
    ('CLEARANCE50', 50),
    ('BACKTOSCHOOL12', 12),
    ('FLASHSALE7', 7.50)
;

-- select * from audit_log;
insert into audit_log(log_date, action, employee_id)
values  ('2025-01-15', 'Logged in', 1),
    ('2025-01-16', 'Updated product details', 2),
    ('2025-01-17', 'Processed payment', 3),
    ('2025-01-18', 'Created a new order', 4),
    ('2025-01-19', 'Modified customer information', 5),
    ('2025-01-20', 'Logged out', 6),
    ('2025-01-21', 'Added new discount code', 7),
    ('2025-01-22', 'Changed order status to shipped', 8),
    ('2025-01-23', 'Deleted product from inventory', 9),
    ('2025-01-24', 'Updated employee details', 10);

-- select * from return_policy;

-- select * from order_discount;
insert into order_discount(order_id, discount_id)
values (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10)
;
