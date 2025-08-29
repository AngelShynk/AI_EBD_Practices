
-- 1. Create a new database
CREATE DATABASE hotels;

-- 2. Use the database
USE hotels;

-- 3. Create table
CREATE TABLE menu (
    order_id INT PRIMARY KEY,              -- Unique identifier for each order
    store_id INT,                          -- Store where the transaction happened
    transaction_datetime DATETIME,         -- Exact timestamp of the order
    business_day DATE,                     -- Business day (useful for reporting)
    daypart VARCHAR(50),                   -- Breakfast, Lunch, Dinner, etc.
    service_mode VARCHAR(50),              -- Dine-In, Drive-Thru, Takeout, etc.
    menu_item VARCHAR(100),                -- The main food/drink item ordered
    modifier VARCHAR(100),                 -- Customization (e.g., "No Cheese")
    quantity INT,                          -- Number of items ordered
    unit_price DECIMAL(6,2),               -- Price per item
    discount DECIMAL(6,2),                 -- Discount applied to the item
    tax DECIMAL(6,2),                      -- Tax applied
    total_amount DECIMAL(8,2),             -- Final total for the line item
    payment_type VARCHAR(50)               -- Cash, Card, etc.
);

-- 4. Import dataset into menu table - https://www.kaggle.com/datasets/pratyushpuri/qsr-pos-logs-hotel-menu-modifiers-and-dayparts-2025

-- 5. Perform simple selects:

-- 5.1. Select all rows from the table (basic query)
SELECT * 
FROM menu;

-- 5.2. Show only order_id, menu_item, and total_amount
-- This is helpful if we just want to see what was ordered and the cost
SELECT order_id, menu_item, total_amount 
FROM menu;

-- 5.3. Show all Drive-Thru orders
-- WHERE is used to filter results
SELECT * 
FROM menu
WHERE service_mode = 'Drive-Thru';

-- 5.4. Show all orders where quantity > 1
-- This will filter for customers who bought more than one item
SELECT order_id, menu_item, quantity, total_amount
FROM menu
WHERE quantity > 1;

-- 5.5. Show all Breakfast orders paid with Cash
SELECT order_id, menu_item, payment_type
FROM menu
WHERE daypart = 'Breakfast' AND payment_type = 'Cash';

-- 5.6. Show distinct menu items (remove duplicates)
-- DISTINCT keyword gives only unique values
SELECT DISTINCT menu_item
FROM menu;

-- 5.7. Calculate total sales for all orders
-- SUM adds up the total_amount for every row
SELECT SUM(total_amount) AS total_sales
FROM menu;

-- 5.8. Count how many orders were placed per service mode
-- GROUP BY allows aggregation for each unique service_mode
SELECT service_mode, COUNT(*) AS total_orders
FROM menu
GROUP BY service_mode;

-- 5.9. Average sales per order for each daypart
SELECT daypart, AVG(total_amount) AS avg_order_value
FROM menu
GROUP BY daypart;

-- 5.10. Top 5 menu items by total sales
SELECT menu_item, SUM(total_amount) AS total_sales
FROM menu
GROUP BY menu_item
ORDER BY total_sales DESC
LIMIT 5;


