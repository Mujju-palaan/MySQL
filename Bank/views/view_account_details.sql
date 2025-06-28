-- View for Account Details
-- Create a database view that displays account details, customer_id, first_name, 
-- last_name, account_id, account_type, and balance. Include the city name and 
-- country name using appropriate joins.

create view view_account_details AS
select 
	customer_id
    ,first_name
    ,last_name
    ,account_id
    ,account_type
    ,balance
    ,city_name
    ,country_name
from account
inner join customer using(customer_id)
inner join city using(city_id);