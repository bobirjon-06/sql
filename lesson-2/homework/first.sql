DROP TABLE IF EXISTS test_identity;

CREATE TABLE test_identity(
test INT IDENTITY(1,1)
);

INSERT INTO test_identity DEFAULT VALUES;
INSERT INTO test_identity DEFAULT VALUES;
INSERT INTO test_identity DEFAULT VALUES;
INSERT INTO test_identity DEFAULT VALUES;
INSERT INTO test_identity DEFAULT VALUES;

SELECT * FROM test_identity;
DELETE FROM test_identity;
SELECT * FROM test_identity;

INSERT INTO test_identity DEFAULT VALUES;
SELECT * FROM test_identity;
TRUNCATE TABLE test_identity;
INSERT INTO test_identity DEFAULT VALUES;
SELECT * FROM test_identity;

DROP TABLE test_identity;


--2
DROP TABLE IF EXISTS data_types_demo;

CREATE TABLE data_types_demo (
    test1 VARCHAR(50),
    test2 DATE,
    test3 TINYINT,
	test5 UNIQUEIDENTIFIER
);
INSERT INTO data_types_demo
VALUES ('SE7EN', '2004-07-11', 7);
SELECT * FROM data_types_demo
SELECT GETDATE();
SELECT NEWID();

CREATE TABLE photos (
    id INT PRIMARY KEY,
    name TEXT,
    photo VARBINARY(MAX)
);
INSERT INTO photos (id, name, photo)
SELECT 
    7, 
    'images.jpg', 
    BulkColumn
FROM OPENROWSET(
    BULK N'C:\\Users\\bahma\\Downloads\\images.jpg',
    SINGLE_BLOB
) AS img;
SELECT * FROM photos


drop table if exists student;
DROP TABLE IF EXISTS student;
CREATE TABLE student (
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS (classes * tuition_per_class)
);
INSERT INTO student(classes, tuition_per_class)
VALUES
(3, 1200.75),
(4, 413.65),
(2, 700.0);
SELECT * FROM student;


DROP TABLE IF EXISTS worker;

create table worker(
id INT,
name VARCHAR(50)
);

BULK INSERT worker FROM 'C:\Users\bahma\OneDrive\Documents\ai\sql\lesson-2\homework\worker.csv'
WITH(
FIELDTERMINATOR=',',
ROWTERMINATOR='\n',
FIRSTROW = 2
);