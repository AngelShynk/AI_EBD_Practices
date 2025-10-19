-- Create dataset if not exists
-- CREATE SCHEMA demo;

-- 1. Create table for lead/lag example
CREATE OR REPLACE TABLE demo.daily_sales (
  sale_date DATE,
  revenue INT64
);

-- 2. Insert example data
INSERT INTO demo.daily_sales (sale_date, revenue)
VALUES
  ('2025-10-01', 1000),
  ('2025-10-02', 1200),
  ('2025-10-03', 1150),
  ('2025-10-04', 1300),
  ('2025-10-05', 1250),
  ('2025-10-06', 1400);

-- 3. Use LEAD and LAG functions
SELECT
  sale_date,
  revenue,
  LAG(revenue) OVER (ORDER BY sale_date) AS prev_day_revenue,
  LEAD(revenue) OVER (ORDER BY sale_date) AS next_day_revenue,
  revenue - LAG(revenue) OVER (ORDER BY sale_date) AS change_from_prev
FROM demo.daily_sales
ORDER BY sale_date;
