DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

WITH StatusField AS (
	SELECT*,
	ROW_NUMBER() over (ORDER BY StepNumber)
	- ROW_NUMBER() over (PARTITION BY Status ORDER BY StepNumber) AS grouped
	FROM Groupings
)
Select 
	Status,
	COUNT(*) AS InSequence
	FROM StatusField
	Group by Status, grouped
	ORDER BY min(StepNumber);