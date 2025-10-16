-- 1. Create database called «lab4» 
CREATE DATABASE lab4;
-- 2. Create following tables «Warehouses» and «Boxes»: 
CREATE TABLE Warehouses(
    code INTEGER,
    location VARCHAR(255),
    capacity INTEGER
);
CREATE TABLE Boxes(
    code CHAR(4),
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER
);

-- 3. Download lab4.sql file from intranet. Copy content of the file 
-- and run using Query Tool (check if tables created)

-- [2025-10-16 13:58:01] lab4.public> INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3)
-- [2025-10-16 13:58:01] 1 row affected in 5 ms
-- [2025-10-16 13:58:01] lab4.public> INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4)
-- [2025-10-16 13:58:01] 1 row affected in 3 ms
-- [2025-10-16 13:58:01] lab4.public> INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7)
-- [2025-10-16 13:58:01] 1 row affected in 2 ms
-- [2025-10-16 13:58:01] lab4.public> INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2)
-- [2025-10-16 13:58:01] 1 row affected in 2 ms
-- [2025-10-16 13:58:01] lab4.public> INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8)
-- [2025-10-16 13:58:01] 1 row affected in 2 ms

-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('0MN7', 'Rocks', 180, 3)
-- [2025-10-16 13:59:36] 1 row affected in 12 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('4H8P', 'Rocks', 250, 1)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('4RT3', 'Scissors', 190, 4)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('7G3H', 'Rocks', 200, 1)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('8JN6', 'Papers', 75, 1)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('8Y6U', 'Papers', 50, 3)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('9J6F', 'Papers', 175, 2)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('LL08', 'Rocks', 140, 4)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:36] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('P0H6', 'Scissors', 125, 1)
-- [2025-10-16 13:59:36] 1 row affected in 2 ms
-- [2025-10-16 13:59:37] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('P2T6', 'Scissors', 150, 2)
-- [2025-10-16 13:59:37] 1 row affected in 2 ms
-- [2025-10-16 13:59:37] lab4.public> INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('TUSS', 'Papers', 90, 5)
-- [2025-10-16 13:59:37] 1 row affected in 1 ms

-- 4. Select all warehouses with all columns. 
SELECT * FROM warehouses;
-- 5. Select all boxes with a value larger than $150.
 SELECT * FROM boxes
WHERE value > 150;

-- 6. Select all the boxes distinct by contents. 
SELECT DISTINCT ON(contents) * FROM boxes;

-- 7. Select the warehouse code and the number of the boxes in 
-- each warehouse. 
SELECT warehouse, COUNT(*) AS num_of_boxes FROM boxes
GROUP BY warehouse
ORDER BY warehouse;
-- 8. Same as previous exercise, but select only those warehouses 
-- where the number of the boxes is greater than 2. 
SELECT warehouse, COUNT(*) AS num_of_boxes FROM boxes
GROUP BY warehouse
HAVING COUNT(*) > 2
ORDER BY warehouse;
-- 9. Create a new warehouse in New York with a capacity for 3 
-- boxes. 
INSERT INTO warehouses(code, location, capacity)
VALUES (
6, 'New York', 3
)
-- 10. Create a new box, with code "H5RT", containing "Papers" with 
-- a value of $200, and located in warehouse 2. 
INSERT INTO boxes(code, contents, value, warehouse)
VALUES(
'H5RT', 'Papers', 200, 2
)
-- 11. Reduce the value of the third largest box by 15%. 
UPDATE boxes
SET value = value * 0.85
WHERE code = (
    SELECT code FROM boxes
    ORDER BY value DESC
    OFFSET 2 LIMIT 1
    )
RETURNING *;

-- 12. Remove all boxes with a value lower than $150. 
DELETE FROM boxes
WHERE value < 150
RETURNING *;
-- 13. Remove all boxes which is located in New York. Statement 
-- should return all deleted data.
DELETE FROM boxes
WHERE warehouse IN(
    SELECT code FROM warehouses
    WHERE location = 'New York'
    )
RETURNING *;