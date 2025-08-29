
-- Test SQL Script for MySQL Installation

-- 1. Create a new database
CREATE DATABASE cars;

-- 2. Use the database
USE cars;

-- 3. Prepare table
-- DROP TABLE cars;
CREATE TABLE cars (
    company_name VARCHAR(100),
    car_name VARCHAR(100),
    engine VARCHAR(50),
    cc_capacity VARCHAR(50),         -- stored as text (e.g., "3990 cc" or "1,200 cc")
    horsepower VARCHAR(50),          -- stored as text because of ranges ("70-85 hp")
    top_speed VARCHAR(50),           -- stored as text (e.g., "340 km/h")
    performance_0_100 VARCHAR(50),   -- stored as text (e.g., "2.5 sec")
    price VARCHAR(50),               -- stored as text (e.g., "$12,000-$15,000")
    fuel_type VARCHAR(50),
    seats INT,
    torque VARCHAR(50)               -- stored as text (e.g., "800 Nm" or "100 - 140 Nm")
);

-- 3. Download dataset
-- https://www.kaggle.com/datasets/abdulmalik1518/cars-datasets-2025

-- 4. Import dataset into table via

-- 5. Check table
select * from cars;
select count(*) from cars;