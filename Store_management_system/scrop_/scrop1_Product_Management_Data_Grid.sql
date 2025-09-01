-- 1)Stored Procedure for Product Management Data Grid
-- Write a stored procedure to retrieve all product details for the Product Management screen,
-- including product_name, price, and quantity_in_stock.

DELIMITER $$
create procedure scrop1_Product_Management_Data_Grid()
BEGIN
	-- select * from Product;
    select 
		product_id
        ,product_name
        ,category
        ,price
        ,sku
        ,quantity_in_stock
	from product
    inner join inventory using(product_id)
    ;
    
END $$
DELIMITER ;

-- call scrop1_Product_Management_Data_Grid();