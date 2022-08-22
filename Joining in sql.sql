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
