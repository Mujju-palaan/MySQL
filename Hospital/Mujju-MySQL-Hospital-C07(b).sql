1. Patient Overview
Metrics:
Total number of patients.
List of patients with date of birth and email.
Number of appointments per patient.


SQL Queries:
Count total patients.
Retrieve patient names, date of birth, and email.
Retrieve the number of appointments per patient (join PATIENT and APPOINTMENT).


2. Doctor Overview
Metrics:
Total number of doctors.
Doctors by specialization.
Doctor assignments (how many departments per doctor).


SQL Queries:

Count total doctors.
Retrieve doctors grouped by specialization.
List doctor assignments per department (join DOCTOR, DOCTOR_DEPARTMENT, and DEPARTMENT).


3. Appointment Overview
Metrics:
Total appointments per doctor.
Recent appointments (within the last 3 months).
Appointments by status (Scheduled, Completed, Cancelled).


SQL Queries:

Count total appointments per doctor.
Retrieve recent appointments.
Retrieve appointments grouped by status.


4. Room Overview
Metrics:
Room availability (by room type: General, ICU, Private).
Rooms by department.
Total number of rooms.


SQL Queries:

Count total rooms grouped by room type.
Retrieve rooms grouped by department (join ROOM and DEPARTMENT).
Count total rooms available in the system.


5. Treatment Overview
Metrics:
Treatments by doctor.
Patients receiving treatments (linked to doctors).
Recent treatments (conducted within the last year).


SQL Queries:

Retrieve treatments performed by each doctor (join TREATMENT, DOCTOR, and PATIENT).
Retrieve treatments linked to patients and doctors.
Retrieve treatments conducted in the last year.


6. Audit Log Overview
Metrics:
List of recent system changes.
Changes made by doctors.
Number of logs per day.


SQL Queries:

Retrieve recent actions from the AUDIT_LOG table.
Retrieve actions performed by doctors (join AUDIT_LOG with DOCTOR).
Count the number of audit logs per day.


Key Visuals and Corresponding SQL Queries:
Note: All dashboard queries must work against current month or current year filters

Bar Chart - Patient Admits
SQL Query: Retrieve admit counts grouped by month.
X-Axis: Month.
Y-Axis: Number of patient admits.


Pie Chart - Doctors by Specialization
SQL Query: Retrieve doctors grouped by their specialization.
Pie Sections: Number of doctors per specialization.


Line Graph - Doctor Visits by Month
SQL Query: Retrieve doctor appointments conducted per month.
X-Axis: Treatment date grouped by month.
Y-Axis: Number of appointments.


Table - Occupancy Summary
SQL Query: Retrieve patient names and room admit dates.
Columns: Calendar Date, Room Name, Patient Name.
Note: Retrieve data for a specified month across all rooms, including rooms without any patients.


Gauge - In Patient VS Out Patient
SQL Query: Count the total number of in patient and out patient admits.
Display: Total patient count.