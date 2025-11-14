-- 1. Create a database called `library_db`. 
CREATE DATABASE library_db;
-- 2. Create the following tables `members`, `borrowings`, and `librarians` with the provided structure and data.

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

-- 3. Create a view that displays all librarians located in the city of New York. 
CREATE VIEW librarians_new_york_v
AS SELECT librarian_id, name FROM librarians
WHERE city = 'New York';

SELECT * FROM librarians_new_york_v;

-- 4. Create a view that shows each borrowing record with the librarian's and 
-- member's names. Grant SELECT privileges on this view to the library_user 
-- role.

CREATE VIEW borrowing_details_v
AS SELECT borrowing_id, borrow_date, return_date,
          members.member_name, librarians.name AS lib_name, borrowings.book_id
FROM borrowings
JOIN members ON borrowings.member_id = members.member_id
JOIN librarians ON borrowings.librarian_id = librarians.librarian_id;

SELECT * FROM borrowing_details_v;

CREATE ROLE library_user;

GRANT SELECT ON borrowing_details_v TO library_user;

-- 5. Create a view that shows all members who have the highest membership 
-- level. Grant only SELECT privileges on this view to the library_user role.

CREATE VIEW members_max_level_v
AS SELECT member_id, member_name, membership_level FROM members
WHERE membership_level IN (
    SELECT max(membership_level)
    FROM members
    );

SELECT * FROM members_max_level_v;

GRANT SELECT ON members_max_level_v TO library_user;

-- 6. Create a view that shows the count of librarians in each city. 

CREATE VIEW count_lib_cities_v
AS SELECT city, count(*) FROM librarians
GROUP BY city;

SELECT * FROM count_lib_cities_v;

-- 7. Create a view that shows each librarian who is associated with more than 
-- one unique member. 

CREATE VIEW librarians_multiple_members_v
AS SELECT librarians.librarian_id, librarians.name, librarians.city,
          COUNT(DISTINCT members.member_id) AS member_count
FROM librarians
JOIN members ON librarians.librarian_id = members.librarian_id
GROUP BY librarians.librarian_id, librarians.name, librarians.city
HAVING COUNT(DISTINCT members.member_id) > 1;

SELECT * FROM librarians_new_york_v;

-- 8. Create a role named intern and grant it all privileges of the library_user 
-- role. 

CREATE ROLE intern;

GRANT library_user TO intern;