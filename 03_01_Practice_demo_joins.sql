-- 1) Create a fresh database for the workshop
CREATE DATABASE P03;
USE P03;

/*──────────────────────────────────────────────
  joins_workshop
  A simple MySQL workshop file showing JOIN types
──────────────────────────────────────────────*/


-- 2) Drop old tables if they exist
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;

-- 3) Create tables
CREATE TABLE students (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE courses (
  student_id INT,
  course VARCHAR(50)
);

-- 4) Insert sample data
INSERT INTO students VALUES
(1,'Alice'),
(2,'Bob'),
(3,'Carla');

INSERT INTO courses VALUES
(1,'Math'),
(1,'English'),
(2,'Science'),
(4,'History'); -- no matching student

/*──────────────────────────────────────────────
  JOIN EXAMPLES
──────────────────────────────────────────────*/

-- INNER JOIN: only matching rows in both tables
SELECT s.id, s.name, c.course
FROM students s
INNER JOIN courses c ON s.id = c.student_id;

/*
Result:
1 | Alice | Math
1 | Alice | English
2 | Bob   | Science
(Carls and History excluded)
*/

-- LEFT JOIN: all students, with courses if available
SELECT s.id, s.name, c.course
FROM students s
LEFT JOIN courses c ON s.id = c.student_id;
/*
Result:
1 | Alice | Math
1 | Alice | English
2 | Bob   | Science
3 | Carla | NULL   (no course)
*/

-- RIGHT JOIN: all courses, with students if available
SELECT s.id, s.name, c.course
FROM students s
RIGHT JOIN courses c ON s.id = c.student_id;
/*
Result:
1 | Alice | Math
1 | Alice | English
2 | Bob   | Science
NULL | NULL | History (no student)
*/

-- FULL OUTER JOIN (emulated with UNION in MySQL)
SELECT s.id, s.name, c.course
FROM students s
LEFT JOIN courses c ON s.id = c.student_id
UNION
SELECT s.id, s.name, c.course
FROM students s
RIGHT JOIN courses c ON s.id = c.student_id;
/*
Result:
1 | Alice | Math
1 | Alice | English
2 | Bob   | Science
3 | Carla | NULL
NULL | NULL | History
*/

-- CROSS JOIN: all combinations of students × courses
SELECT s.name, c.course
FROM students s
CROSS JOIN courses c;
/*
Result: 3 students × 4 courses = 12 rows
Example:
Alice | Math
Alice | English
Alice | Science
Alice | History
Bob   | Math
... etc.
*/
