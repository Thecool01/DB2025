-- 3. Database and Tables

CREATE DATABASE library_managment_system;

-- Tables


-- Authors

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    birth_year INT
);



-- Categories

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);



-- Books

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT REFERENCES authors(author_id) ON DELETE CASCADE,
    category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
    pages INT CHECK (pages > 0),
    total_copies INT CHECK (total_copies > 0),
    available_copies INT CHECK (available_copies >= 0),
    price NUMERIC CHECK (price > 0)
);



-- Members

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    age INT CHECK (age >= 12),
    registration_date DATE NOT NULL
);



-- Librarians

CREATE TABLE librarians (
    librarian_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);



-- Borrowings

CREATE TABLE borrowings (
    borrowing_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id) ON DELETE CASCADE,
    member_id INT REFERENCES members(member_id) ON DELETE CASCADE,
    librarian_id INT REFERENCES librarians(librarian_id) ON DELETE SET NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) 
        CHECK (status IN ('borrowed', 'returned', 'overdue'))
);




-- 4. Insert Sample Data --


-- Authors 

INSERT INTO authors (name, country, birth_year) VALUES
('J.K. Rowling', 'UK', 1965),
('George Orwell', 'UK', 1903),
('Leo Tolstoy', 'Russia', 1828),
('Agatha Christie', 'UK', 1890),
('Mark Twain', 'USA', 1835),
('Ernest Hemingway', 'USA', 1899),
('Fyodor Dostoevsky', 'Russia', 1821),
('J.R.R. Tolkien', 'UK', 1892),
('Stephen King', 'USA', 1947),
('Arthur Conan Doyle', 'UK', 1859),
('Gabriel Garcia Marquez', 'Colombia', 1927),
('Paulo Coelho', 'Brazil', 1947),
('Haruki Murakami', 'Japan', 1949),
('Dan Brown', 'USA', 1964),
('Oscar Wilde', 'Ireland', 1854),
('Victor Hugo', 'France', 1802),
('Jules Verne', 'France', 1828),
('H.G. Wells', 'UK', 1866),
('Alexandre Dumas', 'France', 1802),
('Jane Austen', 'UK', 1775);



-- Categories 

INSERT INTO categories (name) VALUES
('Fantasy'),
('Classic'),
('Science Fiction'),
('Mystery'),
('Romance'),
('Thriller'),
('Drama'),
('Adventure'),
('Historical'),
('Psychology'),
('Detective'),
('Horror'),
('Philosophy'),
('Biography'),
('Children'),
('Young Adult'),
('Poetry'),
('Humor'),
('Fairy Tale'),
('Self-help');



-- Books 

INSERT INTO books (title, author_id, category_id, pages, total_copies, available_copies, price) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 1, 320, 10, 7, 25),
('1984', 2, 2, 328, 8, 5, 18),
('War and Peace', 3, 9, 1225, 5, 3, 30),
('Murder on the Orient Express', 4, 4, 256, 7, 6, 20),
('Tom Sawyer', 5, 8, 274, 9, 8, 15),
('The Old Man and the Sea', 6, 7, 127, 6, 4, 12),
('Crime and Punishment', 7, 2, 671, 10, 6, 22),
('The Hobbit', 8, 1, 310, 12, 10, 28),
('The Shining', 9, 12, 447, 8, 4, 24),
('Sherlock Holmes', 10, 11, 350, 14, 10, 19),
('Love in the Time of Cholera', 11, 5, 348, 5, 2, 21),
('The Alchemist', 12, 14, 208, 9, 7, 17),
('Kafka on the Shore', 13, 10, 505, 7, 5, 23),
('The Da Vinci Code', 14, 6, 454, 11, 9, 29),
('The Picture of Dorian Gray', 15, 2, 254, 6, 3, 16),
('Les Misérables', 16, 9, 1463, 4, 2, 35),
('Journey to the Center of the Earth', 17, 3, 183, 10, 9, 18),
('The Time Machine', 18, 3, 118, 6, 4, 14),
('The Count of Monte Cristo', 19, 8, 1312, 5, 3, 32),
('Pride and Prejudice', 20, 5, 279, 12, 11, 20);



-- Members 

INSERT INTO members (full_name, email, phone, age, registration_date) VALUES
('Ali Serik', 'ali@mail.com', '8707000001', 18, '2024-01-10'),
('Dana Kairat', 'dana@mail.com', '8707000002', 22, '2024-02-12'),
('Aruzhan Toleu', 'aruzhan@mail.com', '8707000003', 16, '2024-03-05'),
('Madi Nurlan', 'madi@mail.com', '8707000004', 30, '2024-03-12'),
('Erkin Omar', 'erkin@mail.com', '8707000005', 45, '2024-04-01'),
('Samat Ali', 'samat@mail.com', '8707000006', 19, '2024-04-11'),
('Karina Tolegen', 'karina@mail.com', '8707000007', 21, '2024-05-03'),
('Timur Askar', 'timur@mail.com', '8707000008', 23, '2024-05-17'),
('Adina Zhaksy', 'adina@mail.com', '8707000009', 32, '2024-06-01'),
('Yerkebulan Serik', 'yerke@mail.com', '8707000010', 27, '2024-06-12'),
('Aisha Kazy', 'aisha@mail.com', '8707000011', 14, '2024-06-20'),
('Nuray Ospan', 'nuray@mail.com', '8707000012', 17, '2024-07-01'),
('Sanzhar Ilyas', 'sanzhar@mail.com', '8707000013', 25, '2024-07-11'),
('Amina Kainar', 'amina@mail.com', '8707000014', 28, '2024-07-21'),
('Dauren Malik', 'dauren@mail.com', '8707000015', 40, '2024-08-01'),
('Ayaulym Serik', 'aya@mail.com', '8707000016', 19, '2024-08-14'),
('Arman Bolat', 'arman@mail.com', '8707000017', 16, '2024-09-01'),
('Saltanat Mira', 'saltanat@mail.com', '8707000018', 22, '2024-09-11'),
('Dias Yerzhan', 'dias@mail.com', '8707000019', 20, '2024-10-03'),
('Zhanel Tursyn', 'zhanel@mail.com', '8707000020', 18, '2024-10-14');



-- Librarians 

INSERT INTO librarians (name, email) VALUES
('Alina Omar', 'alina.librarian@mail.com'),
('Samat Nurtas', 'samat.librarian@mail.com'),
('Aruzhan Serik', 'aruzhan.librarian@mail.com'),
('Bauyrzhan Kassym', 'bauyr.librarian@mail.com'),
('Gulnaz Rym', 'gulnaz.librarian@mail.com'),
('Mira Zhuma', 'mira.librarian@mail.com'),
('Aidos Temir', 'aidos.librarian@mail.com'),
('Dana Arman', 'dana.librarian@mail.com'),
('Serik Ulan', 'serik.librarian@mail.com'),
('Karina Uais', 'karina.librarian@mail.com'),
('Maksat Omar', 'maksat.librarian@mail.com'),
('Nurlybaev Dias', 'dias.librarian@mail.com'),
('Aya Abzal', 'aya.librarian@mail.com'),
('Nuriya Beks', 'nuriya.librarian@mail.com'),
('Tamerlan Sarsen', 'tamerlan.librarian@mail.com'),
('Eldar Rakhat', 'eldar.librarian@mail.com'),
('Zhaina Riza', 'zhaina.librarian@mail.com'),
('Askar Nur', 'askar.librarian@mail.com'),
('Marat Kairat', 'marat.librarian@mail.com'),
('Asem Saila', 'asem.librarian@mail.com');



-- Borrowings 

INSERT INTO borrowings (book_id, member_id, librarian_id, borrow_date, return_date, status) VALUES
(1, 1, 1, '2024-02-01', NULL, 'borrowed'),
(2, 2, 1, '2024-02-05', '2024-02-20', 'returned'),
(3, 3, 2, '2024-03-01', NULL, 'overdue'),
(4, 4, 3, '2024-03-10', NULL, 'borrowed'),
(5, 5, 3, '2024-03-12', '2024-03-25', 'returned'),
(6, 6, 4, '2024-03-15', NULL, 'borrowed'),
(7, 7, 5, '2024-03-18', NULL, 'borrowed'),
(8, 8, 6, '2024-04-01', NULL, 'borrowed'),
(9, 9, 6, '2024-04-03', '2024-04-18', 'returned'),
(10, 10, 7, '2024-04-10', NULL, 'overdue'),
(11, 11, 8, '2024-04-15', '2024-04-30', 'returned'),
(12, 12, 8, '2024-05-01', NULL, 'borrowed'),
(13, 13, 9, '2024-05-05', NULL, 'borrowed'),
(14, 14, 9, '2024-05-07', '2024-05-21', 'returned'),
(15, 15, 10, '2024-05-10', NULL, 'borrowed'),
(16, 16, 11, '2024-06-01', NULL, 'borrowed'),
(17, 17, 11, '2024-06-03', '2024-06-20', 'returned'),
(18, 18, 12, '2024-06-10', NULL, 'borrowed'),
(19, 19, 13, '2024-06-15', NULL, 'borrowed'),
(20, 20, 14, '2024-06-20', '2024-07-02', 'returned'),
(1, 5, 2, '2024-07-01', '2024-07-15', 'returned'),
(1, 7, 4, '2024-08-10', NULL, 'borrowed'),
(1, 12, 3, '2024-09-05', NULL, 'borrowed'),
(2, 8, 6, '2024-07-20', '2024-08-01', 'returned'),
(2, 14, 2, '2024-09-12', NULL, 'borrowed'),
(8, 3, 5, '2024-07-03', NULL, 'borrowed'),
(8, 9, 1, '2024-08-21', '2024-09-01', 'returned'),
(8, 15, 7, '2024-09-10', NULL, 'borrowed'),
(10, 11, 4, '2024-08-02', NULL, 'borrowed'),
(10, 6, 8, '2024-08-19', '2024-09-01', 'returned');



-- 5. Create Indexes --


-- Simple B-tree index

CREATE INDEX idx_books_title
ON books(title);

-- USING 
SELECT * FROM books WHERE title = 'The Hobbit';


-- Composite (multi-column) index

CREATE INDEX idx_borrowinds_book_member
ON borrowings(book_id, member_id);

-- USING WHEN
SELECT * FROM borrowings
WHERE book_id = 5 AND member_id = 3;

-- Unique Index

CREATE UNIQUE INDEX idx_members_email
ON members(email);

-- Functional Index

CREATE INDEX idx_members_registration_year
ON members (DATE_PART('year', registration_date));

-- USING WHEN
SELECT * FROM members
WHERE DATE_PART('year', registration_date) = 2024;


-- Partial Index

CREATE INDEX idx_borrowings_active
ON borrowings(borrow_date)
WHERE status = 'borrowed';

-- USING WHEN
SELECT * FROM borrowings WHERE status = 'borrowed';


-- 1) INNER JOIN -- A list of all search results with the title of the book and the name of the reader
SELECT borrowing_id,
       books.title,
       members.full_name,
       librarians.name AS librarian_name,
       borrow_date, status FROM borrowings
JOIN books ON borrowings.book_id = books.book_id
JOIN members ON borrowings.member_id = members.member_id
JOIN librarians ON librarians.librarian_id = borrowings.librarian_id

-- 2) INNER JOIN -- Find the most popular books (by the number of loans)
SELECT books.title,
       count(borrowing_id) AS total_borrowings FROM borrowings
INNER JOIN books ON books.book_id = borrowings.book_id
GROUP BY title
ORDER BY total_borrowings DESC 
LIMIT 5;
-- Uses index: idx_borrowings_book_member.


-- 3) LEFT JOIN
SELECT
    categories.name AS category,
    COUNT(books.book_id) AS book_count
FROM categories
LEFT JOIN books ON categories.category_id = books.category_id
GROUP BY name
ORDER BY book_count DESC;
-- Even categories without books will appear.


-- 4) LEFT JOIN
SELECT title
FROM books
LEFT JOIN borrowings ON books.book_id = borrowings.book_id
WHERE borrowings.borrowing_id IS NULL;
-- Find books that no one took


-- 5) GROUP BY + aggregates -- number of readers by age group
SELECT 
    age,
    COUNT(member_id) AS total_members
FROM members
GROUP BY age
ORDER BY total_members DESC;

-- 6) WHERE
SELECT title, categories.name AS category_name
FROM books
JOIN categories ON books.category_id = categories.category_id
WHERE categories.name = 'Fantasy';

-- 7) WHERE
SELECT *
FROM books
WHERE price > (SELECT AVG(price) FROM books);


-- 8) Subquery in FROM: TOP-3 readers by the number of books borrowed
SELECT members.full_name, S.borrow_count
FROM (
    SELECT member_id, count(*) AS borrow_count
    FROM borrowings
    GROUP BY member_id
    ORDER BY borrow_count DESC
    LIMIT 3
     ) AS S
JOIN members ON S.member_id = members.member_id;

-- 9) ORDER BY + LIMIT: 10 last results

SELECT
    borrowing_id,
    books.title,
    members.full_name,
    borrow_date
FROM borrowings
INNER JOIN books ON borrowings.book_id = books.book_id
INNER JOIN members ON borrowings.member_id = members.member_id
ORDER BY borrow_date DESC
LIMIT 10;

-- 10) LOWER()
SELECT *
FROM books
WHERE LOWER(title) = 'the hobbit';

--  Uses an index: idx_books_lower_title

-- 11) WHERE -- Find all overdue issuances

SELECT
    borrowing_id,
    books.title,
    members.full_name,
    borrow_date
FROM borrowings
INNER JOIN books ON books.book_id = borrowings.book_id
INNER JOIN members ON members.member_id = borrowings.member_id
WHERE status = 'overdue';

-- 12) Using partial index

SELECT *
FROM borrowings
WHERE status = 'borrowed'
ORDER BY borrow_date DESC;

-- Index : idx_borrowings_active ON borrowings(borrow_date) WHERE status='borrowed'


-- 7. Roles and Users --

-- ADMIN 
CREATE ROLE admin;


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- MANAGER
CREATE ROLE manager;

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO manager;

-- VIEWER 
CREATE ROLE viewer;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO viewer;

-- Librarian
CREATE USER librarian_user WITH PASSWORD 'password123';
GRANT manager TO librarian_user;

-- Student
CREATE USER student_user WITH PASSWORD 'password123';
GRANT viewer TO student_user;

-- Admin
CREATE USER admin_user WITH PASSWORD 'password123';
GRANT admin TO admin_user;


-- 8. Additional Component

-- TRANSACTION

DO $$
DECLARE
    v_available INT;
BEGIN
    -- Check the number of available copies for the selected book
    SELECT available_copies INTO v_available
    FROM books
    WHERE book_id = 8
    FOR UPDATE;  -- lock this row to prevent concurrent changes

    -- IF ELSE logic to decide whether the book can be issued
    IF v_available > 0 THEN

        -- Insert a new borrowing record
        INSERT INTO borrowings (book_id, member_id, librarian_id, borrow_date, status)
        VALUES (8, 5, 2, CURRENT_DATE, 'borrowed');

        -- Reduce the available copies count by 1
        UPDATE books
        SET available_copies = available_copies - 1
        WHERE book_id = 8;

        -- Show confirmation message
        RAISE NOTICE 'Book successfully issued. Remaining copies: %', v_available - 1;

    ELSE

        -- If no copies are available, cancel the operation
        RAISE NOTICE 'Error: No available copies of this book. Operation canceled.';

        -- To simulate ROLLBACK inside DO block:
        -- Raise an exception so the whole block is rolled back
        RAISE EXCEPTION 'Not enough copies';

    END IF;

END $$;

-- 9. Data Analysis -- 

-- 1. Top 3 most popular books (by number of borrowings)

SELECT 
    books.title,
    COUNT(borrowing_id) AS total_borrowed
FROM borrowings
JOIN books ON borrowings.book_id = books.book_id
GROUP BY books.title
ORDER BY total_borrowed DESC
LIMIT 3;

-- 2. Least Used Books (Taken 0 Times)

SELECT 
    books.title
FROM books
LEFT JOIN borrowings ON books.book_id = borrowings.book_id
WHERE borrowings.borrowing_id IS NULL;


-- 3. Total Library Income
SELECT 
    SUM(books.price) AS total_revenue
FROM borrowings
JOIN books ON borrowings.book_id = books.book_id;

-- 4. Top 3 Most Active Readers
SELECT 
    members.full_name,
    COUNT(b.borrowing_id) AS borrow_count
FROM borrowings b
JOIN members ON members.member_id = b.member_id
GROUP BY members.full_name
ORDER BY borrow_count DESC
LIMIT 3;