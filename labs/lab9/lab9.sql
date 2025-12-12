
-- 1.  Create the following tables:
CREATE DATABASE lab9;

    -- 1. Create table Reviewer
CREATE TABLE Reviewer (
    reviewerID INT PRIMARY KEY,
    name VARCHAR(100)
);

    -- Insert data into Reviewer
INSERT INTO Reviewer (reviewerID, name) VALUES
(301, 'Alex Johnson'),
(302, 'Maria Gomez'),
(303, 'John Doe'),
(304, 'Linda Brown'),
(305, 'Michael Thompson'),
(306, 'Emily Davis'),
(307, 'Daniel White'),
(308, 'Sophia Lee');


    -- 2. Create table Movie
CREATE TABLE Movie (
    movieID INT PRIMARY KEY,
    title VARCHAR(100),
    releaseYear INT,
    director VARCHAR(100)
);

    -- Insert data into Movie
INSERT INTO Movie (movieID, title, releaseYear, director) VALUES
(401, 'Future World', 2024, 'Alice Smith'),
(402, 'The Last Adventure', 2024, 'John Black'),
(403, 'New Horizons', 2024, 'Maria Johnson'),
(404, 'Time Capsule', 2024, 'Chris Martin'),
(405, 'Beyond the Stars', 2024, NULL),
(406, 'The Silent Valley', 2024, 'Laura Green'),
(407, 'Lost in the Echo', 2024, 'Daniel White'),
(408, 'Shadow of Destiny', 2024, 'James Clarke');


    -- 3. Create table Review
CREATE TABLE Review (
    reviewerID INT,
    movieID INT,
    rating INT,
    reviewDate DATE,
    FOREIGN KEY (reviewerID) REFERENCES Reviewer(reviewerID),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);

    -- Insert data into Review
    -- Convert DD/MM/YY to DATE using TO_DATE
INSERT INTO Review (reviewerID, movieID, rating, reviewDate) VALUES
(301, 401, 5, TO_DATE('15/02/24', 'DD/MM/YY')),
(301, 402, 4, TO_DATE('20/02/24', 'DD/MM/YY')),
(302, 403, 5, TO_DATE('11/01/24', 'DD/MM/YY')),
(303, 404, 3, TO_DATE('23/01/24', 'DD/MM/YY')),
(304, 405, 4, TO_DATE('15/01/24', 'DD/MM/YY')),
(305, 406, 2, TO_DATE('01/03/24', 'DD/MM/YY')),
(306, 407, 5, TO_DATE('05/02/24', 'DD/MM/YY')),
(307, 408, 4, TO_DATE('12/03/24', 'DD/MM/YY'));

-- 2.  Create a view that lists all unique release years of movies that received a 
-- rating of 4 or higher, sorted by year in ascending order. 

CREATE VIEW movies_unique_rel_year_rating_4_v
AS SELECT DISTINCT releaseyear FROM movie
JOIN review ON movie.movieid = review.movieid
WHERE review.rating >= 4
ORDER BY releaseyear;

-- 3.  Add indexes to improve the performance of queries that use the view created 
-- in the previous step.
CREATE INDEX idx_review_movieid ON review(movieid);

CREATE INDEX idx_review_rating ON review(rating);

CREATE INDEX idx_releaseyear ON movie(releaseyear);

-- 4. Define a new role with privileges to log in and create additional roles.

CREATE ROLE role_manager
    LOGIN
    CREATEROLE;

--5.  Grant this new role all permissions that are typically available to a default 
-- user role. 

ALTER ROLE role_manager
    LOGIN
    CREATEDB
    INHERIT -- Allows you to inherit rights from other roles
    NOREPLICATION -- Regular users don't replicate
    NOSUPERUSER; 


-- 6.  Transfer ownership of all created tables from the root user to the new role.
ALTER TABLE movie OWNER TO role_manager;
ALTER TABLE review OWNER TO role_manager;
ALTER TABLE reviewer OWNER TO role_manager;

-- 7.  Create a view that shows the titles of all movies reviewed in 2024 with a 
-- rating of 5, along with the reviewer's name. Sort the results alphabetically by 
-- the movie title. 
CREATE VIEW movie_movies_in_2024_more_5_v
AS SELECT title, review.rating, reviewer.name AS reviewer_name
FROM movie
JOIN review on movie.movieid = review.movieid
JOIN reviewer ON review.reviewerid = reviewer.reviewerid
WHERE extract(YEAR FROM review.reviewdate) = 2024 AND review.rating = 5
ORDER BY title;

SELECT * FROM movie_movies_in_2024_more_5_v;
 