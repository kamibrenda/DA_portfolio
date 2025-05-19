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
select count(s.product_id)
from sales s;

select 
	me.product_name,
    COUNT(s.product_id) AS popular_item
from menu me INNER JOIN sales s
ON me.product_id = s.product_id
GROUP BY me.product_name
ORDER BY popular_item desc
limit 1
;

-- 6. Which item was purchased first by the customer after they became a member?  TBD
select *
FROM
(SELECT m.customer_id
	from members m INNER JOIN sales s 
	ON m.customer_id = s.customer_id) as customer_
LEFT JOIN  (select me.product_name
			from menu me INNER JOIN sales s
			ON me.product_id = s.product_id) AS product_
ON customer_.product_id = product_.product_id
WHERE customer_.order_date > customer_.join_date
;

select 
me.product_name
from menu me INNER JOIN sales s
ON me.product_id = s.product_id
;


-- 7. Which item was purchased just before the customer became a member?

-- 8. What is the total items and amount spent for each member before they became a member?

-- 9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?