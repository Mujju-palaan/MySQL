--View Tasks:
-- 1) View for Store Details
--Create a view to display store details.

create view view_store_details as
	select store_name, location, b.city_name, b.country_name, a.phone_number, a.quantity_in_stock
	from store a
	inner join city b using(city_id);

--select * from view_store_details;