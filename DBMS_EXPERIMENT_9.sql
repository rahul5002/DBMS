CREATE DATABASE IF NOT EXISTS company;
USE company;
DROP TABLE IF EXISTS EMPLOYEES;
DROP VIEW IF EXISTS emp_view;
DROP VIEW IF EXISTS salary_view;

CREATE TABLE EMPLOYEES (
Employee_id CHAR(10) PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    DOB DATE,
    Salary DECIMAL(10, 2) NOT NULL, 
    Department_id CHAR(10)
);
INSERT INTO EMPLOYEES (Employee_id, First_Name, Last_Name, DOB, Salary, Department_id) VALUES
('EMP01', 'Anmol', 'Thapliyal', '2000-05-15', 75000.00, '20'),
('EMP02', 'Snigdh', 'Rawal', '2001-08-22', 80000.00, '10'),
('EMP03', 'Augustya', 'Thakur', '2002-11-30', 95000.00, '20'),
('EMP04', 'Harshit', 'Garg', '2003-02-10', 60000.00, '30'),
('EMP05', 'Kapil', 'Singh', '2004-07-19', 110000.00, '20'),
('EMP06', 'Rahul', 'Mankani', '2005-09-08', 65000.00, '10');
SELECT * FROM EMPLOYEES;

CREATE VIEW emp_view AS
SELECT Employee_id, Last_Name, Salary, Department_id
FROM EMPLOYEES;
SELECT * FROM emp_view;

ALTER TABLE EMPLOYEES MODIFY First_Name VARCHAR(30) NULL;
INSERT INTO emp_view (Employee_id, Last_Name, Salary, Department_id)
VALUES ('EMP07', 'Ayush', 55000.00, '30');
SELECT * FROM emp_view;
SELECT * FROM EMPLOYEES;

UPDATE emp_view
SET Salary = 80000.00
WHERE Employee_id = 'EMP01';

DELETE FROM emp_view
WHERE Employee_id = 'EMP07';

SELECT * FROM EMPLOYEES;

DROP VIEW emp_view;

CREATE VIEW salary_view AS
SELECT Employee_id, First_Name, Last_Name, (Salary * 12) AS Annual_Salary
FROM EMPLOYEES
WHERE Department_id = '20';
SELECT * FROM salary_view;