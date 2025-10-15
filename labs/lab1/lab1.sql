--Task 1--
CREATE DATABASE lab1;

--Task 2--
CREATE TABLE clients (
    client_id SERIAL,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    email VARCHAR(100),
    date_joined date
);

-- Task 3--

ALTER TABLE clients
ADD column status INTEGER;

-- Task 4--

ALTER TABLE clients
ALTER COLUMN status TYPE BOOLEAN
USING (status = 1); -- Using Преобразовывает прошлые значения 
-- если status = 1 будет TRUE;
-- если status = 0 будет FALSE.

-- Task 5 --

ALTER TABLE clients
ALTER COLUMN status SET DEFAULT TRUE;

-- Task 6 -- 

ALTER TABLE clients
ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);

-- Task 7 --
CREATE TABLE orders (
    order_id SERIAL,
    order_name VARCHAR(100),
    client_id INTEGER REFERENCES clients(client_id)
);

-- Task 8 --
DROP TABLE orders;

-- Task 9 --
DROP DATABASE lab1;