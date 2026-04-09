--Creating the DB and using it
Create Database superstore_db;
use superstore_db;
---------------------------------------------------------------
--Checking the data
SELECT * FROM orders LIMIT 5;
---------------------------------------------------------------
--Q) What are overall business numbers?
select
	ROUND(SUM(sales),2) As total_revenue,
    ROUND(SUM(profit),2) As total_profit,
    Count(Distinct order_id) as total_orders,
    ROUND(AVG(profit_margin)) as avg_profit_margin
From orders;
---------------------------------------------------------------
--Q)Which region makes the most money?
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin
FROM orders
GROUP BY region
ORDER BY total_revenue DESC;
---------------------------------------------------------------
--What are our top 10 products by revenue?
SELECT
    product_name,
    category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin,
    COUNT(DISTINCT order_id) AS times_ordered
FROM orders
GROUP BY product_name, category
ORDER BY total_revenue DESC
LIMIT 10;
---------------------------------------------------------------
--How is revenue trending month over month?
SELECT
    order_year,
    order_month,
    order_month_name,
    ROUND(SUM(sales), 2) AS monthly_revenue,
    ROUND(
        SUM(sales) - LAG(SUM(sales))
        OVER (ORDER BY order_year, order_month)
    , 2) AS mon_change
FROM orders
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;
---------------------------------------------------------------
--Which products are losing us money?
SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 2) AS avg_margin,
    COUNT(DISTINCT order_id) AS times_ordered
FROM orders
GROUP BY product_name, category, sub_category
HAVING total_profit < 0
ORDER BY total_profit ASC
Limit 10;

---------------------------------------------------------------
--Which customer segment is most valuable?
SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM orders
GROUP BY segment
ORDER BY total_profit DESC;
---------------------------------------------------------------
--How fast are we shipping by ship mode?
SELECT
    ship_mode,
    ROUND(AVG(days_to_ship), 1) AS avg_days_to_ship,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin
FROM orders
GROUP BY ship_mode
ORDER BY avg_days_to_ship ASC;