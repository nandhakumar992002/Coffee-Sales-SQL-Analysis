-- DAILY SALES --
CREATE VIEW daily_sales AS
SELECT YEAR(DATE) AS year, 
       MONTH(DATE) AS month, 
       DAY(DATE) AS day,
       ROUND(SUM(money), 2) AS money
FROM coffeesales
GROUP BY Year, month, day;

SELECT * FROM daily_sales;

-- REVENUE BY CASH TYPE --
SELECT cash_type, ROUND(SUM(Money)) AS moneybycash_type
FROM coffeesales
GROUP BY cash_type;

-- TOP 10 CUSTOMERS --
SELECT card, ROUND(SUM(money)) AS RevFrmCus
FROM coffeesales
WHERE card IS NOT NULL AND card <> ''
GROUP BY card
ORDER BY RevFrmCus DESC
LIMIT 10;

-- TOP SELLING PRODUCTS BY UNITS --
SELECT coffee_name, COUNT(coffee_name) AS units_sold
FROM coffeesales
GROUP BY coffee_name
ORDER BY units_sold DESC;

-- TOP SELLING PRODUCTS BY REVENUE --
SELECT coffee_name, ROUND(SUM(money)) AS revenue
FROM coffeesales
GROUP BY coffee_name 
ORDER BY revenue DESC;

-- TOP SALES MONTH --
SELECT YEAR(date) AS year, MONTH(Date) AS month, ROUND(SUM(money)) AS revenue
FROM coffeesales
GROUP BY year, month
ORDER BY revenue DESC;

-- PEAK HOURS --
SELECT HOUR(time) AS hour, COUNT(*) AS sales
FROM coffeesales
GROUP BY HOUR(time)
ORDER BY sales DESC;
