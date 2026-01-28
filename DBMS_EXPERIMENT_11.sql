CREATE DATABASE IF NOT EXISTS company;
USE company;
DROP TABLE IF EXISTS EMPLOYEES;

CREATE TABLE EMPLOYEES (
    Employee_id VARCHAR(10) NOT NULL,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    DOB DATE,
    Salary INT NOT NULL,
    Department_id VARCHAR(10),
    PRIMARY KEY (Employee_id)
);
INSERT INTO EMPLOYEES (Employee_id, First_Name, Last_Name, DOB, Salary, Department_id) VALUES
('E1', 'Amit', 'Sharma', '2000-05-15', 75000, 'D01'),
('E2', 'Priya', 'Verma', '2001-08-22', 80000, 'D02'),
('E3', 'Rahul', 'Singh', '2002-11-30', 92000, 'D01'),
('E4', 'Sneha', 'Gupta', '2003-02-10', 68000, 'D03'),
('E5', 'Vikram', 'Patel', '2004-07-19', 110000, 'D02'),
('E6', 'Pooja', 'Mehra', '2005-01-25', 72000, 'D01');

CREATE INDEX employee_idx ON EMPLOYEES (Last_Name, Department_id);

ALTER TABLE EMPLOYEES
ADD COLUMN Employee_id_reversed VARCHAR(10) 
AS (REVERSE(Employee_id)) STORED;
CREATE INDEX idx_emp_id_reversed ON EMPLOYEES (Employee_id_reversed);
SELECT Employee_id, Employee_id_reversed 
FROM EMPLOYEES;

CREATE UNIQUE INDEX emp_dept_unique_idx ON EMPLOYEES (Employee_id, Department_id);
INSERT INTO EMPLOYEES (Employee_id, First_Name, Last_Name, DOB, Salary, Department_id)
VALUES ('E7', 'Test', 'User', '2000-01-01', 50000, 'D01');

CREATE INDEX idx_lastname_lower ON EMPLOYEES ((LOWER(Last_Name)));

DROP INDEX idx_lastname_lower ON EMPLOYEES;