# DataCamp---Joining-in-SQL.sql
SQL Joining Data in SQL

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
