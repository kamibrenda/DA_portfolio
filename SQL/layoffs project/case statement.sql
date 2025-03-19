-- case statement - ALLOWS ONE TO ADD LOGIC TO THE CODE

SELECT first_name,
last_name, 
age,
CASE
	WHEN age <= 50 THEN "Young"
    WHEN age BETWEEN 31 and 50 THEN "Old"
    WHEN age >= 50 THEN "Near death's door"
END Age_bracket
FROM employee_demographics;


-- use case 1: get pay increase and bonus 
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus 

SELECT 
first_name,
last_name,
salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary  * 1.07  -- other calculation method 
END AS New_salary,
CASE 
	WHEN dept_id = 6 THEN salary * .10
END as Bonus
FROM employee_salary;

# validation  for employee in finance
SELECT 
sal.employee_id,
dept.department_id,
sal.first_name,
sal.last_name,
sal.salary,
dept.department_name
FROM employee_salary sal
INNER JOIN parks_departments dept
ON sal.dept_id = dept.department_id
WHERE dept.department_name = "Finance";
