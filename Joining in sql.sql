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
 
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
  -- Join right table (with alias)
  LEFT JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code DESC;

SELECT c.name AS country, local_name, l.name AS language, percent
-- From left table (alias as c)
FROM countries AS c
  -- Join to right table (alias as l)
  LEFT JOIN languages AS l
    -- Match on fields
    ON c.code = l.code
-- Order by descending country
ORDER BY country DESC;

SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region
-- Order by descending avg_gdp
ORDER BY avg_gdp DESC

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON countries.code = cities.country_code
ORDER BY city, language;

SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  INNER JOIN currencies
    -- Match on code
    USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

--Outer challenge
-- Select fields
SELECT c.name AS country, region, life_expectancy AS life_exp
-- From countries (alias as c)
FROM countries AS c
  -- Join to populations (alias as p)
  LEFT JOIN populations AS p
    -- Match on country code
    ON c.code = p.country_code
-- Focus on 2010
WHERE year = 2010
-- Order by life_exp
ORDER BY life_exp
-- Limit to 5 records
LIMIT 5

-- Select fields from 2010 table
SELECT code, year, income_group, gross_savings
  -- From 2010 table
FROM economies2010
	-- Set theory clause
UNION
-- Select fields from 2015 table
SELECT code, year, income_group, gross_savings
  -- From 2015 table
FROM economies2015
-- Order by code and year
ORDER BY code, year

--Semi Join
SELECT DISTINCT name
  FROM languages
-- Where in statement
WHERE code IN 
  -- Query from step 1
  -- Subquery
  (SELECT code
   FROM countries
   WHERE region = 'Middle East')
-- Order by name
ORDER BY name;

-- Select fields
SELECT local_name, lang_num
  -- From countries
  FROM countries,
  	-- Subquery (alias as subquery)
  	(SELECT code, COUNT(*) AS lang_num
  	 FROM languages
  	 GROUP BY code) AS subquery
  -- Where codes match
  WHERE countries.code = subquery.code
-- Order by descending number of languages
ORDER BY lang_num DESC

SELECT DISTINCT c.name, total_investment, imports
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND e.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE region = 'Central America' AND year = 2015
-- Order by field
ORDER BY c.name;
