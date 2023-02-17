CREATE DATABASE sql_exercises;
USE sql_exercises;

CREATE TABLE Departments (
	code INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    budget REAL NOT NULL,
    PRIMARY KEY(code)
);

CREATE TABLE Employees (
	ssn INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    department INT NOT NULL,
    PRIMARY KEY(ssn),
    FOREIGN KEY(department) REFERENCES Departments(code)
);

-- DATA --
INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

-- QUERIES -- 

-- 2.1 Select the last name of all employees.
SELECT lastName AS 'Last Name' FROM Employees;

-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT lastname AS 'Last Name' FROM Employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM employees
WHERE lastName = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employees
WHERE lastName = 'Smith' OR lastName = 'Doe';

-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM employees
WHERE department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM employees
WHERE department = 37 OR department = 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM employees
WHERE lastName LIKE 'S%';

-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM(budget) FROM Departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT 
	Employees.department AS 'Department',
    COUNT(Employees.name) AS 'No. of Employees'
FROM Employees
GROUP BY Employees.Department;

#Alternative:
SELECT Department, COUNT(*)
  FROM Employees
  GROUP BY Department;

-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT * FROM Employees
JOIN Departments ON Employees.Department = Departments.code;

#Alternative:
SELECT *
 FROM Employees E INNER JOIN Departments D
 ON E.Department = D.Code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT 
	e.name,
    e.lastName,
    d.name,
    d.budget
FROM Employees AS e
JOIN Departments AS d 
ON e.Department = d.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT 
	e.name,
    e.lastName
FROM Employees AS e
JOIN Departments AS d 
ON e.Department = d.code
WHERE d.budget > 60000;

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT name,budget FROM Departments
WHERE Departments.budget > (
	SELECT AVG(Departments.budget) FROM Departments);


-- 2.14 Select the names of departments with more than two employees.
SELECT 
	D.name AS 'Dept', 
    COUNT(E.name) AS 'No. of Employees' 
FROM Departments AS D
JOIN Employees AS E 
ON D.code = E.Department
GROUP BY D.name
HAVING COUNT(E.name) > 2;

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.

## Correct but no need to include the Dept name
SELECT 
	E.name, 
    E.lastName, 
    D.name
FROM Employees AS E
JOIN Departments AS D 
ON E.Department = D.code
HAVING D.name = (
	SELECT Departments.name FROM Departments
	ORDER BY Departments.Budget ASC
	LIMIT 1,1
);

## Removed the Dept name
SELECT 
	E.name, 
    E.lastName
FROM Employees AS E
WHERE E.Department = (
	SELECT Departments.code FROM Departments
	ORDER BY Departments.Budget ASC
	LIMIT 1,1 -- LIMIT 1, [Offset] 1. Offset 1 will skip the first result, giving the 2nd lowest
);

#Alternative
SELECT e.Name, e.LastName
FROM Employees e 
WHERE e.Department = (
       SELECT sub.Code 
       FROM (SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub 
       ORDER BY budget DESC LIMIT 1);

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO Departments(code,name,budget) VALUES (11,'Quality Assurance',40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO Employees(ssn, name, lastName, Department) VALUES (847219811, 'Mary', 'Moore',11);

-- 2.17 Reduce the budget of all departments by 10%.


-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
-- 2.19 Delete from the table all employees in the IT department (code 14).
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
-- 2.21 Delete from the table all employees.

