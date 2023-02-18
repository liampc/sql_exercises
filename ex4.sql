CREATE DATABASE sql_exercises;
USE sql_exercises;

SET SQL_SAFE_UPDATES = 0; -- RUN to turn off safe updates to update/alter data
SET SQL_SAFE_UPDATES = 1; -- RUN to turn on safe updates again

CREATE TABLE Movies (
	code INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    rating VARCHAR(10),
    PRIMARY KEY(code)
);

CREATE TABLE MovieTheaters (
	code INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    movie INT,
    PRIMARY KEY(code),
    FOREIGN KEY(movie) REFERENCES Movies(code)
);

-- DATASET

 INSERT INTO Movies(Code,Title,Rating) VALUES(9,'Citizen King','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
 INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
 INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
 INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
 INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
 INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);
 
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);
 
 
 -- QUERIES
 
 -- 1. Select the title of all movies.
SELECT title FROM Movies;

-- 2. Show all the distinct ratings in the database.
SELECT DISTINCT rating FROM Movies;

-- 3. Show all unrated movies.
SELECT title FROM Movies 
WHERE rating IS NULL;

-- 4. Select all movie theaters that are not currently showing a movie.
SELECT name FROM MovieTheaters
WHERE movie IS NULL;

-- 5. Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT * FROM MovieTheaters
LEFT JOIN Movies ON MovieTheaters.movie = Movies.code; 

-- 6. Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * FROM MovieTheaters
RIGHT JOIN Movies ON MovieTheaters.movie = Movies.code; 

-- 7. Show the titles of movies not currently being shown in any theaters.
SELECT title FROM Movies
LEFT JOIN MovieTheaters ON Movies.code = MovieTheaters.movie
WHERE MovieTheaters.movie IS NULL;

-- 8. Add the unrated movie "One, Two, Three".
# check the last movie code
SELECT * FROM Movies
ORDER BY code DESC;

INSERT INTO Movies(code,title) VALUES(10,"One, Two, Three");

-- 9. Set the rating of all unrated movies to "G".
UPDATE Movies
SET rating = 'G'
WHERE rating IS NULL;

SELECT * FROM Movies;
-- 10. Remove movie theaters projecting movies rated "NC-17".

-- 11. Change Movie code as auto_increment, 
# USE TURNING OFF FOREIGN KEY CHECKS WITH TABLE LOCKS IF YOU DONT WANT YOUR DATA TO BE ALTERED 
# REFERENCE: https://stackoverflow.com/questions/13606469/cannot-change-column-used-in-a-foreign-key-constraint

SET FOREIGN_KEY_CHECKS = 0; -- > Turn off safety checks

ALTER TABLE Movies
MODIFY code INT NOT NULL AUTO_INCREMENT; -- >Do the modifications

SET FOREIGN_KEY_CHECKS = 1; -- > Turn on the safety checks

SELECT * FROM MovieTheaters;
INSERT INTO Movies(title) VALUES('How to Train Your Dragon');





