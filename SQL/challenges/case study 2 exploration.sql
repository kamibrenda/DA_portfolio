-- exploration and validation 
USE pizza_runner;



select customer_id,  -- primary key in customer_order table 
		order_id,   -- foreign key in customer_order table 
        pizza_id	--  -- foreign key in customer_order table
from customer_orders
;
describe customer_orders; -- no primary key present only foreign keys

select *
from pizza_names
;

select *
from pizza_recipes
;

select *
from pizza_toppings
;

select *
from runner_orders
;

select *
from runners
;