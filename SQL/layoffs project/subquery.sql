-- subqueries - a query inside another subquery 

SELECT *
FROM employee_demographics
WHERE employee_id IN 
					( SELECT employee_id
						FROM employee_salary
                        WHERE dept_id = 1
)
;

-- USE CASE - getting average salaries using select statement
SELECT 
first_name,
salary,
(select avg(salary) as AVG_salary 
FROM employee_salary)
FROM employee_salary;

-- USE CASE - using from statement to get average 
SELECT 
gender,
avg(age) as age_avg,
max(age),
min(age),
count(age)
FROM employee_demographics
GROUP BY gender;

SELECT 
AVG(max_age)  -- found the average of the maximum age 
FROM 
(SELECT 
gender,
avg(age) as age_avg,
max(age) AS max_age,
min(age) as min_age,
count(age) as count_age
FROM employee_demographics
GROUP BY gender) as Agg_table
;