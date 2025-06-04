-- CAST MISMATCH 
USE maven_advanced_sql;

describe orders;  -- to get the datatype of the table
describe products;  -- returns if null, pry key

select*
from orders
ORDER BY order_date DESC;

SELECT * FROM orders WHERE order_date = 5;  -- mismatch 

SELECT * FROM orders WHERE order_date = CAST('2024-12-30' AS DATE);


-- break and make query 
use pizza_runner;
select *
from customer_orders
;
-- QUERY 1 
select 
(ro.distance / ro.duration) as avg_runner_speed,
ro.runner_id,
ro.order_id,
co.order_time
from runner_orders ro Left join customer_orders co
ON ro.order_id = co.order_id
left join runners r 
ON ro.runner_id = r.runner_id
Group by ro.runner_id, ro.order_id  -- GROUP BY STATEMENT does NOT have the ORDER time IN the selected columns
order by co.order_time DESC
;

-- fixed query 
select DISTINCT ro.runner_id,
AVG(ro.distance / ro.duration) as avg_runner_speed,
ro.order_id,
co.order_time
from runner_orders ro Left join customer_orders co
ON ro.order_id = co.order_id
left join runners r 
ON ro.runner_id = r.runner_id
Group by ro.runner_id, ro.order_id, co.order_time
order by co.order_time DESC
;




