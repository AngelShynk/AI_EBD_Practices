-- Famous Paintings dataset -> MySQL schema
-- Source dataset: Kaggle (mexwell/famous-paintings)
-- This DDL targets MySQL 8.0+ (InnoDB, utf8mb4).

/* ---------------------------
   Database
----------------------------*/
DROP DATABASE IF EXISTS p08;
CREATE DATABASE p08;
USE p08;

CREATE TABLE students_performance (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender ENUM('Male', 'Female'),
    math_score INT,
    reading_score INT,
    writing_score INT
);


-- Execute Python script to insert data

select count(*) from students_performance;


select * from students_performance limit 10;

-- CREATE INDEX idx_students_performance_name ON students_performance(name);

select * from students_performance where name = 'Diana Richmond';

-- drop index idx_students_performance_name on students_performance;

EXPLAIN ANALYZE select * from students_performance where name = 'Diana Richmond';
