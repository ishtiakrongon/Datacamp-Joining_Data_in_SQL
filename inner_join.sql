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


