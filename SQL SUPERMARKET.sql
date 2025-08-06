SELECT * FROM pooja.sssales;
select *
 from pooja.sssales
 where state= 'Florida';
 
-- Name top 3 customers with highest total value of orders?
select Customer_Name , sum(Sales)
 from pooja.sssales 
 group by Customer_Name 
 order by sum(sales) 
 desc limit 3;
 
-- Q3) Find the top 5 items with the highest average sales per day?
select product_name,avg(sales) 
from pooja.sssales 
group by product_name 
order by avg(sales) 
desc limit 5;

-- Q4) Write a query to find the average order value for each customer, and rank the customers by their average order value? 
select  avg(sales),customer_name 
from pooja.sssales 
group by customer_name 
order by avg(sales);

-- Q5) Give the name of customers who ordered highest and lowest orders from each city?
select customer_Name, max(sales),min(sales),city 
from pooja.sssales
 group by city,customer_Name
 having min(sales);

-- Q6) What is the most demanded sub-category in the west region?SELECT sub_category FROM pooja.sssales where region = 'west';
SELECT sub_category ,SUM(sales) 
FROM pooja.sssales 
where region = 'west' 
group by sub_category  
order by sum(sales)
 desc limit 1 ;

-- Q7) Which order has the highest number of items?
SELECT order_id, count(order_id)
 from pooja.sssales 
 group by order_id 
 order by count(order_id) 
 desc limit 1;

-- Q8) Which order has the highest cumulative value ?
SELECT order_id, sum(sales) 
from pooja.sssales 
group by order_id 
order by sum(sales)  
desc limit 1;

-- Q9) Which segment’s order is more likely to be shipped via first class?
select count(order_id),segment 
from pooja.sssales 
where  ship_mode ='first class'
 group by segment
 order by count(order_id)desc;

-- Q10) Which city is least contributing to total revenue?  
select sum(sales),city
 from pooja.sssales
 group by city 
 order by sum(sales);

-- Q11) What is the average time for orders to get shipped after order is placed?
select avg(DATEDIFF(ship_date,order_date)) 
from pooja.sssales;

/* Q12) Which segment places the highest number of orders from each state and which segment places the largest individual orders from each state? */
        select segment ,count(order_id),state from pooja.sssales group by segment,state order by count(order_id);
        WITH cte AS (
    SELECT
        state,
        segment,
        COUNT(order_id) AS num_orders,
        RANK() OVER (PARTITION BY state ORDER BY COUNT(order_id) DESC) AS state_rank
    FROM
       pooja.sssales
    GROUP BY
        state,
        segment
)
SELECT
    state,
    segment
FROM
    cte
WHERE
    state_rank = 1;


