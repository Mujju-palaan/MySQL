-- Function to Calculate Total Bill per Patient
-- Write a function to calculate the total amount billed to a patient based on the treatments and services provided.
DELIMITER $$
create function fun1_cal_total_bill(p_patient_id int)
returns decimal(10,2)
deterministic
BEGIN 
	declare total_amount_per_patient decimal(10,2);
	--
    select sum(a.total_amount)
    into total_amount_per_patient
    from billing a
    inner join appointment b using(admission_id)
    where patient_id = p_patient_id
    ;
    return total_amount_per_patient;

END $$
DELIMITER ;

-- select fun1_cal_total_bill(2);