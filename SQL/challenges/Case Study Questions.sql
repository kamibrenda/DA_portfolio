-- Case Study Questions

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
    
SELECT
  s.customer_id,
  SUM(me.price) AS total_amount_spent
FROM sales s
JOIN menu me ON s.product_id = me.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;


-- 2. How many days has each customer visited the restaurant?
select 
	s.customer_id,
    COUNT(order_date) as no_days
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
GROUP BY s.customer_id
;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select 
me.product_name,
COUNT(s.product_id)
from 
sales s 
JOIN menu me ON s.product_id = me.product_id 
GROUP BY me.product_name, s.product_id
;

-- 5. Which item was the most popular for each customer?
WITH product_counts AS (
  SELECT 
    c.customer_id,
    me.product_name,
    COUNT(*) AS purchase_count,
    RANK() OVER (PARTITION BY c.customer_id ORDER BY COUNT(*) DESC) AS rank
  FROM sales s
  JOIN menu me ON s.product_id = me.product_id 
  JOIN customer c ON s.customer_id = c.customer_id
  GROUP BY c.customer_id, me.product_name
)
SELECT customer_id, product_name, purchase_count
FROM product_counts
WHERE rank = 1;


-- 6. Which item was purchased first by the customer after they became a member?

-- 7. Which item was purchased just before the customer became a member?

-- 8. What is the total items and amount spent for each member before they became a member?

-- 9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?