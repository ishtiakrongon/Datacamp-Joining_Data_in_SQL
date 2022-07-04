-- Begin by selecting all columns from the cities table.

SELECT *
FROM cities;


--------------------------------------------------------------------------------

/* Inner join the cities table on the left to the countries table on the right, 
keeping all of the fields in both tables. Match the tables on the country_code 
field in cities and the code field in countries. */

SELECT *
FROM
    cities
    -- Inner joint to countries table
    INNER JOIN countries
    -- Match on countries code
    ON cities.country_code = countries.code;


--------------------------------------------------------------------------------


-- Modify the SELECT statement to keep only the name of the city, the name 
-- of the country, and the name of the region the country resides in.
-- Alias the name of the city AS city and the name of the country AS country

SELECT
    cities.name AS city, countries.name AS country, region
FROM
    cities
    INNER JOIN countries
    ON cities.country_code = countries.code;

--------------------------------------------------------------------------------


-- Join the tables countries (left) and economies (right) aliasing countries 
-- AS c and economies AS e. Specify the field to match the tables ON.

SELECT
    c.code AS country_code,
    name,
    year,
    inflation_rate
FROM
    countries AS c
    INNER JOIN economies AS e
    ON c.code = e.code;

--------------------------------------------------------------------------------

-- Inner join countries (left) and populations (right) on the code and 
-- country_code fields respectively. Alias countries AS c and populations AS p.
-- Select code, name, and region from countries and also select year and 
-- fertility_rate from populations (5 fields in total).

SELECT
    c.code,
    name,
    region,
    year,
    fertility_rate
FROM
    countries AS c
    INNER JOIN populations AS p
    ON c.code = p.country_code;


--------------------------------------------------------------------------------

-- Add an additional INNER JOIN with economies to previous query by joining on code.
-- Include the unemployment_rate column that became available through joining with economies.

-- Select fields
SELECT c.code, name, region, e.year, fertility_rate, e.unemployment_rate
  -- From countries (alias as c)
  FROM countries AS c
  -- Join to populations (as p)
  INNER JOIN populations AS p
    -- Match on country code
    ON c.code = p.country_code
  -- Join to economies (as e)
  INNER JOIN economies AS e
    -- Match on country code
  ON c.code = e.code;


  ------------------------------------------------------------------------------


-- Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- From countries (alias as c)
  FROM countries AS c
  -- Join to populations (as p)
  INNER JOIN populations AS p
    -- Match on country code
    ON c.code = p.country_code
  -- Join to economies (as e)
  INNER JOIN economies AS e
    -- Match on country code and year
    ON c.code = e.code  AND e.year = p.year;


--------------------------------------------------------------------------------

-- Inner join countries on the left and languages on the 
-- right with USING(code)
-- Select the fields corresponding to:
-- country name AS country
-- continent name
-- language name AS language
-- Weather or not language is official

SELECT
  c.name AS country,
  continent,
  l.name AS language,
  official
FROM
  countries AS c
  INNER JOIN languages AS l
  USING (code);


--------------------------------------------------------------------------------
-- Self Join
-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
-- From populations (alias as p1)
FROM populations AS p1
  -- Join to itself (alias as p2)
  INNER JOIN populations AS p2
    -- Match on country code
    ON p1.country_code = p2.country_code
        -- and year (with calculation)
        AND p1.year = p2.year - 5;


-------------------------------------------------------------------------------

-- Calculating growth percentage

-- Select fields with aliases
-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- Calculate growth_perc
       ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
-- From populations (alias as p1)
FROM populations AS p1
  -- Join to itself (alias as p2)
  INNER JOIN populations AS p2
    -- Match on country code
    ON p1.country_code = p2.country_code
        -- and year (with calculation)
        AND p1.year = p2.year - 5;


--------------------------------------------------------------------------------


-- CASE WHEN AND THEN

-- Using the countries table, create a new field AS geosize_group that groups 
-- the countries into three groups:
-- If surface_area is greater than 2 million, geosize_group is 'large'.
-- If surface_area is greater than 350 thousand but not larger than 2 million, 
-- geosize_group is 'medium'. Otherwise, geosize_group is 'small'.

SELECT
  name,
  continent,
  surface_area,
  CASE WHEN surface_area > 2000000 THEN 'large'
       WHEN surface_area > 350000 AND surface_area < 2000000 THEN 'medium'
       ELSE 'small' END AS geosize_group
FROM countries;


--------------------------------------------------------------------------------
-- Using the populations table focused only for the year 2015, create a new 
-- field aliased as popsize_group to organize population size into
-- 'large' (> 50 million),
-- 'medium' (> 1 million), and
-- 'small' groups.
-- Select only the country code, population size, and this new popsize_group as fields.
SELECT
  country_code, size,
  CASE WHEN size > 5000000 THEN 'large'
       WHEN size > 1000000 AND size < 5000000 THEN 'medium'
       ELSE 'small' END
       AS popsize_group

FROM
  populations

WHERE year = 2015;

--------------------------------------------------------------------------------


-- LEFT JOIN

-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  INNER JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code DESC;



--------------------------------------------------------------------------------


-- FULL JOIN

-- Choose records in which region corresponds to North America or is NULL.

SELECT name, code, region, basic_unit
-- FROM countries
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;


--------------------------------------------------------------------------------


-- Choose records in which countries.name starts with the capital letter 'V' or is NULL.
-- Arrange by countries.name in ascending order to more clearly see the results.

SELECT countries.name, code, languages.name AS language
-- FROM language
FROM languages
  -- JOIN the countries
  FULL JOIN countries
  -- MATCH on code
  USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
  -- ORDER by ascending countries.name
ORDER BY countries.name;


--------------------------------------------------------------------------------


-- Complete a full join with countries on the left and languages on the right.
-- Next, full join this result with currencies on the right.
-- Use LIKE to choose the Melanesia and Micronesia regions (Hint: 'M%esia').
-- Select the fields corresponding to the country name AS country, region, 
-- language name AS language.


SELECT
  c.name AS country,
  region,
  l.name AS language

FROM
  countries AS c
FULL JOIN languages AS l
  USING (code)

WHERE region LIKE 'M%esia'
LIMIT 15;


--------------------------------------------------------------------------------


-- UNION
-- Combine the two new tables into one table containing all of the 
-- fields in economies2010

SELECT *
FROM economies2010
UNION ALL
SELECT *
FROM economies2015
ORDER BY code, year;


--------------------------------------------------------------------------------
-- UNION

-- Determine all (non-duplicated) country codes in either the cities or the 
-- currencies table. The result should be a table with only one field called country_code.
-- Sort by country_code in alphabetical order

SELECT
  country_code
FROM
  cities
UNION
SELECT
  code
FROM
  currencies
ORDER BY country_code;


--------------------------------------------------------------------------------

-- UNION ALL

SELECT country_code AS code, year
	FROM populations
	UNION ALL
SELECT code, year
	FROM economies
ORDER BY code, year;



--------------------------------------------------------------------------------

-- Intersect

-- Use INTERSECT to determine the records in common for country code and year 
-- for the economies and populations tables.





