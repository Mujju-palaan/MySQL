--Trigger Task:
--1) Trigger on Order Total Amount Change
--Create a trigger on the ORDER table that logs any changes made to the total_amount field into the AUDIT_LOG table.
--Ensure it captures the order_id, old_total, new_total, and log_date.
--select * from orders;

---cteate tbl
create table AUDIT_ORDER_LOG(
	log_id int GENERATED ALWAYS AS IDENTITY,
	order_id int,
	old_total numeric(10,2),
	new_total numeric(10,2),
	log_date date default current_timestamp
);

---function
create or replace function TRG_FUN_trg_update_total_amount()
returns trigger

as $$
BEGIN
	IF OLD.total_amount is distinct from new.total_amount then
		INSERT INTO AUDIT_ORDER_LOG(order_id, old_total, new_total)
		VALUES (OLD.order_id, OLD.total_amount, NEW.total_amount);
	END IF;
	RETURN NEW;	

END;
$$ language plpgsql;

----create trigger
create trigger trg_update_total_amount
AFTER update on orders
for each row 
WHEN(OLD.total_amount is distinct from new.total_amount)
EXECUTE FUNCTION TRG_FUN_trg_update_total_amount();

-----updating orders tbl
update orders set total_amount = 100
where order_id = 3;
--select * from AUDIT_ORDER_LOG;


--Submission Guidelines:
--Each SQL object (procedure, view, function, trigger) should be in a separate .sql file named after the object.
--Provide a report explaining the purpose of each SQL object and its relationship to the UI elements.


