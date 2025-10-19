-- Create dataset if not exists
-- CREATE SCHEMA demo;

-- Create table for numbering function demo
CREATE OR REPLACE TABLE demo.sales_events (
  user_id INT64,
  revenue FLOAT64
);

-- Insert sample data
INSERT INTO demo.sales_events (user_id, revenue)
VALUES
  (1, 500.00),
  (2, 300.00),
  (3, 300.00),
  (4, 200.00),
  (5, 100.00);

-- Example using numbering functions
SELECT 
  user_id,
  revenue,
  ROW_NUMBER() OVER(ORDER BY revenue DESC) AS row_number,
  RANK() OVER(ORDER BY revenue DESC) AS rank,
  DENSE_RANK() OVER(ORDER BY revenue DESC) AS dense_rank
FROM demo.sales_events;