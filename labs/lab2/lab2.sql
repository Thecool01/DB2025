-- 1.  Create a new database named lab_2. 
CREATE DATABASE lab2;

-- 2.  Create a table called employees with the following columns: 
-- • employee_id (Primary Key, Auto Increment) 
-- • first_name (VARCHAR for storing employee first names) 
-- • last_name (VARCHAR for storing employee last names) 
-- • department_id (INTEGER) 
-- • salary (INTEGER) 
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department_id INTEGER,
    salary INTEGER
);

-- 3.  Insert a row into the employees table with sample values for each 
-- column. 
INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES 
('Ivan', 'Petrov', 1, 50000);

-- 4.  Insert a row providing values only for the employee_id, first_name, 
-- and last_name columns. 
INSERT INTO employees (employee_id, first_name, last_name)
VALUES
(2, 'Olga', 'Sokolova');

-- 5.  Insert a row where the department_id column is set to NULL. 
-- поправим sequence 
SELECT setval('employees_employee_id_seq', (SELECT MAX(employee_id) FROM employees) + 1);

INSERT INTO employees (first_name, last_name, salary)
VALUES
('Natalia', 'Kuznetsova', 30000); 

-- 6.  Insert five rows at once into the employees table using a single INSERT 
-- statement. 
INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES
('Alexey', 'Lebedev', 2, 10000),
('Irina', 'Novikova', 3, 23400),
('Pavel', 'Kozlov', 4, 52300),
('Maria', 'Fedorova', 5, 44000),
('Victor', 'Mikhailov', 1, 25000);

-- 7.  Set a default value for the first_name column as 'John'. 
ALTER TABLE employees
ALTER COLUMN first_name SET DEFAULT 'John';

-- 8.  Insert a new row using the default value for the first_name column. 
INSERT INTO employees (last_name, department_id, salary)
VALUES
('Dablet', 8, 38000);

-- 9.  Insert a row where only default values are used for all columns. 
INSERT INTO employees DEFAULT VALUES;

-- 10. Create a duplicate of the employees table, named 
-- employees_archive, including all its structure using the LIKE 
-- keyword. 
CREATE TABLE employees_archive (LIKE employees);

-- 11. Copy all records from the employees table into the 
-- employees_archive table. 
INSERT INTO employees_archive 
SELECT * FROM employees;

-- 12. Update the salary for employees who belong to the department_id = 
-- NULL to set their department_id as 1. 
UPDATE employees_archive
SET department_id = 1
WHERE department_id IS NULL;

-- 13. Increase the salary of every employee by 15%. The query should return 
-- first_name, last_name, and the updated salary as Updated 
-- Salary (alias). 

UPDATE employees_archive
SET salary = salary + salary * 0.15
RETURNING first_name, last_name, salary AS "Updated Salary";

-- 14. Delete all employees who have a salary of less than 50,000. 
DELETE FROM employees
WHERE salary < 50000;

-- 15. Delete rows from the employees_archive table if their 
-- employee_id is present in the employees table. The query should 
-- return the deleted rows. 
DELETE FROM employees_archive
USING employees
WHERE employees_archive.employee_id = employees.employee_id
RETURNING *;

-- 16. Delete all rows from the employees table and return the deleted records.
DELETE FROM employees
RETURNING *;


ALTER SEQUENCE employees_employee_id_seq RESTART WITH 1; -- Если мы удалили все строки, то id будет начаинаться с начала