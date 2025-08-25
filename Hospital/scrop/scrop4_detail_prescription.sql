-- Stored Procedure for Prescription Management
-- Create a stored procedure to display detailed prescription information. 
-- If a medicine is prescribed for 3 days, generate rows for each day, 
-- and if it is prescribed 3 times a day for 3 days, display 9 rows. 
-- Utilize a dim_date table with a JOIN and apply the temporary table technique to represent the morning, 
-- afternoon, and evening dosages.

DELIMITER $$
create procedure scrop4_detail_prescription(
	IN p_prescription_id int
)
BEGIN
	-- temp tbl
     -- Temporary table to hold dosage times
    CREATE TEMPORARY TABLE IF NOT EXISTS dosage_times (
        dosage_time VARCHAR(20)
    );
    
    -- Insert standard dosage times (select * from dosage_times) 
    INSERT INTO dosage_times (dosage_time)
    VALUES ('Morning'), ('Afternoon'), ('Evening');
    
    -- select * from prescription
    select 
		b.prescription_id
        ,a.medication_name
        ,datediff(b.start_date,b.end_date) 
        ,c.calendar_date
        ,d.dosage_time
	from medication a
    inner join prescription b using(medication_id)
	join date_dim c on c.calendar_date between b.start_date AND b.end_date
    join dosage_times d
    where b.prescription_id = p_prescription_id
    ;
    
END $$
DELIMITER ;

-- call scrop4_detail_prescription(1);