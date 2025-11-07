-- 1. Create a database called `library_db`. 
CREATE DATABASE library_db;
-- 2. Create the following tables `members`, `borrowings`, and `librarians` with 
-- the provided structure and data. 
CREATE TABLE librarians(
    librarian_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission REAL
);

CREATE TABLE members(
    member_id INTEGER PRIMARY KEY,
    member_name VARCHAR(100),
    city VARCHAR(100),
    membership_level INTEGER,
    librarian_id INTEGER,
    FOREIGN KEY(librarian_id) REFERENCES librarians(librarian_id)
);

CREATE TABLE borrowings(
    borrowing_id INTEGER PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INTEGER,
    librarian_id INTEGER,
    book_id INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id),
    FOREIGN KEY(librarian_id) REFERENCES librarians(librarian_id)
)

-- 1. Librarians
INSERT INTO librarians (librarian_id, name, city, commission) VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);

-- 2. Members
INSERT INTO members (member_id, member_name, city, membership_level, librarian_id) VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

-- 3. Borrowings
INSERT INTO borrowings (borrowing_id, borrow_date, return_date, member_id, librarian_id, book_id) VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-20', '2024-02-29', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);

-- 3. Select the total number of borrowings made by all members over the past 
-- 5 years (from 2020 to 2024).
SELECT COUNT(*) AS total_num_of_borrowings FROM borrowings
WHERE extract(YEAR FROM borrow_date) BETWEEN 2020 AND 2024;

-- 4. Select the average membership level of all members. 
SELECT int2(avg(membership_level)) FROM members; -- If we need integer
SELECT round(avg(membership_level), 2) FROM members; -- If we need float

-- 5. Select how many members are from 'New York'. 
SELECT COUNT(*) AS members_in_newyork FROM members
WHERE city = 'New York';
-- 6. Select the earliest borrowing date from the `borrowings` table. 
SELECT min(borrow_date) AS earliest_borrow_date FROM borrowings

-- 7. Select the member name and city of all members whose name ends with 
-- the letter 'n'. 

SELECT member_name, city FROM members
WHERE member_name LIKE '%n'; -- If just for column member_name

SELECT member_name
FROM members
WHERE SPLIT_PART(member_name, ' ', 1) LIKE '%n'; -- If for name


-- 8. Select all borrowings managed by librarians from 'Paris' between the dates 
-- '2021-01-01' and '2023-12-31'. 
SELECT * FROM borrowings
JOIN librarians ON borrowings.librarian_id = librarians.librarian_id
WHERE librarians.city = 'Paris' AND borrow_date BETWEEN '2021-01-01' AND '2023-12-31';

-- 9. Select all borrowings where the `borrow_date` is after '2023-01-01'. 
SELECT * FROM borrowings
WHERE borrow_date > '2023-01-01';

-- 10. Select the total number of books borrowed by each member. 
SELECT member_name, COUNT(*) AS number_of_books FROM members 
JOIN borrowings ON members.member_id = borrowings.member_id 
GROUP BY member_name;

-- 11. Select all members who have a membership level of 3. 
SELECT * FROM members
WHERE membership_level = 3;

-- 12. Select the librarian with the highest commission. 
SELECT name FROM librarians
WHERE commission IN(
    SELECT max(commission) FROM librarians
    )