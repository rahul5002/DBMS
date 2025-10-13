CREATE DATABASE IF NOT EXISTS sample_db;
USE sample_db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0)
);

INSERT INTO Customers (customer_id, customer_name, email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Brown', 'alice@example.com');

INSERT INTO Orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2025-01-15', 150.50),
(102, 2, '2025-02-20', 299.99),
(103, 1, '2025-03-10', 89.00);

INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 999.99),
(2, 'Mouse', 29.99),
(3, 'Keyboard', 59.99);

SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, o.amount
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.customer_name, o.order_id, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.customer_name, o.order_id, o.order_date
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.customer_name, o.order_id, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

SELECT customer_name AS name FROM Customers
UNION
SELECT product_name AS name FROM Products;

SELECT c.customer_id, c.customer_name
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.customer_id = c.customer_id
);

SELECT DISTINCT c.customer_id, c.customer_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

DELIMITER //
CREATE TRIGGER enforce_total_participation
BEFORE DELETE ON Customers
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Orders WHERE customer_id = OLD.customer_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete customer with existing orders';
    END IF;
END //
DELIMITER ;

SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

INSERT INTO Products (product_id, product_name, price) VALUES
(4, 'Monitor', 199.99);

DELETE FROM Products WHERE product_id = 4;

UPDATE Products
SET price = price * 1.1
WHERE price < 100.00;

SELECT * FROM Products
WHERE price > 50.00;

SELECT COUNT(*) AS total_orders, SUM(amount) AS total_amount, AVG(amount) AS avg_amount
FROM Orders;

SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING order_count > 1;

SELECT customer_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE amount > 100.00
);

WITH HighValueOrders AS (
    SELECT customer_id, order_id, amount
    FROM Orders
    WHERE amount > 100.00
)
SELECT c.customer_name, h.order_id, h.amount
FROM Customers c
INNER JOIN HighValueOrders h ON c.customer_id = h.customer_id;

CREATE INDEX idx_customer_email ON Customers(email);

DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Products;