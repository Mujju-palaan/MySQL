-- 3)Stored Procedure for Product Management
-- Create a stored procedure to update product information for the Product Management screen.
	
DELIMITER $$
create procedure scrop3_product_management(
	IN p_product_id int
    ,IN p_description varchar(50)
)
BEGIN
	-- select * from product;
    update product
    set description = p_description
    where product_id = p_product_id
    ;

END $$
DELIMITER ;

-- call scrop3_product_management(1, 'Harmful Drink');