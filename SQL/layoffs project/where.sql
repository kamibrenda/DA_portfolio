select *
FROM parks_and_recreation.employee_salary
WHERE first_name = "Leslie";

select *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000 ;

select *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000 ;

SELECT*
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01';

-- AND OR NOT -- LOGICAL OPERATORS
SELECT*
FROM
parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

SELECT*
FROM
parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44)
		OR age > 55;
        
-- LIKE can work with num 
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';  -- get the exact match

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
