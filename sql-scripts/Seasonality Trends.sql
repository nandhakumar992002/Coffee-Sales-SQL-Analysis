-- CONTRIBUTION OF COFFEE TYPES IN % --
SELECT coffee_name,
       ROUND(SUM(money),1) AS Revenue,
       CONCAT(ROUND(SUM(money) / (SELECT SUM(money) FROM coffeesales ) * 100, 1), '%') AS prop_percentage
FROM coffeesales
GROUP BY coffee_name;

-- SEASONALITY REPORT --
SELECT date, revenue, SUM(revenue) OVER (ORDER BY date) AS running_rev_total, 
       units_sold, unique_customers, ROUND(avg_price) AS avg_price
FROM (
  SELECT DATE_FORMAT(date, '%Y-%m-01') AS date, 
         ROUND(SUM(money)) AS revenue, 
         AVG(Money) AS avg_price, 
         COUNT(coffee_name) AS units_sold, 
         COUNT(DISTINCT card) AS unique_customers
  FROM coffeesales
  GROUP BY DATE_FORMAT(date, '%Y-%m-01')
  ORDER BY DATE_FORMAT(date, '%Y-%m-01')
) report;

-- PERFORMANCE ANALYSIS OF PRODUCTS --
WITH monthly_sales AS(
  SELECT month(date) AS month, coffee_name, ROUND(SUM(money)) AS money
  FROM coffeesales
  GROUP BY month(date), coffee_name
  ORDER BY month(date)
)
SELECT month,
       coffee_name, 
       money, 
       ROUND(AVG(money) OVER (PARTITION BY coffee_name )) AS avg_monthly_sales,
       money - ROUND(AVG(money) OVER (PARTITION BY coffee_name )) AS monthly_performance,
       CASE 
         WHEN money - ROUND(AVG(money) OVER (PARTITION BY coffee_name )) > 0 THEN 'Above Average'
         WHEN money - ROUND(AVG(money) OVER (PARTITION BY coffee_name )) < 0 THEN 'Below Average'
         ELSE 'Average' END AS Performance,
       ROUND(LAG(money) OVER (PARTITION BY coffee_name ORDER BY month)) AS prev_month_sales,      
       money - ROUND(LAG(money) OVER (PARTITION BY coffee_name ORDER BY month)) AS monthly_comparison, 
       CASE 
         WHEN money - ROUND(LAG(money) OVER (PARTITION BY coffee_name ORDER BY month)) > 0 THEN 'Increase'
         WHEN money - ROUND(LAG(money) OVER (PARTITION BY coffee_name ORDER BY month)) < 0 THEN 'Decrease'
         ELSE 'No Change' END AS Comparison
FROM monthly_sales;

-- RUNNING TOTAL SALES BY MONTH --
WITH monthly_revenue AS (
  SELECT DATE_FORMAT(Date, '%Y-%m-01') AS Date, 
         ROUND(SUM(money), 1) AS Revenue
  FROM coffeesales
  GROUP BY DATE_FORMAT(Date, '%Y-%m-01')
  ORDER BY DATE_FORMAT(Date, '%Y-%m-01')
)            
SELECT Date, 
       Revenue, 
       ROUND(SUM(Revenue) OVER (ORDER BY Date), 1) AS moving_totalsales
FROM monthly_revenue;
