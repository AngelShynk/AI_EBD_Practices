-- ======================================================
-- 1) Prepare a demo database and table
-- ======================================================
DROP DATABASE IF EXISTS P04;
CREATE DATABASE P04;
USE P04;

CREATE TABLE demo (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key',
  name VARCHAR(20) NOT NULL COMMENT 'Name of person',
  age INT COMMENT 'Age in years'
) COMMENT='Simple demo table';

INSERT INTO demo (name, age) VALUES
('Alice', 30),
('Bob', 25),
('Charlie', 40);

SELECT * FROM demo;

-- ======================================================
-- 2) ALTER TABLE examples
-- ======================================================

-- Add a new column with a comment
ALTER TABLE demo
ADD COLUMN country CHAR(2) NULL COMMENT '2-letter country code';

-- Modify a column (make age UNSIGNED so no negatives allowed)
ALTER TABLE demo
MODIFY COLUMN age INT UNSIGNED COMMENT 'Age in years (no negatives)';

-- Rename a column (name -> full_name)
ALTER TABLE demo
CHANGE COLUMN name full_name VARCHAR(30) NOT NULL COMMENT 'Full name of person';

-- Rename the table itself (demo -> people)
ALTER TABLE demo
RENAME TO people;

-- Check structure after alters
DESCRIBE people;

-- ======================================================
-- 3) DELETE (removes selected rows, keeps table structure)
-- ======================================================

-- Delete one row where full_name = 'Alice'
DELETE FROM people WHERE full_name = 'Alice';

SELECT * FROM people;

-- ======================================================
-- 4) TRUNCATE (removes ALL rows, resets AUTO_INCREMENT, keeps structure)
-- ======================================================

TRUNCATE TABLE people;

SELECT * FROM people;  -- now empty

-- ======================================================
-- 5) DROP (removes the whole table or DB, structure + data gone)
-- ======================================================

DROP TABLE people;     -- drops the table entirely

-- Or drop the whole DB:
-- DROP DATABASE P04;
