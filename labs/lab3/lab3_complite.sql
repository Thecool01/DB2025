-- 3.1 Please write SQL queries for following tasks and save as .sql file. 
 
-- 1. Create a database called lab3. 
CREATE DATABASE lab3;
-- 2. Download and run the lab3.sql file using Query Tool (make sure the tables are created 
-- correctly). 

-- 3. SELECT the last name of all students. 
SELECT last_name FROM students;

-- 4. SELECT the last name of all students, without duplicates.
SELECT DISTINCT last_name FROM students; 

-- 5. SELECT all data of students whose last name is "Johnson." 
SELECT * FROM students
WHERE last_name = 'Johnson';

-- 6. SELECT all data of students whose last name is "Johnson" or "Smith." 
SELECT * FROM students
WHERE last_name = 'Johnson' OR last_name = 'Smith';

-- 7. SELECT all data of students who are registered in the "CS101" course.
SELECT * FROM students
JOIN registration ON students.student_id = registration.student_id
JOIN courses ON registration.course_id = courses.course_id
WHERE courses.course_code = 'CS101';

-- 8. SELECT all data of students who are registered in the "MATH201" or "PHYS301" 
-- courses. 
SELECT * FROM students
JOIN registration ON students.student_id = registration.student_id
JOIN courses ON registration.course_id = courses.course_id
WHERE courses.course_code = 'MATH201' or courses.course_code = 'PHYS301';

-- 9. SELECT the total number of credits for all courses. 
SELECT SUM(credits) AS total_credits FROM courses;
-- 10.  SELECT the number of students registered for each course. Show the course ID and 
-- the number of students. (Use the COUNT(*) operator for counting the number of 
-- students.) 
SELECT course_id, COUNT(*) AS number_of_students FROM registration -- Здесь без GROUP BY у нас бы вышел подсчет просто всех столбцов, но нам нужно ГРУППИРОВАТЬ по курсам и вывести количество студентов на каждый курс
GROUP BY course_id; 
-- 11.  SELECT the course ID with more than 2 students registered. 
SELECT course_id FROM registration
GROUP BY course_id HAVING COUNT(*) > 2; -- HAVING используется после группировки (в отличие от WHERE, который фильтрует строки до группировки).

-- 12.  SELECT the course name with the second-highest number of credits. 
SELECT course_name FROM courses
ORDER BY credits DESC
OFFSET 1 LIMIT 1;

-- 13.  SELECT the first and last names of students registered in the course with the fewest 
-- credits. 
-- 14.  SELECT the first and last names of all students from Almaty. 
-- 15.  SELECT all courses with more than 3 credits, sorted by increasing credits and 
-- decreasing course ID. 
-- 16.  Decrease the number of credits for the course with the fewest credits by 1. 
-- 17.  Reassign all students from the "MATH201" course to the "CS101" course. 
-- 18.  Delete from the table all students registered for the "CS101" course. 
-- 19.  Delete all students from the database.