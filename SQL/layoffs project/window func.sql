-- window functions 

SELECT gender,
AVG(salary) OVER(partition by gender)
FROM employee_demographics dox
join employee_salary sal
	on dox.employee_id = sal.employee_id
;