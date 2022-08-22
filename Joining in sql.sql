# DataCamp---Joining-in-SQL.sql
SQL Joining Data in SQL

Inner Joins

SELECT * 
FROM cities;

SELECT * 
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;

SELECT cities.name AS city, countries.name AS country, region
FROM cities 
INNER JOIN countries 
ON cities.country_code = countries.code;

SELECT c.code, c.name, c.region, p.year, p.fertility_rate
FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
    
SELECT c.code, c.name, c.region, e.year, p.fertility_rate, e.unemployment_rate
  FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies AS e
    ON c.code = e.code 

--To make the data cleaner you can use AND in the ON. This now uses year and code to join the data together. 

SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies AS e
    ON c.code = e.code AND e.year = p.year
    
 --Inner Join via USING --> parenthesis are required.
 
SELECT c.name AS country, continent, l.name AS language, official
FROM countries AS c
  INNER JOIN languages AS l
    USING(code)
    
--Self-Ish Joins --> joining a table to itself?
--CASE is a way to do multiple if-then-else statements in a simplified way in SQL

SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015
FROM populations AS p1
  INNER JOIN populations AS p2
    ON p1.country_code = p2.country_code

SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015
FROM populations as p1
  INNER JOIN populations as p2
    ON p1.country_code = p2.country_code AND p1.year = p2.year - 5
    
SELECT name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000 THEN 'large'
        WHEN surface_area > 350000 THEN 'medium'
        ELSE 'small' END
        AS geosize_group
FROM countries;

SELECT p.country_code, p.size,
    CASE WHEN size > 50000000 
        THEN 'large'
    WHEN size > 1000000 
        THEN 'medium'
    ELSE 'small'END
    AS popsize_group
FROM populations AS p
WHERE year = 2015;

SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations
WHERE year = 2015;


SELECT * FROM
pop_plus;

SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

SELECT name, continent, geosize_group, popsize_group
FROM countries_plus AS c
INNER JOIN pop_plus AS p
  ON c.code = p.country_code
ORDER BY geosize_group
 
 
