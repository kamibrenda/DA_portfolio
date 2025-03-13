-- unions - combines rows together 

-- union distinct - has only unique values
SELECT 
first_name,
last_name
FROM employee_demographics
UNION
SELECT 
first_name,
last_name
FROM employee_salary;

-- union all 
-- allows for duplicates
SELECT 
first_name,
last_name
FROM employee_demographics
UNION ALL
SELECT 
first_name,
last_name
FROM employee_salary;


-- USE CASES
SELECT 
first_name,
last_name,
'Old' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT 
first_name,
last_name,
'Old' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT 
first_name,
last_name,
'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name,
last_name
;