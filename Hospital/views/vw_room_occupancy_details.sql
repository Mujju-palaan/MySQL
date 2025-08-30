-- View for Monthly Room Occupancy Details
-- Write a view that lists each room occupancy on daily basis with details such as 
-- calendar date, patient name, incharge nurse, and daily billing rate. 
-- If a room is unoccupied on a given date, display the room ID without any associated patient information. 
-- You need to JOIN date dim table with room admit table. LEFT JOIN plays crucial role in this solution.

create view vw_room_occupancy_details AS
select 
	a.calendar_date
    ,concat(e.first_name,' ', e.last_name) as patient_name
    ,b.incharge_nurse_id
    ,concat(c.first_name,' ', c.last_name) as nurse_name
    ,d.daily_rate
    ,case 
		when d.room_number is null
        THEN 'unoccupied'
        else 'occupied'
	END as Room_number
    from date_dim a
    left join room_admit b ON calendar_date between start_date AND end_date
    left join nurse c ON b.incharge_nurse_id = c.nurse_id
    left join room d using(room_id)
    left join appointment aa using(admission_id)
    left join patient e using(patient_id)
    ; 
    
-- select * from vw_room_occupancy_details;