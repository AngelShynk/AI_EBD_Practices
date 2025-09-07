/*──────────────────────────────────────────────
  union_workshop
  Demonstrates UNION vs UNION ALL
──────────────────────────────────────────────*/

-- 1) Create and use a new database
CREATE DATABASE IF NOT EXISTS P03;
USE P03;

-- 2) Drop old tables if they exist
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS contractors;

-- 3) Create tables
CREATE TABLE employees (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(50)
);

CREATE TABLE contractors (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(50)
);

-- 4) Insert sample data
INSERT INTO employees VALUES
(1,'Alice','HR'),
(2,'Bob','IT'),
(3,'Carla','Finance');

INSERT INTO contractors VALUES
(4,'Dan','IT'),
(2,'Bob','IT'),      -- Bob also appears in employees
(5,'Eva','Finance');

-- 5) UNION: removes duplicates
SELECT name, department
FROM employees
UNION
SELECT name, department
FROM contractors;
/*
Result:
Alice | HR
Bob   | IT        -- appears only once
Carla | Finance
Dan   | IT
Eva   | Finance
*/

-- 6) UNION ALL: keeps duplicates
SELECT name, department
FROM employees
UNION ALL
SELECT name, department
FROM contractors;
/*
Result:
Alice | HR
Bob   | IT
Carla | Finance
Dan   | IT
Bob   | IT        -- appears twice
Eva   | Finance
*/
