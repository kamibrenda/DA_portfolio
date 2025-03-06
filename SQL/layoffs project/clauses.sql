-- limit - showing number of rows

SELECT *
FROM employee_demographics
ORDER BY age DESC  -- SHOWS TOP 3 OLDERST GUYS 
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC  
LIMIT 2, 1;  -- start at position 2 and select next one after the row 


-- aliasing - change name of the column 
SELECT gender, 
AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;