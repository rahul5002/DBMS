DROP DATABASE IF EXISTS supp_parts;
CREATE DATABASE supp_parts;
USE supp_parts;
CREATE TABLE Supplier (
    supp_code INT PRIMARY KEY,
    supp_name VARCHAR(50),
    supp_city VARCHAR(50),
    turnover INT
);
CREATE TABLE Part (
    part_code INT PRIMARY KEY,
    weigh DECIMAL(5, 2),
    color VARCHAR(20),
    cost DECIMAL(10, 2),
    sellingprice DECIMAL(10, 2)
);
CREATE TABLE Supplier_Part (
    supp_code INT,
    part_code INT,
    qty INT,
    FOREIGN KEY (supp_code) REFERENCES Supplier(supp_code),
    FOREIGN KEY (part_code) REFERENCES Part(part_code)
);
INSERT INTO Supplier (supp_code, supp_name, supp_city, turnover) VALUES
(1, 'Rama Supplies', 'Delhi', 100),
(2, 'Shyam Industries', 'Bombay', 50),
(3, 'Gangadhar Supplies', 'Pune', 200),
(4, 'Dhamu Industries', 'Bombay', NULL);
INSERT INTO Part (part_code, weigh, color, cost, sellingprice) VALUES
(1, 20.5, 'Red', 20, 30),
(2, 30.0, 'Blue', 40, 50),
(3, 35.5, 'Green', 50, 65),
(4, 28.0, 'Yellow', 30, 45);
INSERT INTO Supplier_Part (supp_code, part_code, qty) VALUES
(1, 1, 100),
(2, 2, 200),
(3, 3, 50),
(4, 2, 150);

SELECT supp_code, part_code
FROM Supplier_Part
ORDER BY supp_code ASC;

SELECT *
FROM Supplier
WHERE supp_city = 'Bombay' AND turnover = 50;

SELECT COUNT(*) AS total_suppliers
FROM Supplier;

SELECT part_code
FROM Part
WHERE weigh BETWEEN 25 AND 35;

SELECT supp_code
FROM Supplier
WHERE turnover IS NULL;

SELECT part_code
FROM Part
WHERE cost IN (20, 30, 40);

SELECT SUM(qty) AS total_qty_part_2
FROM Supplier_Part
WHERE part_code = 2;

SELECT s.supp_name
FROM Supplier s
JOIN Supplier_Part sp ON s.supp_code = sp.supp_code
WHERE sp.part_code = 2;

SELECT part_code
FROM Part
WHERE cost > (SELECT AVG(cost) FROM Part);

SELECT supp_code, turnover
FROM Supplier
ORDER BY turnover DESC;






