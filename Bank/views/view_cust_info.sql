-- View for Customer Information
-- Create a db view that retrieves the first_name, last_name, email,
--  and phone_number of all customers along with their corresponding city names.

create view view_cust_info as 
select 
	first_name
    ,last_name
    ,email
    ,phone_number
    ,city_name
from customer
inner join city using(city_id);