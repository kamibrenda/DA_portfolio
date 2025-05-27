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

-- 2. Write a solution to find the 
-- second highest distinct salary from the Employee table. 
-- If there is no second highest salary, return null
SELECT (
    SELECT DISTINCT salary  -- to get the unique id
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 -- limit to 1 output
    OFFSET 1  -- remove the first row
) AS SecondHighestSalary;