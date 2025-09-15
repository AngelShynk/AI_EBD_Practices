-- Only if you need to recreate quickly
DROP DATABASE IF EXISTS p05;
CREATE DATABASE p05;
USE p05;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  segment     VARCHAR(20)
);
INSERT INTO customers VALUES (1,'Retail'),(2,NULL),(3,'B2B');

CREATE TABLE orders (
  order_id     INT PRIMARY KEY,
  customer_id  INT,
  amount       DECIMAL(10,2),
  channel      VARCHAR(20)
);
INSERT INTO orders VALUES
  (101,1,120.00,'web'),
  (102,1,NULL,  NULL),
  (103,2,0.00,  'store'),
  (104,3,50.00, NULL);

-- 1) Subqueries in different places (no windows)
-- A) Subquery in the SELECT list (scalar, correlated)
SELECT
  c.customer_id,
  c.segment,
  (
    SELECT SUM(IFNULL(o.amount,0))
    FROM orders o
    WHERE o.customer_id = c.customer_id
  ) AS total_spend
FROM customers c
ORDER BY c.customer_id;

-- B) Subquery in the WHERE clause (EXISTS / IN)
-- EXISTS: customers having at least one NULL-channel order
SELECT c.customer_id, c.segment
FROM customers c
WHERE EXISTS (
  SELECT 1
  FROM orders o
  WHERE o.customer_id = c.customer_id
    AND o.channel IS NULL
);

-- IN: orders made by customers who ever paid (> 0)
SELECT o.*
FROM orders o
WHERE o.customer_id IN (
  SELECT customer_id
  FROM orders
  WHERE IFNULL(amount,0) > 0
);

-- C) Subquery in the FROM clause (derived table)
-- Aggregate once, then join for context
SELECT
  c.customer_id,
  c.segment,
  t.total_orders,
  t.total_spend
FROM customers c
LEFT JOIN (
  SELECT
    customer_id,
    COUNT(*) AS total_orders,
    SUM(IFNULL(amount,0)) AS total_spend
  FROM orders
  GROUP BY customer_id
) AS t
  ON t.customer_id = c.customer_id
ORDER BY c.customer_id;

-- 2) CTEs (WITH) — simple & clear (no windows)
-- A) Single CTE
WITH cust_totals AS (
  SELECT
    customer_id,
    COUNT(*) AS total_orders,
    SUM(IFNULL(amount,0)) AS total_spend
  FROM orders
  GROUP BY customer_id
)
SELECT
  c.customer_id,
  c.segment,
  ct.total_orders,
  ct.total_spend
FROM customers c
LEFT JOIN cust_totals ct
  ON ct.customer_id = c.customer_id
ORDER BY c.customer_id;

-- B) Multiple CTEs (2–3 steps), still window-free
WITH orders_clean AS (
  SELECT order_id, customer_id, IFNULL(amount,0) AS amount, channel
  FROM orders
),
cust_totals AS (
  SELECT customer_id,
         COUNT(*) AS total_orders,
         SUM(amount) AS total_spend,
         SUM(amount > 0) AS paid_orders
  FROM orders_clean
  GROUP BY customer_id
),
seg_avg AS (
  -- average spend per segment (NULL → 'Unknown')
  SELECT
    COALESCE(c.segment, 'Unknown') AS segment_key,
    AVG(ct.total_spend)            AS avg_segment_spend
  FROM customers c
  JOIN cust_totals ct
    ON ct.customer_id = c.customer_id
  GROUP BY COALESCE(c.segment, 'Unknown')
)
SELECT
  c.customer_id,
  COALESCE(c.segment, 'Unknown') AS segment_key,
  ct.total_orders,
  ct.paid_orders,
  ct.total_spend,
  seg.avg_segment_spend,
  CASE
    WHEN ct.total_spend >= seg.avg_segment_spend THEN 'above_or_equal_segment_avg'
    ELSE 'below_segment_avg'
  END AS spend_vs_segment
FROM customers c
JOIN cust_totals ct
  ON ct.customer_id = c.customer_id
JOIN seg_avg seg
  ON seg.segment_key = COALESCE(c.segment, 'Unknown')
ORDER BY segment_key, c.customer_id;

-- C) “Top spender(s)” without windows
WITH cust_totals AS (
  SELECT customer_id, SUM(IFNULL(amount,0)) AS total_spend
  FROM orders
  GROUP BY customer_id
),
max_total AS (
  SELECT MAX(total_spend) AS mx FROM cust_totals
)
SELECT c.customer_id, c.segment, ct.total_spend
FROM customers c
JOIN cust_totals ct ON ct.customer_id = c.customer_id
JOIN max_total m    ON ct.total_spend = m.mx;

-- 3) Same result: CTEs vs nested subqueries (readability contrast)
-- A) Clear version (CTEs)
WITH orders_clean AS (
  SELECT customer_id, IFNULL(amount,0) AS amount FROM orders
),
cust_totals AS (
  SELECT customer_id, SUM(amount) AS total_spend
  FROM orders_clean
  GROUP BY customer_id
),
seg_avg AS (
  SELECT COALESCE(c.segment,'Unknown') AS segment_key,
         AVG(ct.total_spend)           AS avg_segment_spend
  FROM customers c
  JOIN cust_totals ct ON ct.customer_id = c.customer_id
  GROUP BY COALESCE(c.segment,'Unknown')
)
SELECT
  c.customer_id,
  COALESCE(c.segment,'Unknown') AS segment_key,
  ct.total_spend,
  s.avg_segment_spend,
  CASE
    WHEN ct.total_spend >= s.avg_segment_spend THEN 'above_or_equal_segment_avg'
    ELSE 'below_segment_avg'
  END AS spend_vs_segment
FROM customers c
JOIN cust_totals ct ON ct.customer_id = c.customer_id
JOIN seg_avg s      ON s.segment_key = COALESCE(c.segment,'Unknown')
ORDER BY segment_key, c.customer_id;

-- B) Same logic using only subqueries (denser)
SELECT
  c.customer_id,
  COALESCE(c.segment,'Unknown') AS segment_key,
  /* total_spend per customer */
  (
    SELECT SUM(IFNULL(o.amount,0))
    FROM orders o
    WHERE o.customer_id = c.customer_id
  ) AS total_spend,
  /* avg per segment */
  (
    SELECT AVG(x.total_spend)
    FROM (
      SELECT c2.segment,
             c2.customer_id,
             SUM(IFNULL(o2.amount,0)) AS total_spend
      FROM customers c2
      JOIN orders o2 ON o2.customer_id = c2.customer_id
      GROUP BY c2.segment, c2.customer_id
    ) AS x
    WHERE COALESCE(x.segment,'Unknown') = COALESCE(c.segment,'Unknown')
  ) AS avg_segment_spend,
  CASE
    WHEN
      (
        SELECT SUM(IFNULL(o.amount,0))
        FROM orders o
        WHERE o.customer_id = c.customer_id
      )
      >=
      (
        SELECT AVG(x.total_spend)
        FROM (
          SELECT c2.segment,
                 c2.customer_id,
                 SUM(IFNULL(o2.amount,0)) AS total_spend
          FROM customers c2
          JOIN orders o2 ON o2.customer_id = c2.customer_id
          GROUP BY c2.segment, c2.customer_id
        ) AS x
        WHERE COALESCE(x.segment,'Unknown') = COALESCE(c.segment,'Unknown')
      )
    THEN 'above_or_equal_segment_avg'
    ELSE 'below_segment_avg'
  END AS spend_vs_segment
FROM customers c
ORDER BY segment_key, c.customer_id;
