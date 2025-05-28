-- exploration and validation 
USE pizza_runner;



select customer_id,  -- primary key in customer_order table 
		order_id,   -- foreign key in customer_order table 
        pizza_id	--  -- foreign key in customer_order table
from customer_orders
;
describe customer_orders; -- no primary key present only foreign keys

select order_id, -- primary key of orders made
		runner_id -- foreign key of the orders id with runner info
from runner_orders
;

select runner_id, -- primary key of the runners 
		registration_date -- date at which runner is registered on the app
from runners
;
describe customer_orders; -- no primary key set or present 

-- average speed calculation 
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

-- reviewing the script using a CTE 
-- CTE to calculate speed (distance/duration) per order
WITH speed_data AS (
    SELECT 
        ro.runner_id,                 -- Unique ID of the runner
        ro.order_id,                  -- Order ID to track individual deliveries
        co.order_time,                -- Timestamp of when the order was placed
        (ro.distance / ro.duration) AS speed  -- Speed for that particular order
    FROM runner_orders ro
    LEFT JOIN customer_orders co ON ro.order_id = co.order_id  -- Match orders with customer details
    LEFT JOIN runners r ON ro.runner_id = r.runner_id           -- Include runner info if needed
)
-- Main query to calculate average speed per runner per order
SELECT 
    sd.runner_id,                      -- Unique ID of the runner
    AVG(sd.speed) AS avg_runner_speed, -- Average speed of the runner (could be same as speed if grouped per order)
    sd.order_id,                       -- Order ID to maintain order-level granularity
    sd.order_time                      -- Timestamp of the order
FROM speed_data sd
GROUP BY 
    sd.runner_id, 
    sd.order_id, 
    sd.order_time                     -- Group by these fields to calculate average speed per unique runner-order
ORDER BY 
    sd.order_time DESC;               -- Sort orders from most recent to oldest