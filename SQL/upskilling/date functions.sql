SELECT version();
-- date functions 

-- to get current date
SELECT curdate();
SELECT current_time();
SELECT current_timestamp();

-- to increase the timestamp by 1hr 
SELECT DATE_ADD(current_timestamp(), INTERVAL 1 HOUR);

-- to increase the time by 5 hours 
SELECT DATE_ADD(current_time(), INTERVAL 5 HOUR);

-- to increase the date by 1 year 
SELECT date_add(current_date(), INTERVAL 1 YEAR);

-- DATEDIFF/TIMESTAMPDIFF  -Get the difference in dates - year, month, day, week
SELECT datediff('2022-01-01', CURDATE());  -- Only gets the days difference 

SELECT TIMESTAMPDIFF(YEAR, '2022-01-01', CURDATE());  -- year diff specifics
SELECT TIMESTAMPDIFF(month, '2022-01-01', CURDATE());  -- month diff
SELECT TIMESTAMPDIFF(day, '2022-01-01', CURDATE());   -- day diff 

-- datename -  in sql - returns a specific part of a date 
SELECT year (current_timestamp());  -- workbench req specification
SELECT month ('2024-02-20');
SELECT quarter (current_timestamp());
select weekday(current_timestamp());

-- datepart
SELECT DATEPART(current_timestamp());

SELECT EXTRACT(YEAR FROM current_date);   -- Returns the current year
SELECT EXTRACT(MONTH FROM '2022-01-01') AS month_value;
SELECT EXTRACT(DAY FROM '2022-01-01') AS day_value;

-- EOMONTH 
SELECT LAST_DAY(CURDATE()) AS end_of_month;

-- dateadd - add date/time ti date vals
SELECT DATE_ADD('2017-08-25', INTERVAL 2 MONTH) AS DateAdd;



