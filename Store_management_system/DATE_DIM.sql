-- 1) Create table
CREATE TABLE IF NOT EXISTS DATE_DIM (
    date_id INT PRIMARY KEY,             -- YYYYMMDD
    calendar_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day_of_the_month INT NOT NULL,
    week_day_number INT NOT NULL,        -- ISO-style: 1=Mon ... 7=Sun
    week_day_name VARCHAR(10) NOT NULL,
    yearly_week_number INT NOT NULL,     -- ISO week number (1..53)
    month_start_date_flag BOOLEAN NOT NULL,
    month_end_date_flag BOOLEAN NOT NULL,
    year_start_date_flag  BOOLEAN NOT NULL,
    year_end_date_flag    BOOLEAN NOT NULL,
    holiday_flag BOOLEAN NOT NULL DEFAULT FALSE
);

-- (Optional) ensure recursion depth is large enough (default is 1000)
-- SET SESSION cte_max_recursion_depth = 10000;

-- 2) Build the date series into a temp table
DROP TEMPORARY TABLE IF EXISTS tmp_dates;

CREATE TEMPORARY TABLE tmp_dates (
  calendar_date DATE PRIMARY KEY
) ENGINE=Memory
AS
WITH RECURSIVE DateSeries AS (
  SELECT CURDATE() AS calendar_date
  UNION ALL
  SELECT DATE_ADD(calendar_date, INTERVAL 1 DAY)
  FROM DateSeries
  WHERE calendar_date < DATE_ADD(CURDATE(), INTERVAL 2 YEAR) - INTERVAL 1 DAY
)
SELECT calendar_date FROM DateSeries;

-- 3) Insert into DATE_DIM from the temp table
INSERT INTO DATE_DIM (
    date_id, calendar_date, year, month, day_of_the_month,
    week_day_number, week_day_name, yearly_week_number,
    month_start_date_flag, month_end_date_flag,
    year_start_date_flag, year_end_date_flag
)
SELECT
    CAST(DATE_FORMAT(d.calendar_date, '%Y%m%d') AS UNSIGNED)              AS date_id,
    d.calendar_date,
    YEAR(d.calendar_date)                                                 AS year,
    MONTH(d.calendar_date)                                                AS month,
    DAY(d.calendar_date)                                                  AS day_of_the_month,
    WEEKDAY(d.calendar_date) + 1                                          AS week_day_number,   -- 0..6 Mon..Sun => +1 => 1..7
    DAYNAME(d.calendar_date)                                              AS week_day_name,
    WEEK(d.calendar_date, 3)                                              AS yearly_week_number, -- ISO week
    (DAY(d.calendar_date) = 1)                                            AS month_start_date_flag,
    (d.calendar_date = LAST_DAY(d.calendar_date))                         AS month_end_date_flag,
    (MONTH(d.calendar_date) = 1  AND DAY(d.calendar_date) = 1)            AS year_start_date_flag,
    (MONTH(d.calendar_date) = 12 AND DAY(d.calendar_date) = 31)           AS year_end_date_flag
FROM tmp_dates d
-- Avoid duplicate inserts if you rerun:
ON DUPLICATE KEY UPDATE date_id = VALUES(date_id);

-- 4) Clean up
DROP TEMPORARY TABLE IF EXISTS tmp_dates;
