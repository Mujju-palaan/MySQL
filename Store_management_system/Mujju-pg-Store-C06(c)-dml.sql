--select * from DATE_DIM_SAMPLE;

CREATE TABLE DATE_DIM_SAMPLE (
    date_id INT PRIMARY KEY, -- Format: YYYYMM
    calendar_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day_of_the_month INT NOT NULL,
    week_day_number INT NOT NULL,
    week_day_name VARCHAR(10) NOT NULL,
    yearly_week_number INT NOT NULL,
    month_start_date_flag BOOLEAN NOT NULL,
    month_end_date_flag BOOLEAN NOT NULL,
    year_start_date_flag BOOLEAN NOT NULL,
    year_end_date_flag BOOLEAN NOT NULL,
    holiday_flag BOOLEAN NOT NULL DEFAULT FALSE
);

 WITH RECURSIVE DateSeries AS (
    SELECT CURRENT_DATE AS calendar_date 
    UNION ALL
    SELECT  (calendar_date + INTERVAL '1 day')::DATE
    FROM Dateseries
    WHERE calendar_date < (CURRENT_DATE + INTERVAL '2 years' - INTERVAL '1 day') 
)
INSERT INTO DATE_DIM_SAMPLE ( date_id, calendar_date,  year, month, day_of_the_month,  week_day_number, week_day_name,
 yearly_week_number,  month_start_date_flag, month_end_date_flag, year_start_date_flag, year_end_date_flag
)
SELECT 
    TO_CHAR(calendar_date, 'YYYYMMDD')::INTEGER AS date_id, 
    calendar_date,
    EXTRACT(YEAR FROM calendar_date)::INTEGER AS year,
    EXTRACT(MONTH FROM calendar_date)::INTEGER AS month,           
    EXTRACT(DAY FROM calendar_date)::INTEGER AS day_of_the_month,
    EXTRACT(ISODOW FROM calendar_date)::INTEGER AS week_day_number, 
    TRIM(TO_CHAR(calendar_date, 'Day')) AS week_day_name, 
    EXTRACT(WEEK FROM calendar_date)::INTEGER AS yearly_week_number, 
    CASE 
       WHEN EXTRACT(DAY FROM calendar_date) = 1 
       THEN TRUE 
       ELSE FALSE 
      END AS month_start_date_flag,
    CASE 
        WHEN calendar_date = (DATE_TRUNC('month', calendar_date) + INTERVAL '1 month - 1 day')::DATE 
        THEN TRUE 
        ELSE FALSE 
      END AS month_end_date_flag,
    CASE WHEN calendar_date = DATE_TRUNC('year', calendar_date) THEN TRUE
        ELSE FALSE 
      END AS year_start_date_flag,
    CASE 
        WHEN calendar_date = (DATE_TRUNC('year', calendar_date) + INTERVAL '1 year - 1 day')::DATE 
        THEN TRUE 
        ELSE FALSE 
     END AS year_end_date_flag
FROM DateSeries;