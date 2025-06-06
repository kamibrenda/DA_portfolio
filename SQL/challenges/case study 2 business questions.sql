-- case study 2 business questions
USE pizza_runner;
describe runner_orders;

-- A. Pizza Metrics
-- How many successful orders were delivered by each runner?
SELECT r.runner_id,
	   count(ro.order_id) as no_orders
FROM runner_orders ro INNER JOIN
runners r ON ro.runner_id = r.runner_id
where ro.cancellation is null or ''
group by r.runner_id
;



-- B. Runner and Customer Experience
-- Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT
  co.order_id,
  COUNT(co.pizza_id) AS no_pizzas,   -- get the number of pizzas 
  TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time) AS time_taken_order  -- get the difference between the time the pizza is ordered and picked 
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
GROUP BY co.order_id, co.order_time, ro.pickup_time
ORDER BY time_taken_order DESC  -- Arrange pizzas from the one that took the most time 
;

-- C. Ingredient Optimisation
-- What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
-- Select the ingredient ID and total times it was used
SELECT 
  ingredient_id, 
  COUNT(*) AS total_used
FROM (
    -- Step 1: Extract each ingredient ID from the 'extras' column and flatten into rows
    SELECT 
      TRIM(e.value) AS ingredient_id  -- Remove any leading/trailing spaces from each ingredient ID
    FROM customer_orders co
    JOIN runner_orders ro 
      ON co.order_id = ro.order_id  -- Join customer orders with runner orders using order_id
    -- Step 2: Split the comma-separated extras column into individual ingredient IDs
    CROSS JOIN JSON_TABLE(
        CONCAT('[', REPLACE(co.extras, ',', '","'), ']'),  -- Format the string into a valid JSON array
        '$[*]' COLUMNS (value VARCHAR(255) PATH '$')        -- Extract each element from the array
    ) AS e
    -- Step 3: Only include delivered orders (i.e., not cancelled)
    WHERE ro.cancellation IS NULL OR ro.cancellation = ''
) AS ingredients_flat  -- Step 4: Use the flattened result as a derived table
-- Step 5: Group by each ingredient ID and count how often it appears
GROUP BY ingredient_id
-- Step 6: Sort from most used ingredient to least used
ORDER BY total_used DESC
;
-- D.Pricing and Ratings
-- If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - 
 -- how much money has Pizza Runner made so far if there are no delivery fees?
SELECT 
  SUM(
    CASE 
      WHEN co.pizza_id = 1 THEN 12  -- Meat Lovers costs $12
      WHEN co.pizza_id = 2 THEN 10  -- Vegetarian costs $10
      ELSE 0                        -- In case of unknown pizza_id (safe fallback)
    END
  ) AS total_revenue
FROM customer_orders co
JOIN runner_orders ro 
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation = ''
;

 
