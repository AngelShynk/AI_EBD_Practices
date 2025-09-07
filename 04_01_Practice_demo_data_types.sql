-- 1) Create and use DB
DROP DATABASE IF EXISTS P04;
CREATE DATABASE P04;
USE P04;

-- 2) Create one simple table with column/table COMMENTS + constraints
CREATE TABLE demo (
  id INT PRIMARY KEY AUTO_INCREMENT
    COMMENT 'Primary key (auto-increment integer)',
  name VARCHAR(20) NOT NULL
    COMMENT 'Short name; max 20 characters',
  age INT UNSIGNED NULL
    COMMENT 'Age in whole years; must be >= 0',
  price DECIMAL(8,2) NOT NULL DEFAULT 0.00
    COMMENT 'Non-negative price; 2 decimal places',
  created_on DATE NOT NULL
    COMMENT 'Date only (YYYY-MM-DD)',
  role ENUM('admin','user') NOT NULL DEFAULT 'user'
    COMMENT 'Allowed roles: admin or user',
  country CHAR(2) NULL
    COMMENT 'ISO 3166-1 alpha-2 country code',
  UNIQUE KEY uq_demo_name (name),
  CONSTRAINT chk_price_nonneg CHECK (price >= 0)
) COMMENT='Demo table for datatype, comments, and constraints';

-- 3) Valid sample rows
INSERT INTO demo (name, age, price, created_on, role, country)
VALUES
  ('alice', 30, 19.99, '2025-06-01', 'user',  'US'),
  ('bob',   22,  0.00, '2025-07-15', 'admin', 'GB');

-- 4) Lightweight "documentation" you can run
-- a) Full DDL including column/table comments:
-- SHOW CREATE TABLE demo
-- b) Column comments from INFORMATION_SCHEMA:
/*
SELECT COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_COMMENT 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA='P04' AND TABLE_NAME='demo'
ORDER BY ORDINAL_POSITION;
*/

-- 5) Wrong usage examples (should error in MySQL 8+ with strict mode)

-- 5.1 Too-long string for VARCHAR(20)
INSERT INTO demo (name, age, price, created_on, role, country)
VALUES ('this_name_is_definitely_too_long', 25, 5.00, '2025-08-01', 'user', 'US');

-- 5.2 Non-numeric text into INT column
INSERT INTO demo (name, age, price, created_on, role, country)
VALUES ('charlie', 'not_a_number', 1.00, '2025-08-02', 'user', 'US');

-- 5.3 Invalid ENUM value (role must be 'admin' or 'user')
INSERT INTO demo (name, age, price, created_on, role, country)
VALUES ('diana', 28, 3.50, '2025-08-03', 'superuser', 'US');
