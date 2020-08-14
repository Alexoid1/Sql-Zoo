-- Winners from 1950
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

-- 1962 Literature
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';

-- Albert Einstein
SELECT yr,subject FROM nobel
WHERE winner = 'Albert Einstein';

-- Recent Peace Prizes
SELECT winner
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000;

-- Literature in the 1980's
SELECT *
FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989;

-- Only Presidents
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                'Woodrow Wilson',
                'Jimmy Carter',
                'Barack Obama');

-- Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT *
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
OR (subject = 'Chemistry' AND yr = 1984);

-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT *
FROM nobel
WHERE yr = 1980
AND subject NOT IN ('Chemistry', 'Medicine');

-- Early Medicine, Late Literature
SELECT yr,subject, winner FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) 
OR (subject = 'Literature' AND yr >= 2004);

-- Find all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel
WHERE winner LIKE 'PETER GRÜNBERG';

-- Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
WHERE winner LIKE 'EUGENE O''NEILL';

-- List the winners, year and subject where the winner starts with Sir. 
-- Show the the most recent first, then by name order.
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'sir%'
ORDER BY yr DESC, winner;

-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY 
CASE 
WHEN subject IN ('Physics', 'Chemistry') THEN 1
ELSE 0
END , subject, winner

