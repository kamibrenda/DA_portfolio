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