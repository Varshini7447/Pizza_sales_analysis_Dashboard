use PIZZA_DB;

select * from pizza_sales;

--total revenue
select sum(total_price) as total_revenue from pizza_sales;

--average order value
select sum(total_price)/count(DISTINCT order_id) as avg_orders from pizza_sales;

--total pizzas sold
select sum(quantity) as total_pizzas_sold from pizza_sales;

--total orders
select count(distinct order_id) as total_orders from pizza_sales;

select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(DISTINCT order_id) as decimal(10,2))  as decimal(10,2)) from pizza_sales ;

--Daily Trend
select datename(DW,order_date) as order_day,count(DISTINCT order_id) as total_orders
from pizza_sales group by datename(DW,order_date) ;

--Hourly Trend
select datepart(HOUR,order_time) as order_hours, count(DISTINCT order_id) as total_orders
from pizza_sales 
group by datepart(HOUR,order_time)
order by datepart(HOUR,order_time) ;

--Percentage of sales by pizza category
select pizza_category,sum(total_price)as total_sales,sum(total_price)*100/
(select sum(total_price) from pizza_sales where month(order_date)=1) as pct from
pizza_sales where month(order_date)=1
group by pizza_category

--percentage of sales by pizza size
select pizza_size,sum(total_price)as total_sales,sum(total_price)*100/
(select sum(total_price) from pizza_sales where datepart(quarter,order_date )=1) as pct from
pizza_sales 
where datepart(quarter,order_date )=1
group by  pizza_size
order by pizza_size

--total pizzas sold by pizza category
select pizza_category,sum(quantity) as total_sales from pizza_sales
group by pizza_category;

--top 5 best sellers by total pizzas sold
select TOP 5 pizza_name_id,sum(quantity) as total_sales from pizza_sales
group by pizza_name_id
order by  total_sales desc;

--bottom 5 worst sellers by total pizzas sold
select TOP 5 pizza_name_id,sum(quantity) as total_sales from pizza_sales
group by pizza_name_id
order by  total_sales asc;

--updating total_price
UPDATE pizza_sales
SET total_price = total_price + 100
WHERE order_id = 1;

select * from pizza_sales;