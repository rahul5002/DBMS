CREATE DATABASE IF NOT EXISTS company;
USE company;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS WORKS_ON;
DROP TABLE IF EXISTS PROJECT;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE DEPARTMENT (
    Dept_number INT PRIMARY KEY,
    Dept_name VARCHAR(50) NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE
);
CREATE TABLE EMPLOYEE (
    Ssn CHAR(9) PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dept_no INT,
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dept_no) REFERENCES DEPARTMENT(Dept_number)
);
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);
CREATE TABLE PROJECT (
    Proj_number INT PRIMARY KEY,
    Proj_name VARCHAR(50) NOT NULL,
    Dept_num INT,
    FOREIGN KEY (Dept_num) REFERENCES DEPARTMENT(Dept_number)
);
CREATE TABLE WORKS_ON (
    Emp_ssn CHAR(9),
    Proj_no INT,
    Hours DECIMAL(4, 1),
    PRIMARY KEY (Emp_ssn, Proj_no),
    FOREIGN KEY (Emp_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Proj_no) REFERENCES PROJECT(Proj_number)
);
INSERT INTO DEPARTMENT (Dept_number, Dept_name) VALUES
(1, 'Sales'),
(4, 'Research'),
(5, 'Marketing');
INSERT INTO EMPLOYEE (Ssn, Fname, Lname, Salary, Dept_no) VALUES
('01', 'Anmol', 'Thapliyal', 75000.00, 5),
('02', 'Snigdh', 'Rawal', 80000.00, 5),
('03', 'Augustya', 'Thakur', 95000.00, 4),
('04', 'Harshit', 'Garg', 60000.00, 1),
('05', 'Kapil', 'Singh', 110000.00, 4),
('06', 'Rahul', 'Mankani', 65000.00, 1);
INSERT INTO PROJECT (Proj_number, Proj_name, Dept_num) VALUES
(1, 'ProductW', 5),
(2, 'ProductX', 5),
(10, 'ProductY', 4),
(30, 'ProductZ', 1);
INSERT INTO WORKS_ON (Emp_ssn, Proj_no, Hours) VALUES
('01', 1, 32.5),
('01', 2, 7.5),
('03', 1, 20.0),
('03', 2, 20.0),
('02', 2, 10.0),
('04', 10, 35.0),
('06', 10, 10.0),
('05', 30, NULL);
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;

CREATE OR REPLACE VIEW department_manager_view AS
SELECT
    d.Dept_name AS Department_Name,
    CONCAT(e.Fname, ' ', e.Lname) AS Manager_Name,
    e.Salary AS Manager_Salary
FROM DEPARTMENT d
JOIN EMPLOYEE e ON d.Mgr_ssn = e.Ssn;
SELECT * FROM department_manager_view;

CREATE OR REPLACE VIEW research_employee_supervisor_view AS
SELECT
    CONCAT(emp.Fname, ' ', emp.Lname) AS Employee_Name,
    CONCAT(sup.Fname, ' ', sup.Lname) AS Supervisor_Name,
    emp.Salary AS Employee_Salary
FROM EMPLOYEE emp
JOIN EMPLOYEE sup ON emp.Super_ssn = sup.Ssn
JOIN DEPARTMENT d ON emp.Dept_no = d.Dept_number
WHERE d.Dept_name = 'Research';
SELECT * FROM research_employee_supervisor_view;

CREATE OR REPLACE VIEW project_summary_view AS
SELECT
    p.Proj_name AS Project_Name,
    d.Dept_name AS Department_Name,
    COUNT(w.Emp_ssn) AS Number_of_Employees,
    SUM(w.Hours) AS Total_Hours_Per_Week
FROM PROJECT p
JOIN DEPARTMENT d ON p.Dept_num = d.Dept_number
JOIN WORKS_ON w ON p.Proj_number = w.Proj_no
GROUP BY p.Proj_name, d.Dept_name;
SELECT * FROM project_summary_view;

CREATE VIEW filtered_project_summary_view AS
SELECT
    p.Proj_name AS Project_Name,
    d.Dept_name AS Department_Name,
    COUNT(w.Emp_ssn) AS Number_of_Employees,
    SUM(w.Hours) AS Total_Hours_Per_Week
FROM PROJECT p
JOIN DEPARTMENT d ON p.Dept_num = d.Dept_number
JOIN WORKS_ON w ON p.Proj_number = w.Proj_no
GROUP BY p.Proj_name, d.Dept_name
HAVING COUNT(w.Emp_ssn) > 1;
SELECT * FROM filtered_project_summary_view;