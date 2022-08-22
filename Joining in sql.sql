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
 
 
