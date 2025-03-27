
--1.Total Revenue
select sum(total_price) as Total_Revenue
From pizza_sales
--2.Average Orders Value
select (SUM(total_price)/COUNT(distinct order_id)) as Avg_Orders_Value
from pizza_sales
--3.Total Pizza Sold
select SUM(quantity) as Total_Pizza_Sold 
from pizza_sales
--4.Total Orders
select COUNT(distinct order_id) as Total_Orders
from pizza_sales
--5.Average Pizzas Per Order (Số lượng trung bình Pizza có trong mỗi đơn hàng)
select cast(CAST(SUM(quantity) as decimal(10,2))/
CAST(COUNT(distinct order_id) as decimal(10,2))as decimal(10,2)) as Avg_Pizzas_Per_order
from pizza_sales
--6.Daily Trend for Total Orders
select DATENAME(DW,order_date) as order_day,COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(DW,order_date)
order by Total_Orders desc
--7.Hourly Trend for Total Orders
select DATEPART(HOUR,order_time) as order_time,SUM(quantity) as Total_Orders
from pizza_sales
group by  DATEPART(HOUR,order_time)
order by  DATEPART(HOUR,order_time)
--8.Percentage of Sales by Pizza Category
select pizza_category,cast(SUM(total_price) as decimal(10,2)) as Total_Sales,cast(SUM(total_price) * 100 / 
(select sum(total_price) from pizza_sales where MONTH(order_date) = 1 ) as decimal(10,2)) as PCT
from pizza_sales
where MONTH(order_date) = 1
group by pizza_category
--9.Percentage of Sales by Pizza Size
select pizza_size,cast(SUM(total_price) as decimal (10,2)) as Total_Sales,cast(SUM(total_price) * 100 / 
(select sum(total_price) from pizza_sales where DATEPART(QUARTER,order_date) = 1 ) as decimal(10,2)) as PCT
from pizza_sales
where DATEPART(QUARTER,order_date) = 1
group by pizza_size
order by PCT desc
--10.Top 5 best sellers by Total Pizzas Sold
select Top 5 pizza_name,SUM(quantity) as Total_Sold
from pizza_sales
group by pizza_name
order by Total_Sold desc


