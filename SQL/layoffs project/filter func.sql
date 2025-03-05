-- having vs where 

-- having
SELECT gender, 
AVG(age)
from
employee_demographics
GROUP BY gender 
having avg(age) > 40;


SELECT occupation,
AVG(salary)
from
employee_salary
WHERE occupation LIKE '%manager%'  -- filter at row level
GROUP BY occupation
HAVING avg(salary)> 75000;   -- filter at agg level




-- where 
 