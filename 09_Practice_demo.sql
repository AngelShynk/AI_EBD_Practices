use p08;
select * from students_performance limit 100;

-- 1. Show PK or add PK if it not exists.

-- Show PK:
SHOW CREATE TABLE students_performance;
/*
CREATE TABLE `students_performance` (
  `id` char(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `math_score` int DEFAULT NULL,
  `reading_score` int DEFAULT NULL,
  `writing_score` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_students_performance_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

*/

-- Add PK if it not exists:
ALTER TABLE students_performance
  ADD PRIMARY KEY (id);
  
  
  
-- 2) Add a secondary index (will cause key lookup)
-- Let’s say we often filter by name and then read a non-indexed column like age.


-- non-covering index
CREATE INDEX idx_students_performance_name ON students_performance(name);
-- Query (non-covering, causes Index lookup):

EXPLAIN ANALYZE
SELECT age
FROM students_performance
WHERE name = 'Diana Richmond';

/*
-> Index lookup on students_performance using idx_students_performance_name (name='Diana Richmond')  
(cost=5.5 rows=5) (actual time=6.17..6.18 rows=5 loops=1)

*/
-- Uses idx_students_performance_name to find matching rows

-- 3) Add another index to show covered vs key lookup
-- Now create a composite index that covers the query (all needed columns live in the index leaf):

-- covering index for the same query
CREATE INDEX idx_students_performance_name_age ON students_performance (name, age);
-- DROP INDEX idx_students_performance_name_age ON students_performance;

EXPLAIN ANALYZE
SELECT age
FROM students_performance
WHERE name = 'Diana Richmond';

/*
Covering index lookup on students_performance using idx_students_performance_name_age (name='Diana Richmond') 
 (cost=1.77 rows=5) (actual time=0.144..0.161 rows=5 loops=1)
*/


-- Now the optimizer can read everything from idx_students_performance_name_age alone

-- You should see Extra: Using index (covering read), fewer row lookups and I/O
-- ⚠️ In production, idx_name_age makes idx_name redundant for most workloads (leftmost-prefix rule). After testing, drop the redundant one:

-- DROP INDEX idx_students_performance_name ON students_performance;


-- 4) Simple “two identical subselects” → then replace with 1 CTE
-- A. Inefficient: duplicate subqueries

-- SELECT SLEEP(40); -- Check if it fail 

-- 10 minutes

CREATE INDEX idx_students_performance_age ON students_performance (age);
CREATE INDEX idx_students_performance_math_score ON students_performance (math_score);

EXPLAIN ANALYZE
SELECT
  s.id,
  s.name,
  s.gender,
  s.age,
  s.math_score,
  s.reading_score,
  s.writing_score,
  (SELECT AVG(math_score)   FROM students_performance WHERE age > 20 AND math_score > 70) AS avg_math_overall,
  (SELECT AVG(reading_score)FROM students_performance WHERE age > 20 AND math_score > 70) AS avg_reading_overall,
  (SELECT AVG(writing_score)FROM students_performance WHERE age > 20 AND math_score > 70) AS avg_writing_overall,
  (SELECT AVG(sp2.math_score)    FROM students_performance sp2 WHERE sp2.gender = s.gender AND sp2.age > 20 AND sp2.math_score > 70) AS avg_math_by_gender,
  (SELECT AVG(sp2.reading_score) FROM students_performance sp2 WHERE sp2.gender = s.gender AND sp2.age > 20 AND sp2.math_score > 70) AS avg_reading_by_gender,
  (SELECT AVG(sp2.writing_score) FROM students_performance sp2 WHERE sp2.gender = s.gender AND sp2.age > 20 AND sp2.math_score > 70) AS avg_writing_by_gender
FROM students_performance s
WHERE s.age > 20 AND s.math_score > 70;


-- OPTIONAL: LIMIT 1000;

/*

*/

-- The same aggregation is computed twice per row group → unnecessary work.

-- B. Optimized: compute once in a CTE and join



EXPLAIN ANALYZE
WITH filtered AS (
  SELECT *
  FROM students_performance
  WHERE age > 20 AND math_score > 70
),
overall AS (
  SELECT
    AVG(math_score)   AS avg_math_overall,
    AVG(reading_score)AS avg_reading_overall,
    AVG(writing_score)AS avg_writing_overall
  FROM filtered
),
by_gender AS (
  SELECT
    gender,
    AVG(math_score)    AS avg_math_by_gender,
    AVG(reading_score) AS avg_reading_by_gender,
    AVG(writing_score) AS avg_writing_by_gender
  FROM filtered
  GROUP BY gender
)
SELECT
  f.id,
  f.name,
  f.gender,
  f.age,
  f.math_score,
  f.reading_score,
  f.writing_score,
  o.avg_math_overall,
  o.avg_reading_overall,
  o.avg_writing_overall,
  g.avg_math_by_gender,
  g.avg_reading_by_gender,
  g.avg_writing_by_gender
FROM filtered f
CROSS JOIN overall o
LEFT JOIN by_gender g ON g.gender = f.gender;
/*
-- 15 sec

-> Nested loop left join  (cost=6.36e+6 rows=0) (actual time=4902..10682 rows=666904 loops=1)
    -> Filter: ((students_performance.age > 20) and (students_performance.math_score > 70))  (cost=1.02e+6 rows=2.13e+6) (actual time=0.0338..4976 rows=666904 loops=1)
        -> Table scan on students_performance  (cost=1.02e+6 rows=9.5e+6) (actual time=0.0325..3938 rows=9e+6 loops=1)
    -> Index lookup on g using <auto_key0> (gender=students_performance.gender)  (cost=0.25..2.5 rows=10) (actual time=0.008..0.00822 rows=1 loops=666904)
        -> Materialize CTE by_gender  (cost=0..0 rows=0) (actual time=4902..4902 rows=2 loops=1)
            -> Table scan on <temporary>  (actual time=4902..4902 rows=2 loops=1)
                -> Aggregate using temporary table  (actual time=4902..4902 rows=2 loops=1)
                    -> Filter: ((students_performance.age > 20) and (students_performance.math_score > 70))  (cost=1.02e+6 rows=2.13e+6) (actual time=0.0264..4348 rows=666904 loops=1)
                        -> Table scan on students_performance  (cost=1.02e+6 rows=9.5e+6) (actual time=0.0255..3318 rows=9e+6 loops=1)

*/