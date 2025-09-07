/*──────────────────────────────────────────────
  operators_demo
  Simple examples of common SQL operators
──────────────────────────────────────────────*/

-- 1) Create demo table
CREATE DATABASE IF NOT EXISTS P03;
USE P03;

DROP TABLE IF EXISTS people;

CREATE TABLE people (
  id INT,
  name VARCHAR(50),
  score INT,
  email VARCHAR(100),
  phone VARCHAR(20)
);

-- 2) Insert sample data
INSERT INTO people VALUES
(1,'Alice', 85,'alice@example.com','123-456'),
(2,'Bob',   72,NULL,'987-654'),
(3,'Carla', 95,'carla@example.com',NULL),
(4,'Dan',   55,'dan@example.com','555-999');


-- EXAMPLES OF SQL OPERATORS

-- 1️⃣ BETWEEN (inclusive)
-- Returns rows where score is between 60 and 90
-- Both 60 and 90 are included in the range
SELECT name, score
FROM people
WHERE score BETWEEN 60 AND 90;
-- Expected: Alice (85), Bob (72)

-- 2️⃣ IN (match against a list of values)
-- Returns rows where id matches one of the values in the list
SELECT id, name
FROM people
WHERE id IN (1, 2, 3);
-- Expected: Alice (1), Bob (2), Carla (3)

-- 3️⃣ LIKE (pattern matching with wildcards)
-- % means "any number of characters"
-- _ means "exactly one character"
-- Example: names starting with 'A'
SELECT id, name
FROM people
WHERE name LIKE 'A%';
-- Expected: Alice

-- Names ending with 'a'
-- '%a' means: anything, but must end with 'a'
SELECT id, name
FROM people
WHERE name LIKE '%a';
-- Expected: Carla

-- Names containing 'ar'
-- '%ar%' means: any characters before and after 'ar'
SELECT id, name
FROM people
WHERE name LIKE '%ar%';
-- Expected: Carla

-- Names with exactly 4 letters
-- '____' (4 underscores) means: exactly 4 characters
SELECT id, name
FROM people
WHERE name LIKE '____';
-- Expected: Bob, Dan (both have 3 letters → won’t match), only names with 4 letters match

-- Names where the second letter is 'a'
-- '_a%' means: any one character, then 'a', then anything
SELECT id, name
FROM people
WHERE name LIKE '_a%';
-- Expected: Carla, Dan

-- Names starting with 'C' and having 5 letters
-- 'C____' = C + 4 characters
SELECT id, name
FROM people
WHERE name LIKE 'C____';
-- Expected: Carla

-- Case-insensitive search
-- In MySQL, LIKE is not case-sensitive by default (depends on collation).
-- So 'a%' will match both 'Alice' and 'alice' if case-insensitive collation is used.
SELECT id, name
FROM people
WHERE name LIKE 'a%';
-- Expected: Alice (same as 'A%')

-- 4️⃣ IS NULL
-- Returns rows where the column value is NULL (unknown / missing)
SELECT id, name
FROM people
WHERE email IS NULL;
-- Expected: Bob (no email)

-- 5️⃣ IS NOT NULL
-- Returns rows where the column value is NOT NULL
-- Example: people who have a phone number
SELECT id, name, phone
FROM people
WHERE phone IS NOT NULL;
-- Expected: Alice, Bob, Dan (Carla has NULL phone)
