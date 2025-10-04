-- SALES OVERVIEW REPORT --

SELECT 'Total sales' AS measure_name, CONCAT(Round(SUM(money), 1),' ', 'hryvnia') AS Measure_value FROM coffeesales
UNION ALL
SELECT 'Total quantity' AS measure_name, CONCAT(COUNT(coffee_name),' ','units') AS Measure_value FROM coffeesales
UNION ALL
SELECT 'Avg price' AS measure_name, ROUND(AVG(money), 1) AS Measure_value FROM coffeesales
UNION ALL
SELECT 'Product Category' AS measure_name, COUNT(DISTINCT coffee_name) AS Measure_value FROM coffeesales
UNION ALL 
SELECT 'Sales Period' AS measure_name, CONCAT(TIMESTAMPDIFF(month, MIN(`date`), MAX(`date`)) + 1,' ', 'Months') AS Measure_value FROM coffeesales
UNION ALL
SELECT 'Unique card users' AS measure_name, COUNT(DISTINCT card) AS Measure_value FROM coffeesales;
