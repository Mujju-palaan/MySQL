-- 3)Stored Procedure for Product Management
-- Create a stored procedure to update product information for the Product Management screen.
	
create or replace procedure scrop_dml_update_product(
	IN iparam_product_id int,
	IN iparam_product_price numeric(10,2)
)
language plpgsql
AS $$

BEGIN
	update product set price = iparam_product_price
	where product_id = iparam_product_id;

END;
$$;

--call scrop_dml_update_product(17,6.99);

--select * from product;