
CREATE TABLE Book(
book_id INT PRIMARY KEY IDENTITY(1,1), 
title TEXT NOT NULL, 
author TEXT NOT NULL,
published_year INT
)

CREATE TABLE Member(
member_id INT PRIMARY KEY IDENTITY(1,1),
name TEXT,
email TEXT,
phone_number TEXT
)

CREATE TABLE Loan(
loan_id INT PRIMARY KEY IDENTITY(1,1),
book_id INT,
FOREIGN KEY (book_id) REFERENCES Book (book_id),
member_id INT,
FOREIGN KEY (member_id) REFERENCES Member (member_id),
loan_date DATE,
return_date DATE
)

INSERT INTO Book(title, author, published_year)
VALUES ('Jane Eyre', 'Charlotte Bronte', '1847'),
('The Lord Of the rings', 'J.R.R.T', '1981')
INSERT INTO Member(name, email, phone_number)
VALUES ('David Mills', 'millsse7en@gmail.com', '+981982983'),
('Haytham Kenway', 'templarkenway@gmail.com', '+9998887772'),
('Matthew Murdock', 'daredevil@gmail.com', '+78128361');
INSERT INTO Loan(loan_id, book_id, member_id, loan_date, return_date)
VALUES ('1', '2', '1', '2025-01-22', '2025-07-11'),
('2', '1', '2', '2025-01-22', '2025-07-11'),
('3', '2', '3', '2025-01-22', '2025-07-11');