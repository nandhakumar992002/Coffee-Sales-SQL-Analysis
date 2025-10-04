-- DATA PREPARATION --

-- Removing Date column
ALTER TABLE coffeesales 
DROP COLUMN `date`;

-- Separating DateTime column
ALTER TABLE coffeesales
ADD COLUMN `date` date, 
ADD COLUMN  `time` time; 

UPDATE coffeesales
SET `DATE` = (SELECT DATE(DATETIME)),
    `TIME` = (SELECT TIME(DATETIME));

ALTER TABLE coffeesales
DROP COLUMN `datetime`;
