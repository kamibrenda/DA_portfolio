-- CAST MISMATCH 
USE maven_advanced_sql;

describe orders;  -- to get the datatype of the table
describe products;  -- returns if null, pry key

select*
from orders
ORDER BY order_date DESC;

SELECT * FROM orders WHERE order_date = 5;  -- mismatch 

SELECT * FROM orders WHERE order_date = CAST('2024-12-30' AS DATE);









