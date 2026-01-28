CREATE DATABASE IF NOT EXISTS company;
USE company;
DROP TABLE IF EXISTS EMPLOYEES_SEQ;

CREATE TABLE EMPLOYEES_SEQ (
    Employee_id INT NOT NULL AUTO_INCREMENT,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    DOB DATE,
    Salary INT NOT NULL,
    Department_id VARCHAR(10),
    PRIMARY KEY (Employee_id)
);

ALTER TABLE EMPLOYEES_SEQ AUTO_INCREMENT = 100;

SELECT AUTO_INCREMENT
FROM information_schema.tables
WHERE table_name = 'EMPLOYEES_SEQ'
AND table_schema = 'company';

INSERT INTO EMPLOYEES_SEQ (First_Name, Last_Name, DOB, Salary, Department_id)
VALUES ('Ravi', 'Kumar', '1991-03-12', 85000, 'D01');
INSERT INTO EMPLOYEES_SEQ (First_Name, Last_Name, DOB, Salary, Department_id)
VALUES ('Sunita', 'Desai', '1994-06-20', 78000, 'D03');
SELECT * FROM EMPLOYEES_SEQ;

ALTER TABLE EMPLOYEES_SEQ MODIFY Employee_id INT NOT NULL;

SET @@cte_max_recursion_depth = 2000;
WITH RECURSIVE NumberSequence (n) AS (
    SELECT 10000
    UNION ALL
    SELECT n - 5
    FROM NumberSequence
    WHERE n > 1000
)
SELECT n FROM NumberSequence;