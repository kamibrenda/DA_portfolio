-- Group and Order by
-- Group by

SELECT gender, 
AVG(age), 
MAX(age),
count(age) -- number of values in column as aggregated by gender
FROM employee_demographics
GROUP BY gender;

SELECT occupation , salary
FROM employee_salary
group by occupation, salary;

-- Order by - sorts in asc or desc
SELECT *
FROM employee_demographics
order by first_name desc;  -- default in ascending 

SELECT *
FROM employee_demographics
ORDER BY gender, age desc;
