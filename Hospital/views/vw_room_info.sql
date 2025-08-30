-- View for Room Information
-- Create a view to display room details including room id, room name, daily rate and room type.

create view vw_room_info AS
select room_id, room_number, daily_rate, room_type
from room
;

-- select * from vw_room_info;