CREATE TABLE students(
id INTEGER,
name TEXT,
age INTEGER
);

ALTER TABLE students
ALTER COLUMN id INTEGER NOT NULL;

CREATE TABLE product(
product_id INTEGER PRIMARY KEY,
product_name TEXT,
price DECIMAL
)