-- 2)Stored Procedure for Customer Management
-- Create a stored procedure to insert customer information for the Customer Management screen.


create or replace procedure scrop_dml_insert_customer(
	In iparam_first_name varchar,
	IN iparam_last_name varchar,
	IN iparam_gender char,
	IN iparam_id_type varchar,
	IN iparam_id_number varchar,
	IN iparam_email varchar,
	IN iparam_phone_number varchar,
	IN iparam_address varchar,
	In iparam_city_id int
)
language plpgsql
AS $$

BEGIN
	--insert customer
	insert into customer(first_name, last_name, gender, id_type, id_number, email, phone_number, address, city_id)
	values(iparam_first_name, iparam_last_name, iparam_gender, iparam_id_type, iparam_id_number, iparam_email,
		iparam_phone_number, iparam_address, iparam_city_id);

END;
$$;

--call scrop_dml_insert_customer('DR','Kefaya','F','passport','Q34554','dr.kef@tansycloud.com','234545645', 'kompally', 1)

--select * from customer;