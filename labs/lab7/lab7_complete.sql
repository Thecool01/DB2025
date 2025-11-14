-- 1. Create a simple B-tree index for queries like: 

SELECT * FROM employees WHERE last_name = 'string';

CREATE INDEX idx_employees_last_name
ON employees(last_name);

-- 2. Create a composite (multicolumn) index for queries like: 
SELECT * FROM employees WHERE department = 'string' AND salary > 
value; 

CREATE INDEX idx_employees_department_salary
ON employees (department, salary);

-- 3. Create a unique index for queries like: 
SELECT * FROM employees WHERE email = 'string'; 

CREATE UNIQUE INDEX idx_employees_email_unique
ON employees (email);

-- 4. Create a functional index for queries like: 
SELECT * FROM employees WHERE LOWER(email) = 'string';

CREATE INDEX idx_employees_lower_email
ON employees (LOWER(email));

-- 5. Create a hash index for queries like: 
SELECT * FROM employees WHERE department = 'string'; 

CREATE INDEX idx_employees_department_hash
ON employees USING HASH (department);

-- 6. Create a BRIN index for queries like: 
SELECT * FROM employees WHERE salary BETWEEN value1 AND value2; 

CREATE INDEX idx_employees_salary_brin
ON employees USING BRIN (salary);

-- 7. Create a partial index for queries like: 
SELECT * FROM employees WHERE salary > 1000; 

CREATE INDEX idx_employees_salary_partial
ON employees (salary)
WHERE salary > 1000;

-- 8. Create a GiST index for range queries like: 
SELECT * FROM rooms WHERE area && numrange(value1, value2); 

CREATE INDEX idx_rooms_area_gist
ON rooms USING GiST (area);

-- 9. Create a GIN index for full-text search queries like: 
SELECT * FROM products WHERE to_tsvector('english', description) @@ 
to_tsquery('keyword'); 

CREATE INDEX idx_products_description_gin
ON products USING GIN (to_tsvector('english', description));

-- 10. Create indexes to optimize a join query like: 

SELECT o.order_id, p.product_name, oi.quantity 
FROM orders o 
JOIN order_items oi ON o.order_id = oi.order_id 
JOIN products p ON oi.product_id = p.product_id 
WHERE o.order_total > value1 AND oi. quantity < value2; 

CREATE INDEX idx_orders_order_total
ON orders (order_total);

CREATE INDEX idx_order_items_order_id_quantity
ON order_items (order_id, quantity);

CREATE INDEX idx_order_items_product_id
ON order_items (product_id);