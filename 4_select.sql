-- List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
   WHERE continent = 'Europe' AND GDP/population>(
   SELECT gdp/population FROM world WHERE name = 'United Kingdom'
);

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name,continent FROM world
WHERE continent =(
SELECT continent FROM world 
WHERE name='Argentina')
OR continent =(SELECT continent FROM world 
WHERE name='Australia')
ORDER BY name;

-- Between Canada and Poland
SELECT name,population FROM world
WHERE population >(
SELECT population FROM world 
WHERE name='Canada')
AND population <(SELECT population FROM world 
WHERE name='Poland');

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name,
       CONCAT(CAST(ROUND(population * 100 /
       (SELECT population
        FROM world
        WHERE name = 'germany'), 0) AS int), '%')
        AS percentage
FROM world
WHERE continent = 'Europe';

-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp)
                FROM world
                WHERE gdp > 0 AND continent = 'Europe');

-- Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area
FROM world AS x
WHERE area >=
      ALL
      (SELECT area
       FROM world AS y
       WHERE y.continent = x.continent
       AND area > 0);

-- First country of each continent (alphabetically)
SELECT continent, name
FROM world x
WHERE name <= ALL
             (SELECT name FROM world y
              WHERE y.continent = x.continent);

-- Find the continents where all countries have a population <= 25000000.
SELECT name, continent, population
FROM world
WHERE continent NOT IN
     (SELECT DISTINCT continent
      FROM world
      WHERE population > 25000000);

-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world x
WHERE population > ALL(SELECT population * 3
                       FROM world y
                       WHERE x.continent = y.continent
                       AND x.name <> y.name);      
