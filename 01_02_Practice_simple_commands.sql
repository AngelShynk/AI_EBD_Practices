-- Test SQL Script for MySQL Installation

-- 1. Create a new database
CREATE DATABASE StudentDB;

-- 2. Use the database
USE StudentDB;

-- 3. Create a table
CREATE TABLE Students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    grade VARCHAR(10)
);

-- 4. Insert sample data
INSERT INTO Students (name, age, grade) VALUES
('Alice', 20, 'A'),
('Bob', 22, 'B'),
('Charlie', 21, 'A'),
('Diana', 23, 'C');

-- 5. Show tables in the database
SHOW TABLES;

-- 6. Display the structure of the Students table
DESCRIBE Students;

-- 7. Select all data from the table
SELECT * FROM Students;

-- 8. Select data with filtering (students with grade A)
SELECT * FROM Students WHERE grade = 'A';

-- 9. Select specific columns (name and grade only)
SELECT name, grade FROM Students;

-- 10. Count how many students per grade
SELECT grade, COUNT(*) AS total_students
FROM Students
GROUP BY grade;



