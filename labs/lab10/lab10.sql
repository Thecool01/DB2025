-- Database Structure: Movie Rental System

CREATE DATABASE Movies Rental System;
Tables: 
1.  Movies
    movie_id (Primary Key, Integer) 
    • title (Varchar) 
    • genre (Varchar) 
    • price_per_day (Decimal) 
    • available_copies (Integer) 

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    price_per_day DECIMAL(6,2),
    available_copies INT
);


INSERT INTO Movies (movie_id, title, genre, price_per_day, available_copies) VALUES
(1, 'The Matrix', 'Sci-Fi', 5.00, 8),
(2, 'Titanic', 'Romance', 3.50, 12),
(3, 'Avengers: Endgame', 'Action', 6.00, 5);



2.  Rentals 
    • rental_id (Primary Key, Integer) 
    • movie_id (Foreign Key, Integer) 
    • customer_id (Integer) 
    • rental_date (Date) 
    • quantity (Integer) 

CREATE TABLE Rentals (
    rental_id INT PRIMARY KEY,
    movie_id INT,
    customer_id INT,
    rental_date DATE,
    quantity INT,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Rentals (rental_id, movie_id, customer_id, rental_date, quantity) VALUES
(1, 1, 201, '2024-11-01', 2),
(2, 2, 202, '2024-11-03', 1),
(3, 3, 201, '2024-11-05', 3);


3.  Customers 
    • customer_id (Primary Key, Integer) 
    • name (Varchar) 
    • email (Varchar)

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO Customers (customer_id, name, email) VALUES
(201, 'Alice Johnson', 'alice.j@example.com'),
(202, 'Bob Smith', 'bob.smith@example.com');

    1. Transaction for Renting a Movie 
        • Scenario: A customer rents a movie. This should decrease the available 
        copies of the movie in the Movies table and create a new record in the 
        Rentals table. 
        • Task: 
        • Start a transaction. 
        • Insert a rental record into the Rentals table for customer_id 201 
        renting 2 copies of movie_id 1. 
        • Update the Movies table to decrease the available_copies of 
        movie_id 1 by 2. 
        • Commit the transaction. 
        • Expected Outcome: The Rentals table contains a new record, 
        and the Movies table shows 6 as the new available_copies for 
        movie_id 1.

BEGIN;

INSERT INTO rentals(rental_id, movie_id, customer_id, rental_date, quantity)
VALUES (
        (SELECT COALESCE(MAX(rental_id), 0) + 1 FROM rentals),-- генерируем новый ID
        1,
        201,
        CURRENT_DATE,
        2
       );

-- 2. Update Movies: decrease available copies
UPDATE movies
SET available_copies = available_copies - 2
WHERE movie_id = 1;

-- 3. Commit transaction
COMMIT;


    2. Transaction with Rollback 
        • Scenario: A customer attempts to rent more movies than are available, 
        which should not be allowed. 
        • Task: 
        • Start a transaction. 
        • Attempt to insert a rental record into the Rentals table for 
        customer_id 202 renting 10 copies of movie_id 3. 
        • Check if the available_copies in the Movies table is sufficient. If 
        not, rollback the transaction. 
        • Expected Outcome: No changes are made to the Rentals or 
        Movies tables due to the rollback

DO $$
DECLARE
    available INT;
    requested INT := 10;
BEGIN
    -- Получаем доступные копии с блокировкой
    SELECT available_copies
    INTO available
    FROM Movies
    WHERE movie_id = 3
    FOR UPDATE;

    -- Проверяем, хватает ли копий
    IF available >= requested THEN

        -- Если копий достаточно → выполняем вставку и обновление
        INSERT INTO Rentals (rental_id, movie_id, customer_id, rental_date, quantity)
        VALUES (
            (SELECT COALESCE(MAX(rental_id), 0) + 1 FROM Rentals),
            3,
            202,
            CURRENT_DATE,
            requested
        );

        UPDATE Movies
        SET available_copies = available_copies - requested
        WHERE movie_id = 3;

        RAISE NOTICE 'Transaction committed: rented % copies.', requested;

    ELSE

        -- Копий недостаточно → выводим сообщение и НЕ выполняем изменения
        RAISE NOTICE 'Transaction rolled back: only % available, but % requested.',
                     available, requested;

        -- Исключение НЕ вызываем

    END IF;

END $$;

3. Demonstration of Isolation Levels 
    • Scenario: Show the effects of different isolation levels in concurrent 
    transactions. 
    • Task: 
    • In one session, start a transaction with the READ COMMITTED 
    isolation level and update the price_per_day of a movie in the 
    Movies table. 
    • In a second session, start another transaction at the same isolation 
    level and read the price_per_day of the same movie. 
    • Commit the first transaction and re-read the price_per_day in the 
    second session. 
    • Expected Outcome: The second session reads the updated price 
    after the first transaction commits, demonstrating the READ 
    COMMITTED isolation level.


-- SESSION 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;

UPDATE movies
SET price_per_day = 7.20
WHERE movie_id = 3;

-- WAIT (!)
-- no COMMIT yet

-- SESSION 2

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;

SELECT price_per_day FROM movies
WHERE movie_id = 3;
-- result → 6.00

COMMIT;

-- After Session 1 commits:
SELECT price_per_day FROM Movies WHERE movie_id = 2;
-- result → 7.50

    4. Durability Check 
        • Scenario: Ensure that changes made by a transaction are permanent. 
        • Task: 
        • Perform a transaction to update a customers email in the 
        Customers table. 
        • Commit the transaction. 
        • Restart the database server. 
        • Check the Customers table for the update. 
        • Expected Outcome: The new email persists even after the 
        database restart, demonstrating durability.

BEGIN;

UPDATE Customers
SET email = 'alice.newemail@example.com'
WHERE customer_id = 201;

COMMIT;

-- mac os : sudo /Library/PostgreSQL/17/bin/pg_ctl restart -D /Library/PostgreSQL/17/data

