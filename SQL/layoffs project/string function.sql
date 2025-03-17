-- len() 
select length('skyfall');

Select first_name, 
length(first_name)
from employee_demographics
order by 2;

-- upper()  - transforms to uppercase
select upper('skyfall');

Select first_name, 
upper(first_name)
from employee_demographics;

-- lower()  - transforms to lowercase
select lower('skyfall');

Select first_name, 
lower(first_name)
from employee_demographics;

-- trim()  -has left and right - removes white space at the front and the end 
SELECT TRIM('                  SKY                              ');
SELECT LTRIM('                  SKY                              ');
SELECT RTRIM('                             SKY                              ');


-- SUBSTRING
select first_name,
LEFT(first_name, 4), -- get  first four characters from the left
RIGHT(first_name, 4), -- get  first four characters from the RIGHT
SUBSTRING(first_name, 3,2),  -- start at position and number of characters desired(x,y)
birth_date,
substring(birth_date, 6,2) AS birth_month
from employee_demographics;


-- replace - changes a present character with a different character 
Select first_name, 
REPLACE(first_name, 'a', 'z')
from employee_demographics;


-- locate 
SELECT LOCATE('x', 'Alexander');

Select first_name, 
LOCATE('An ', first_name)
from employee_demographics;


-- concatenation -  combining 2 columns 
Select first_name, 
last_name,
CONCAT(first_name, ' ', last_name) AS Full_name
from employee_demographics;
