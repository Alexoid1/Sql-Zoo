-- Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population FROM world;

-- countries that have a population of at least 200 million. 200 million is 200000000
SELECT name FROM world
WHERE population > 200000000;

-- per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population
FROM world
WHERE population > 200000000;

--  'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000 
FROM world
WHERE continent='South America';

-- Show the name and population for France, Germany, Italy
SELECT name, population
FROM world
WHERE name IN('France','Germany', 'Italy');

--Show the countries which have a name that includes the word 'United'
SELECT name FROM world
where name LIKE '%United%';

-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name,population,area FROM world
WHERE population > 250000000 OR area > 3000000;

-- For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000,2) AS population, ROUND(GDP/1000000000,2) AS GDP  FROM world 
WHERE continent = 'South America';

-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(GDP/population,-3)
FROM world
WHERE GDP > 1000000000000;

-- Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital
  FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- Find the country that has all the vowels and no spaces in its name.
SELECT name
   FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%' 
AND name LIKE '%i%' 
AND name LIKE '%o%' 
AND name LIKE '%u%' 
AND name NOT LIKE '% %';
