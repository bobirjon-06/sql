drop table if exists Orders_DB1

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

drop table if exists Orders_DB2

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

DECLARE @MissingOrders TABLE (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO @MissingOrders
SELECT *
FROM Orders_DB1 o1
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders_DB2 o2 
    WHERE o1.OrderID = o2.OrderID
);
SELECT * FROM @MissingOrders;
