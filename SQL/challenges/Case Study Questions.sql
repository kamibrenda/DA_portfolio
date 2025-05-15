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

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

-- 5. Which item was the most popular for each customer?
