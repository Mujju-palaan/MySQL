-- 4)Stored Procedure for Order Management
-- Write a stored procedure to create a new order. This procedure should insert data into 
-- the ORDER and ORDER_PRODUCT tables while updating the INVENTORY table to deduct the available stock accordingly.

-- drop procedure if exists scrop_insert_order_orderProduct_update_inventoryStock;

create or replace procedure scrop_insert_order_orderProduct_update_inventoryStock(
	IN iparam_order_date date,
	IN iparam_total_amount numeric,  -----iparam_units*iparam_unit_rate
	IN iparam_delivered_duration time,
	IN iparam_customer_id int,
	IN iparam_store_id int,
	IN iparam_order_status varchar, ---( Delivered,Paid,Shipping,Closed,Ready for Delivery,Accepted,Packing)
	-- IN iparam_order_id int,
	IN iparam_product_id int,	
	IN iparam_units	int,			---kitte units
	IN iparam_unit_rate numeric 	--- price of unit
)
language plpgsql
as $$
DECLARE last_order_id INT;
		available_stock int;
		updated_stock int;

BEGIN
	
	
	---- insert data into orders select * from orders
	insert into orders(order_date, total_amount, delivered_duration, customer_id, store_id, order_status)
	values
	(iparam_order_date, iparam_total_amount, iparam_delivered_duration,
	iparam_customer_id, iparam_store_id, iparam_order_status)
	returning order_id into last_order_id;

	---- Get the auto-increment order_id
    -- SET last_order_id = LAST_INSERT_ID();

	----insert data into order_product
	insert into order_product(order_id, product_id, units, unit_rate, total_amount)
	values
	(last_order_id, iparam_product_id,iparam_units, iparam_unit_rate, iparam_total_amount);
	----last_order_id ye likhee jab se error aara
	
	-----validate
	select quantity_in_stock::int into available_stock
	from INVENTORY
	where product_id = iparam_product_id;
	
	IF available_stock IS NULL THEN
	RAISE EXCEPTION 'Product ID % not found in inventory', iparam_product_id;
	ELSIF available_stock < iparam_units THEN
		RAISE EXCEPTION 'Not enough stock for product ID %. Available: %, Required: %'
		, iparam_product_id, available_stock, iparam_units;
	END IF;
	
	----updating the INVENTORY table to deduct the available stock accordingly.
	select  (quantity_in_stock::int - iparam_units)
	into updated_stock from INVENTORY
	where product_id = iparam_product_id;
	
	update INVENTORY set quantity_in_stock = updated_stock::varchar
	where product_id = iparam_product_id;

END;
$$;

----My problem is inserting without hard coding,
---- 1) How to insert new order_id in order_product which is already present in scrop? (solved)
---- Get the auto-increment order_id
    --SET last_order_id = LAST_order_id();
---- 2)insted of hard coding total_amount, it should automatic calculate (Units*price) ?????

CALL scrop_insert_order_orderproduct_update_inventorystock(
	'2025-03-02',	--<IN iparam_order_date date>,
	500,			--<IN iparam_total_amount  numeric>,
	'16:00:00',		--<IN iparam_delivered_duration  time without time zone>,
	1,				--<IN iparam_customer_id  integer>,
	1,				--<IN iparam_store_id  integer>,
	'Delivered',	--<IN iparam_order_status  character varying>,
	-- 5,				--<IN iparam_order_id  integer>,
	2,				--<IN iparam_product_id  integer>,
	5,				--<IN iparam_units  integer>,
	100				--<IN iparam_unit_rate  numeric>
);

-- select * from orders;
-- select * from order_product;
-- select * from inventory;
