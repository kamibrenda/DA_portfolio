-- Case Study Questions
USE dannys_diner;
-- 1. What is the total amount each customer spent at the restaurant?
select*
from 
	members;
    
select*
from 
	menu;
    
select*
from 
	sales;
    
SELECT  -- B
  s.customer_id,
  SUM(me.price) AS total_amount_spent
FROM sales s
JOIN menu me ON s.product_id = me.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

SELECT sal.customer_id, sum(men.price) over (partition by sal.customer_id) as Total  -- C
FROM dannys_diner.sales sal
INNER JOIN dannys_diner.menu men 
ON sal.product_id = men.product_id ;



-- 2. How many days has each customer visited the restaurant?
select 
	s.customer_id,
    COUNT(DISTINCT order_date) as no_days  -- TO ELIMINATE DAYS GONE TWICE
from sales s
GROUP BY s.customer_id
;

-- 3. What was the first item from the menu purchased by each customer?
select 
distinct s.customer_id,
me.product_name, 
s.order_date
from 
menu me 
JOIN sales s ON me.product_id = s.product_id 
WHERE order_date = (select MIN(order_date)
		from sales)
;

SELECT customer_id, order_date, product_name  -- Alt version of code 
FROM (
    SELECT DISTINCT
        s.customer_id,
        s.order_date,
        m.product_name,
        DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS rn  
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
) AS ranks
WHERE rn = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select 
me.product_name,
COUNT(s.product_id) AS item_purch
from 
sales s 
JOIN menu me ON s.product_id = me.product_id 
GROUP BY me.product_name, s.product_id
ORDER BY item_purch DESC
LIMIT 1
;

-- 5. Which item was the most popular for each customer?
select me.product_name,
		customer.customer_id
from menu me INNER JOIN
	(SELECT s.product_id,
		    s.customer_id
        from sales s
       GROUP BY s.product_id, s.customer_id) AS customer
ON me.product_id = customer.product_id
order by customer.customer_id
;

-- Esther's query 
WITH customer_product_counts AS (
    SELECT
        m.product_name,
        s.customer_id,
        COUNT(customer_id) AS counts
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY m.product_name, s.customer_id
),
max_counts AS (
    SELECT
        customer_id,
        MAX(counts) AS max_count
    FROM customer_product_counts
    GROUP BY customer_id
)
SELECT
    cpc.product_name,
    cpc.customer_id
FROM customer_product_counts cpc
JOIN max_counts mc ON cpc.customer_id = mc.customer_id AND cpc.counts = mc.max_count
ORDER BY cpc.customer_id; 


-- chatgpt ver
WITH product_counts AS (
  SELECT 
    s.customer_id,
    m.product_name,
    COUNT(*) AS purchase_count
  FROM dannys_diner.sales s
  JOIN dannys_diner.menu m 
    ON s.product_id = m.product_id
  GROUP BY s.customer_id, m.product_name
),
ranked_items AS (
  SELECT 
    *,
    RANK() OVER (
      PARTITION BY customer_id 
      ORDER BY purchase_count DESC
    ) AS rank_
  FROM product_counts
)
SELECT 
  customer_id,
  product_name AS most_popular_item,
  purchase_count
FROM ranked_items
WHERE rank_ = 1;

-- 6. Which item was purchased first by the customer after they became a member?  TBD
SELECT s.customer_id, 
	   s.order_date, 
       me.product_name
FROM sales s
INNER JOIN members m ON s.customer_id = m.customer_id
INNER JOIN menu me ON s.product_id = me.product_id
WHERE s.order_date > m.join_date  -- compares current date to first purchase date to get the first row 
AND s.order_date = (			
    SELECT MIN(s2.order_date)   -- finds only minimum order date 
    FROM sales s2
    WHERE s2.customer_id = s.customer_id
      AND s2.order_date > m.join_date  -- finds first purchase after membership date
);

-- chatgpt
SELECT customer_id, 
	   order_date, 
	   product_name
FROM (
    SELECT 
        s.customer_id,
        s.order_date,
        me.product_name,
        m.join_date,
        ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS rn  -- to 
    FROM sales s
    JOIN members m ON s.customer_id = m.customer_id
    JOIN menu me ON s.product_id = me.product_id
    WHERE s.order_date > m.join_date
) ranked
WHERE rn = 1;


-- 7. Which item was purchased just before the customer became a member?
select customer_id,
	   product_name,
       order_date
from 
(select s.customer_id,
		me.product_name,
        s.order_date,
        m.join_date,
        row_number() over(partition by s.customer_id order by s.order_date DESC ) as rn -- to get the last order date
from sales s INNER JOIN members m
ON s.customer_id = m.customer_id
INNER JOIN menu me 
ON me.product_id = s.product_id 
where s.order_date > m.join_date
)ranked_prods
where rn = 1
;
-- 8. What is the total items and amount spent for each member before they became a member?
-- total spent by each customer
WITH amount_spent as (   -- CTE to get the amount spent and total items  
	SELECT 
       s.customer_id,
	   COUNT(s.product_id) as total_items,   -- get number of items
       SUM(me.price) as amt_spent -- get total amount spent on the product 
FROM sales s 
INNER JOIN menu me 
ON s.product_id = me.product_id 
INNER JOIN members m 
ON s.customer_id = m.customer_id
where s.order_date > m.join_date  -- to filter to have it before membership
GROUP BY s.customer_id)    -- to group output to customers

SELECT m.customer_id,
	   amount_spent.total_items,
       amount_spent. amt_spent 
FROM members m LEFT JOIN amount_spent
ON m.customer_id = amount_spent.customer_id
;

-- 9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi 
-- how many points do customer A and B have at the end of January?