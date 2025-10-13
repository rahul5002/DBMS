DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

CREATE TABLE DEPARTMENT (
    Dept_name VARCHAR(50) NOT NULL,
    Dept_number INT PRIMARY KEY,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    Dept_location VARCHAR(50)
);
CREATE TABLE EMPLOYEE (
    Fname VARCHAR(30) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(30) NOT NULL,
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dept_no INT NOT NULL,
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dept_no) REFERENCES DEPARTMENT(Dept_number)
);
ALTER TABLE DEPARTMENT
ADD FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);
CREATE TABLE PROJECT (
    Proj_name VARCHAR(50) NOT NULL,
    Proj_number INT PRIMARY KEY,
    Proj_location VARCHAR(50),
    Dept_num INT NOT NULL,
    FOREIGN KEY (Dept_num) REFERENCES DEPARTMENT(Dept_number)
);
CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Proj_no INT NOT NULL,
    Hours DECIMAL(4, 1) NOT NULL,
    PRIMARY KEY (Essn, Proj_no),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Proj_no) REFERENCES PROJECT(Proj_number)
);
CREATE TABLE DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(50) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(20),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO DEPARTMENT VALUES 
('Research', 5, '333445555', '1988-05-22', 'Houston'),
('Administration', 4, '987654321', '1995-01-01', 'Stafford'),
('Headquarters', 1, '888665555', '1981-06-19', 'Houston');
INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dept_no) VALUES 
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, NULL, 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-07-19', '3321 Castle, Spring, TX', 'F', 25000, '987654321', 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);
INSERT INTO PROJECT VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Newbenefits', 20, 'Stafford', 4),
('ProductA', 30, 'Houston', 5);
INSERT INTO WORKS_ON VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 5.0),
('999887777', 10, 10.0),
('987654321', 30, 10.0),
('987654321', 20, 15.0),
('888665555', 20, 0.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0);
INSERT INTO DEPENDENT VALUES
('333445555', 'Franklin', 'M', '1980-04-05', 'Son'),
('333445555', 'Alice', 'F', '1983-10-30', 'Daughter'),
('333445555', 'Elizabeth', 'F', '1978-05-05', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-01', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

SET FOREIGN_KEY_CHECKS = 1;

SELECT e.Fname, e.Lname
FROM EMPLOYEE e
JOIN WORKS_ON wo ON e.Ssn = wo.Essn
JOIN PROJECT p ON wo.Proj_no = p.Proj_number
WHERE e.Dept_no = 5 AND wo.Hours > 10 AND p.Proj_name = 'ProductX';

SELECT e.Fname, e.Lname
FROM EMPLOYEE e
JOIN DEPENDENT d ON e.Ssn = d.Essn
WHERE e.Fname = d.Dependent_name;

SELECT e.Fname, e.Lname
FROM EMPLOYEE e
JOIN EMPLOYEE s ON e.Super_ssn = s.Ssn
WHERE s.Fname = 'Franklin' AND s.Lname = 'Wong';

SELECT e.Fname, e.Lname
FROM EMPLOYEE e
JOIN WORKS_ON wo ON e.Ssn = wo.Essn
GROUP BY e.Ssn, e.Fname, e.Lname
HAVING COUNT(wo.Proj_no) = (SELECT COUNT(*) FROM PROJECT);

SELECT e.Fname, e.Lname
FROM EMPLOYEE e
LEFT JOIN WORKS_ON wo ON e.Ssn = wo.Essn
WHERE wo.Essn IS NULL;

SELECT e.Fname, e.Lname, e.Address
FROM EMPLOYEE e
WHERE e.Ssn IN (
    SELECT wo.Essn
    FROM WORKS_ON wo
    JOIN PROJECT p ON wo.Proj_no = p.Proj_number
    WHERE p.Proj_location = 'Houston'
) AND e.Dept_no NOT IN (
    SELECT d.Dept_number
    FROM DEPARTMENT d
    WHERE d.Dept_location = 'Houston'
);

SELECT Fname, Lname 
FROM EMPLOYEE 
WHERE Ssn NOT IN (SELECT DISTINCT Essn FROM WORKS_ON);

SELECT e.Fname, e.Lname, e.Address 
FROM EMPLOYEE e 
JOIN WORKS_ON wo ON e.Ssn = wo.Essn 
JOIN PROJECT p ON wo.Proj_no = p.Proj_number 
WHERE p.Proj_location = 'Houston' 
AND e.Dept_no NOT IN (
    SELECT d.Dept_number 
    FROM DEPARTMENT d 
    WHERE d.Dept_location = 'Houston'
) 
GROUP BY e.Ssn, e.Fname, e.Lname, e.Address;

SELECT e.Lname
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Ssn = d.Mgr_ssn
WHERE e.Ssn NOT IN (SELECT DISTINCT Essn FROM DEPENDENT);