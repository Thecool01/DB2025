-- Employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    email VARCHAR(100)
);

-- Rooms table (for GiST index example)
CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    area numrange
);

-- Products table (for GIN index example)
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    description TEXT
);

-- Orders and Order_Items tables (for join optimization)
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_total NUMERIC(10,2)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT
);

-- ============================================
-- Insert sample data
-- ============================================

INSERT INTO employees (first_name, last_name, department, salary, email) VALUES
('John', 'Smith', 'HR', 55000.00, 'john.smith@company.com'),
('Jane', 'Doe', 'Finance', 62000.00, 'jane.doe@company.com'),
('Robert', 'Brown', 'IT', 75000.00, 'robert.brown@company.com'),
('Emily', 'Davis', 'Marketing', 68000.00, 'emily.davis@company.com'),
('Michael', 'Johnson', 'HR', 54000.00, 'michael.johnson@company.com'),
('Sarah', 'Miller', 'Finance', 60000.00, 'sarah.miller@company.com'),
('David', 'Wilson', 'IT', 80000.00, 'david.wilson@company.com'),
('Laura', 'Taylor', 'Sales', 58000.00, 'laura.taylor@company.com'),
('Daniel', 'Anderson', 'IT', 77000.00, 'daniel.anderson@company.com'),
('Olivia', 'Thomas', 'Marketing', 70000.00, 'olivia.thomas@company.com');

INSERT INTO rooms (area) VALUES
(numrange(15,25)), (numrange(20,30)), (numrange(10,20)), (numrange(25,35)), (numrange(30,40));

INSERT INTO products (product_name, description) VALUES
('Laptop', 'A fast and lightweight laptop with long battery life'),
('Headphones', 'Noise-cancelling wireless headphones'),
('Smartphone', 'A phone with excellent camera and display'),
('Tablet', 'Lightweight tablet for work and entertainment'),
('Monitor', '27-inch 4K monitor for professionals');

INSERT INTO orders (order_total) VALUES
(1200.00), (560.00), (980.00), (2200.00), (400.00);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 1),
(4, 5, 2),
(5, 1, 1);

