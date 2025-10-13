DROP DATABASE IF EXISTS Company;
CREATE DATABASE Company;
USE Company;

CREATE TABLE DEPARTMENT (
    Dept_name VARCHAR(15) NOT NULL,
    Dept_num INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    PRIMARY KEY (Dept_num),
    UNIQUE (Dept_name)
);

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR,
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    PRIMARY KEY (Ssn)
);

CREATE TABLE DEPT_LOCATIONS (
    Dept_num INT NOT NULL,
    Dept_location VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dept_num, Dept_location)
);

CREATE TABLE PROJECT (
    Proj_name VARCHAR(15) NOT NULL,
    Proj_number INT NOT NULL,
    Proj_location VARCHAR(15),
    Dnum INT NOT NULL,
    PRIMARY KEY (Proj_number),
    UNIQUE (Proj_name)
);

CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1),
    PRIMARY KEY (Essn, Pno)
);

CREATE TABLE DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR,
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name)
);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_super_ssn FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
ADD CONSTRAINT fk_dno FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dept_num);

ALTER TABLE DEPARTMENT
ADD CONSTRAINT fk_mgr_ssn FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE DEPT_LOCATIONS
ADD CONSTRAINT fk_dept_num_loc FOREIGN KEY (Dept_num) REFERENCES DEPARTMENT(Dept_num);

ALTER TABLE PROJECT
ADD CONSTRAINT fk_dnum FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dept_num);

ALTER TABLE WORKS_ON
ADD CONSTRAINT fk_essn FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
ADD CONSTRAINT fk_pno FOREIGN KEY (Pno) REFERENCES PROJECT(Proj_number);

ALTER TABLE DEPENDENT
ADD CONSTRAINT fk_essn_dep FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn);

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO DEPARTMENT (Dept_name, Dept_num, Mgr_ssn, Mgr_start_date) VALUES
('Research', 5, '333445555', '1988-05-22'),
('Administration', 4, '987654321', '1995-01-01'),
('Headquarters', 1, '888665555', '1981-06-19');

INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES
('Franklin', 'T', 'Wong', '333445555', '1965-12-08', '638 Voss, Houston TX', 'M', 40000.00, NULL, 5),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire TX', 'F', 43000.00, NULL, 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston TX', 'M', 55000.00, NULL, 1),
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston TX', 'M', 30000.00, '333445555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring TX', 'F', 25000.00, '987654321', 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble TX', 'M', 38000.00, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston TX', 'F', 25000.00, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston TX', 'M', 25000.00, '987654321', 4);

UPDATE EMPLOYEE SET Super_ssn = '888665555' WHERE Ssn IN ('333445555', '987654321');

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO DEPT_LOCATIONS (Dept_num, Dept_location) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Houston'),
(5, 'Sugarland');

INSERT INTO PROJECT (Proj_name, Proj_number, Proj_location, Dnum) VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL);

INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES
('333445555', 'Alice', 'F', '1986-04-04', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPT_LOCATIONS;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;