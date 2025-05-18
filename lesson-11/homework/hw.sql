drop table if exists Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);

SELECT * INTO #EmployeeTransfers FROM Employees WHERE 1 = 0;

INSERT INTO #EmployeeTransfers
SELECT 
    EmployeeID,
    Name,
    CASE Department
        WHEN 'HR' THEN 'IT'
        WHEN 'IT' THEN 'Sales'
        WHEN 'Sales' THEN 'HR'
        ELSE Department
    END AS Department,
    Salary
FROM Employees;

SELECT * FROM #EmployeeTransfers;

