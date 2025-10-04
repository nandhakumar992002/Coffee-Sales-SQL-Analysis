-- REPEAT PURCHASES BY CARD --
SELECT card, COUNT(card) AS no_of_times_purchased
FROM coffeesales
GROUP BY card
HAVING card <> '' 
ORDER BY COUNT(card) DESC;
