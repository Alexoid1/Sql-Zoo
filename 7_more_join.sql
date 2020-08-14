-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
WHERE yr=1962;

-- When was Citizen Kane released?
SELECT yr
 FROM movie
WHERE movie.title='Citizen Kane';

-- Star Trek movies
SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

-- What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
WHERE name = 'Glenn Close' 

-- What is the id of the film 'Casablanca'
SELECT id FROM movie
WHERE title = 'Casablanca';

-- Cast list for Casablanca
SELECT actor.name FROM movie
JOIN casting
ON movie.id=casting.movieid
JOIN actor
ON actor.id=casting.actorid
WHERE movie.title = 'Casablanca';

-- Alien cast list
SELECT actor.name FROM movie
JOIN casting
ON movie.id=casting.movieid
JOIN actor
ON actor.id=casting.actorid
WHERE movie.title = 'Alien';

-- List the films in which 'Harrison Ford' has appeared
SELECT movie.title FROM movie
JOIN casting
ON movie.id=casting.movieid
JOIN actor
ON actor.id=casting.actorid
WHERE actor.name = 'Harrison Ford';

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title
FROM casting JOIN actor ON id = actorid 
INNER JOIN movie ON casting.movieid = movie.id
WHERE name='Harrison Ford' AND ord =1;

-- List the films together with the leading star for all 1962 films.
SELECT movie.title,actor.name FROM movie
JOIN casting
ON movie.id=casting.movieid
JOIN actor
ON actor.id=casting.actorid
WHERE movie.yr=1962 AND casting.ord=1;

-- Busy years for Rock Hudson
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- Lead actor in Julie Andrews movies
SELECT movie.yr ,COUNT(movie.title) FROM movie
JOIN casting
ON movie.id=casting.movieid
JOIN actor
ON actor.id=casting.actorid
WHERE actor.name = 'Rock Hudson'
GROUP BY yr
ORDER BY COUNT(movie.title) DESC LIMIT 2;

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE movie.id IN (SELECT casting.movieid
                    FROM casting
                    WHERE actorid = (SELECT id
                    FROM actor
                    WHERE name = 'Julie Andrews')
                    AND ord = 1);

-- Actors with 15 leading roles
SELECT name
FROM actor
JOIN casting ON id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(name) >= 15
ORDER BY name;

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title,COUNT(actorid) 
FROM movie
JOIN casting ON movie.id = casting.movieid
WHERE movie.yr = 1978
GROUP BY title
ORDER BY COUNT(casting.actorid)DESC,title ;

-- List all the people who have worked with 'Art Garfunkel'.
SELECT name
FROM actor
JOIN casting ON id = casting.actorid
WHERE movieid IN
             (SELECT movieid
              FROM casting
              WHERE actorid =
                             (SELECT id
                              FROM actor
                              WHERE name = 'Art Garfunkel'))
                              AND name <> 'Art Garfunkel'
ORDER BY name
