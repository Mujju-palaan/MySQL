-- Stored Procedure for New Room Admits
-- Create a stored procedure to insert room admit details while ensuring that the assigned room is not double-booked. 
-- Additionally, automatically generate a billing record based on the room's per-day fee.
-- call scrop7_new_room_admit(current_timestamp, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 9 DAY), 1, 1, 1);
-- drop procedure scrop7_new_room_admit;
DELIMITER $$
create procedure scrop7_new_room_admit(
	IN p_start_date datetime
    ,IN p_end_date datetime
    ,IN p_room_id int
    ,IN p_nurse_id int
    ,IN p_admission_id int
)

BEGIN
	declare d_room_count int;
    declare d_admit_id int;
    declare d_room_amount decimal(10,2);
    declare d_daily_rate decimal(10,2);
    declare d_days int;
    declare d_admission_id int;

	-- insert room admit details while ensuring that the assigned room is not double-booked
    select count(*)
    into d_room_count
    from room_admit
    where room_id = p_room_id
		AND (
           (p_start_date BETWEEN start_date AND end_date)
        OR (p_end_date BETWEEN start_date AND end_date)
        OR (p_start_date <= start_date AND p_end_date >= end_date) -- overlapping fully
      );
    
    IF d_room_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Room already booked for this time slot';
    END IF; 
    
    -- select * from room_admit
    insert into room_admit(start_date, end_date, room_id, incharge_nurse_id, admission_id)
    values(p_start_date, p_end_date, p_room_id, p_nurse_id, p_admission_id);
    
    -- set
    set d_admit_id = last_insert_id();
    
    -- select
    select admission_id
--     into d_admission_id
    from room_admit
    where admit_id = d_admit_id
    limit 1
    ;
    
    -- room fee
    select daily_rate
    into d_daily_rate
    from room
    where room_id = p_room_id
    limit 1
    ;
    
    select datediff(end_date, start_date)
    into d_days
    from room_admit
    where room_id = p_room_id
    limit 1
    ;
    
    -- room amount
    set d_room_amount = d_daily_rate * d_days;
    
    -- automatically generate a billing record based on the room's per-day fee
    -- select * from billing;
    insert into billing(bill_date, bill_type, description, total_amount, balance_amount, admission_id)
    values(current_timestamp, 'Room Charge', 'Room Billing', d_room_amount, d_room_amount ,d_admission_id)
    ;
    
END $$
DELIMITER ;

-- call scrop7_new_room_admit(current_timestamp, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 9 DAY), 3, 1, 1);
