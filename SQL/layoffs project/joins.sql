-- joins - combines 2 or more tables with similar columns

SELECT *
FROM employee_demographics; 

SELECT *
FROM employee_salary;

-- inner join - returns rows that are the same in both columns and tables
SELECT *
FROM employee_demographics ed
INNER JOIN employee_salary es
	ON ed.employee_id = es.employee_id;
    
-- outer join - has a left outer and right outer 
-- left join - takes everything from the left and related from the right 
SELECT *
FROM employee_demographics ed
LEFT JOIN employee_salary es
	ON ed.employee_id = es.employee_id;

-- right join - takes everything from the right and related from the left 
SELECT *
FROM employee_demographics ed
RIGHT JOIN employee_salary es
	ON ed.employee_id = es.employee_id;

-- self join - tie a table to itself 
-- use case - secret santa
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

-- check who matched for secret santa
SELECT 
emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id;
    
-- joining mutiple table to another table
SELECT *
FROM employee_demographics ed
INNER JOIN employee_salary es
	ON ed.employee_id = es.employee_id
INNER JOIN parks_departments pd 
	ON es.dept_id = pd.department_id
    ;

-- reference table
SELECT *
FROM parks_departments;
