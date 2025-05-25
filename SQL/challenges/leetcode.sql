-- leetcode 
-- 1.Department Highest Salary
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
JOIN (  -- subquery on a JOIN clause 
    SELECT departmentId, MAX(salary) AS max_salary
    FROM Employee
    GROUP BY departmentId
) AS sub
ON e.departmentId = sub.departmentId AND e.salary = sub.max_salary;