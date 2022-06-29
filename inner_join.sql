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


