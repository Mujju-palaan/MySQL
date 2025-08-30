-- Assignment Tasks:
-- Stored Procedure Tasks:
-- use hospital

-- Stored Procedure for Medication Management
-- Write a stored procedure to insert data into MEDICATION table.
-- Done

-- Stored Procedure for Patient Admit Management
-- Write a stored procedure to update data in PATIENT_ADMIT table.
-- Done

-- Stored Procedure for Doctor Management
-- Write a stored procedure to select data from DOCTOR table.
-- Done

-- Stored Procedure for Prescription Management
-- Create a stored procedure to display detailed prescription information. If a medicine is prescribed for 3 days, generate rows for each day, and if it is prescribed 3 times a day for 3 days, display 9 rows. Utilize a dim_date table with a JOIN and apply the temporary table technique to represent the morning, afternoon, and evening dosages.
-- Done

-- Stored Procedure for Billing Information
-- Create a stored procedure to display detailed billing information for a specified patient. The output should include treatment details, patient data, billing data, and payment information. Mark a record as overdue if the total amount remains unpaid for more than 3 days after the bill creation date. If a single bill has multiple payments, present the receipt IDs as a comma-separated list.
-- Done

-- Stored Procedure for New Appointments
-- Create a stored procedure to insert patient appointment details while ensuring that the assigned doctor or room is not double-booked. Additionally, automatically generate a billing record based on the doctor's per-visit fee.
-- Done

-- Stored Procedure for New Room Admits
-- Create a stored procedure to insert room admit details while ensuring that the assigned room is not double-booked. Additionally, automatically generate a billing record based on the room's per-day fee.
-- Done

-- Stored Procedure for Payment Receipts
-- Create a stored procedure to insert payment receipt details and automatically update the associated bill status to indicate whether it is fully paid or partially paid.


-- View Tasks:
-- View for Room Information
-- Create a view to display room details including room id, room name, daily rate and room type.


-- View for Appointment Details
-- Create a view to display appointment details including patient name, doctor name, doctor specialization, appointment date, room name and status.


-- View for Monthly Room Occupancy Details
-- Write a view that lists each room occupancy on daily basis with details such as calendar date, patient name, incharge nurse, and daily billing rate. If a room is unoccupied on a given date, display the room ID without any associated patient information. You need to JOIN date dim table with room admit table. LEFT JOIN plays crucial role in this solution.


-- View for Patient Discharge Billing Information
-- Create a view to display treatment billing information, including treatment description, bill date, bill amount, paid amount, pay receipt id, and balance amount. If multiple payments have been made for a single bill, display the receipt IDs as a comma-separated list. There shall be one record per bill, repeating treatment information is ok.


-- Function Tasks:
-- Function to Calculate Total Bill per Patient
-- Write a function to calculate the total amount billed to a patient based on the treatments and services provided.


-- Function to Calculate Appointment Count per Doctor
-- Write a function that calculates the number of appointments scheduled for a specific doctor.


-- Trigger Task:
-- Trigger on Appointment Status Change
-- Create a trigger on the APPOINTMENT table that logs changes to the status field into the AUDIT_LOG table. Capture the appointment_id, old_status, new_status, log_date, and user_id.