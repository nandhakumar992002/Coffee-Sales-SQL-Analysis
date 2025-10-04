-- PRICE CHANGES OVER THE PERIOD --
SELECT coffee_name, date, money 
FROM (SELECT coffee_name, Date, money, 
             LAG(money) OVER (PARTITION BY coffee_name ORDER BY date) AS prev_price
      FROM coffeesales) AS changedprice
WHERE money <> prev_price OR prev_price IS NULL;

-- SALES SUMMARY TABLE (Price changes impact) --
CREATE TABLE sales_summary AS
SELECT s1.money, s1.coffee_name, s2.no_of_units, s1.days_sold
FROM 
    (SELECT money, coffee_name, COUNT(DISTINCT date) AS days_sold
     FROM coffeesales
     GROUP BY money, coffee_name
     ORDER BY coffee_name, money) s1
LEFT JOIN 
    (SELECT money, coffee_name, COUNT(coffee_name) AS no_of_units
     FROM coffeesales
     GROUP BY money, coffee_name
     ORDER BY coffee_name, money) s2
ON s1.coffee_name = s2.coffee_name AND s1.money = s2.money;

SELECT * FROM sales_summary;

-- TOTAL UNITS SOLD BY COFFEE TYPE --
SELECT coffee_name, SUM(no_of_units) AS units_sold
FROM sales_summary
GROUP BY coffee_name;

-- AVERAGE UNITS SOLD PER DAY --
SELECT *, ROUND(no_of_units / days_sold, 2) AS Avg_units_sold_per_day
FROM sales_summary
ORDER BY coffee_name, money;

-- MOST SOLD COFFEE EACH MONTH --
SELECT *
FROM (
  SELECT *, RANK() OVER (PARTITION BY month ORDER BY units_sold DESC) AS `rank`
  FROM (
    SELECT MONTH(date) AS month, coffee_name, COUNT(coffee_name) AS units_sold
    FROM coffeesales
    GROUP BY MONTH, coffee_name
    ORDER BY MONTH, coffee_name
  ) tab
) tab2
WHERE `rank` = 1;
