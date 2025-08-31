-- 3) View for Inventory Overview
--Write a view to display the available inventory at each store, showing product name, store name, and quantity in stock.
	
create view view_inventory_overview AS	
	select c.product_name, a.store_name, b.quantity_in_stock
	from  store a
	inner join inventory b ON a.store_id=b.store_id
	inner join product c ON b.product_id = c.product_id
	;

--select * from view_inventory_overview;


-- 4) View for Weekend Sales