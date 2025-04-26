DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments(
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(50)
);

CREATE TABLE Employees(
	EmployeeID INT PRIMARY KEY,
	Name VARCHAR(50),
	DepartmentID INT,
	Salary DECIMAL(10,2),
	FOREIGN KEY(DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE Projects(
	ProjectID INT PRIMARY KEY,
	ProjectName VARCHAR(50),
	EmployeeID INT,
	FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);  


INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),  
(2, 'Beta', 2),   
(3, 'Gamma', 1),  
(4, 'Delta', 4);  


SELECT d.DepartmentName, SUM(e.Salary) AS totalSalary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;