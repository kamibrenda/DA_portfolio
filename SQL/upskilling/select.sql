-- to get the DB being queried
USE maven_advanced_sql;

-- with the explanation of workchart flow 
select * 
from students   -- table selected to 
where gpa > 3.0    -- filter out based on the selected condition
order by grade_level desc  -- arrange by largest to smallest 