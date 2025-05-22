-- ASSIGNMENT 4: CTEs
-- Connect to database (MySQL)
USE maven_advanced_sql;

-- View the orders and products tables
SELECT * FROM orders;
SELECT * FROM products;

-- Calculate the amount spent on each product, within each order
SELECT	o.order_id, 
		o.product_id, 
        o.units, 
        p.unit_price,
		o.units * p.unit_price AS amount_spent
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id;

-- Return all orders over $200
SELECT	 o.order_id,    -- this query is to be used as a CTE
		 SUM(o.units * p.unit_price) AS total_amount_spent
FROM	 orders o LEFT JOIN products p
		 ON o.product_id = p.product_id
GROUP BY o.order_id
HAVING   total_amount_spent > 200
ORDER BY total_amount_spent DESC;

-- Return the number of orders over $200
WITH tas AS (SELECT	 o.order_id,
					 SUM(o.units * p.unit_price) AS total_amount_spent
			 FROM	 orders o LEFT JOIN products p
					 ON o.product_id = p.product_id
			 GROUP BY o.order_id
			 HAVING   total_amount_spent > 200
			 ORDER BY total_amount_spent DESC)
			
			/* This ORDER BY clause in the CTE doesn't affect the final output
			   and can be removed to make the code run more efficiently */
             
SELECT	COUNT(*)
FROM	tas;

-- ASSIGNMENT 5: Multiple CTEs
-- Copy over Assignment 2 (Subqueries in the FROM clause) solution
SELECT	fp.factory, fp.product_name, fn.num_products
FROM
(SELECT	factory, product_name
FROM	products) fp
LEFT JOIN
(SELECT	 factory, COUNT(product_id) AS num_products
FROM	 products
GROUP BY factory) fn
ON fp.factory = fn.factory
ORDER BY fp.factory, fp.product_name;

-- Rewrite the Assignment 2 subquery solution using CTEs instead
WITH fp AS (SELECT factory, product_name FROM products),   -- the 2 subqueries joined together 
	 fn AS (SELECT	 factory, COUNT(product_id) AS num_products
			FROM	 products
			GROUP BY factory)

SELECT	fp.factory, 			-- to select columns from the CTE
		fp.product_name, 
        fn.num_products
FROM	fp LEFT JOIN fn
		ON fp.factory = fn.factory
ORDER BY fp.factory, fp.product_name;