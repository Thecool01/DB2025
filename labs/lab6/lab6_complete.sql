-- Please write SQL queries for the following tasks and save them as a lab6.sql 
-- file. Use only joins. 
-- 1.  Create a database called lab_courses. 
CREATE DATABASE lab_courses;

-- 2.  Create the following tables:  
CREATE TABLE courses ( 
    course_id SERIAL PRIMARY KEY, 
    course_name VARCHAR(50), 
    course_code VARCHAR(10), 
    credits INTEGER 
); 
 
CREATE TABLE professors ( 
    professor_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    department VARCHAR(50) 
); 
 
CREATE TABLE students ( 
    student_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    major VARCHAR(50), 
    year_enrolled INTEGER 
); 
 
CREATE TABLE enrollments ( 
    enrollment_id SERIAL PRIMARY KEY, 
    student_id INTEGER REFERENCES students, 
    course_id INTEGER REFERENCES courses, 
    professor_id INTEGER REFERENCES professors, 
    enrollment_date DATE 
); 

-- Вставляем данные в таблицу courses
INSERT INTO courses (course_name, course_code, credits)
VALUES
('Database Systems', 'CS101', 4),           -- 1
('Operating Systems', 'CS102', 3),          -- 2
('Computer Networks', 'CS103', 4),          -- 3
('Mathematics I', 'MATH101', 5),            -- 4
('English Composition', 'ENG101', 2),       -- 5
('Artificial Intelligence', 'CS201', 4),    -- 6
('Physics I', 'PHYS101', 3);                -- 7

-- Вставляем данные в таблицу professors
INSERT INTO professors (first_name, last_name, department)
VALUES
('John', 'Smith', 'Computer Science'),          -- 1
('Emily', 'Johnson', 'Mathematics'),            -- 2
('Robert', 'Williams', 'Computer Science'),     -- 3
('Sophia', 'Brown', 'English'),                 -- 4
('Michael', 'Scott', 'Computer Science');       -- 5

-- Вставляем данные в таблицу students
INSERT INTO students (first_name, last_name, major, year_enrolled)
VALUES
('Alice', 'Miller', 'Computer Science', 2021),      -- 1
('Bob', 'Davis', 'Mathematics', 2020),              -- 2
('Charlie', 'Wilson', 'Engineering', 2022),         -- 3 
('Diana', 'Taylor', 'Computer Science', 2023),      -- 4
('Ethan', 'Moore', 'English', 2021),                -- 5
('Fiona', 'Anderson', 'Computer Science', 2019);    -- 6

-- Вставляем данные в таблицу enrollments
INSERT INTO enrollments (student_id, course_id, professor_id, enrollment_date)
VALUES
-- Alice
(1, 1, 1, '2021-09-15'),  -- Database Systems taught by John Smith
(1, 2, 1, '2021-09-16'),  -- Operating Systems taught by John Smith
-- Bob
(2, 4, 2, '2020-09-20'),  -- Mathematics I taught by Emily Johnson
(2, 5, 4, '2020-09-21'),  -- English Composition taught by Sophia Brown
-- Charlie
(3, 3, 3, '2022-02-10'),  -- Computer Networks taught by Robert Williams
-- Diana
(4, 6, 5, '2023-02-12'),  -- AI taught by Michael Scott
(4, 1, 1, '2023-02-13'),  -- Database Systems
-- Ethan
(5, 5, 4, '2021-09-14'),  -- English Composition taught by Sophia Brown
-- Fiona
(6, 1, 1, '2020-03-10'),  -- Database Systems before 2022
(6, 3, 3, '2020-03-12');  -- Computer Networks before 2022

 
-- 3.  Select the first name, last name of each student, the course they are 
-- enrolled in, and the last name of the professor for that course. 

SELECT students.first_name AS student_first_name,
       students.last_name AS student_last_name,
       courses.course_name,
       professors.last_name AS professor_last_name
FROM enrollments
JOIN students ON students.student_id = enrollments.student_id
JOIN courses ON courses.course_id = enrollments.course_id
JOIN professors ON professors.professor_id = enrollments.professor_id


-- 4.  Select the first and last names of students enrolled in courses with 
-- more than 3 credits. 
 
SELECT students.first_name,
       students.last_name,
       courses.course_name,
       courses.credits
FROM enrollments
JOIN students ON students.student_id = enrollments.student_id
JOIN courses ON courses.course_id = enrollments.course_id
WHERE credits > 3;

-- 5.  Select the course name and the number of students enrolled in each 
-- course. 
 
SELECT courses.course_name, COUNT(student_id) AS students_of_course FROM enrollments
JOIN courses ON courses.course_id = enrollments.course_id
GROUP BY courses.course_name

-- 6.  Select the first and last names of professors who teach at least one 
-- course. 

SELECT first_name, last_name FROM professors
WHERE exists(
    SELECT 1
    FROM enrollments
    WHERE enrollments.professor_id = professors.professor_id
)
 
-- 7.  Select the first and last names of students enrolled in courses taught 
-- by professors from the 'Computer Science' department. 

SELECT DISTINCT s.first_name, s.last_name FROM students s
JOIN enrollments ON s.student_id = enrollments.student_id
JOIN professors ON professors.professor_id = enrollments.professor_id
WHERE professors.department = 'Computer Science';
 
-- 8.  Select the course name, professor's last name, and the total number of 
-- credits for courses taught by professors whose last name starts with 
-- 'S'. 

SELECT professors.last_name,
       SUM(DISTINCT courses.credits) AS total_credits
       FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id
JOIN professors ON professors.professor_id = enrollments.professor_id
WHERE last_name LIKE 'S%'
GROUP BY professors.last_name;
 
-- 9.  Select all students who enrolled in courses before the year 2022. 

SELECT * FROM students
WHERE year_enrolled < 2022;

-- 10.  Select the names of all courses that have no students enrolled.

SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;
