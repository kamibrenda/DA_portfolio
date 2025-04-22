-- Common Table Expression(s) - allows definition of a subquery block that you can ref in main query 

WITH CTE_example_orig (Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal)  AS
(
SELECT 
gender,
AVG(salary) avg_sal,
MAX(salary) max_sal,
MIN(salary) min_sal,
COUNT(salary) count_sal
from 
employee_demographics ed 
JOIN employee_salary es 
	ON ed.employee_id = es.employee_id
group by gender
)
select *
from CTE_example_orig
;

-- mutiple ctes within 
WITH CTE_example AS
(
SELECT 
employee_id,
gender,
birth_date
from 
employee_demographics ed 
where birth_date > '1985-01-01'
),
CTE_example_2 as 
(
select 
employee_id,
salary
from employee_salary
where salary > 50000
)
SELECT *
FROM CTE_example
JOIN CTE_example_2
	ON CTE_example.employee_id = CTE_example_2.employee_id
;


-- diff with subquery - readablity 
-- subquery 
SELECT AVG(avg_sal)
FROM(
SELECT 
gender,
AVG(salary) avg_sal,
MAX(salary) max_sal,
MIN(salary) min_sal,
COUNT(salary) count_sal
from 
employee_demographics ed 
JOIN employee_salary es 
	ON ed.employee_id = es.employee_id
group by gender
)example_subquery

;