/*
cheatsheet

NULL-safe equality: a <=> b (true when both NULL).
Not null-safe: a = b (NULL comparisons are unknown → no match).

Fill NULLs: IFNULL(x, v)/COALESCE(x, v, ...).

Turn 0 → NULL: NULLIF(x, 0).
Turn NULL → 0: IFNULL(x, 0).

COUNT_IF in MySQL: SUM(condition) since TRUE = 1, FALSE = 0.
*/


-- ─────────────────────────────────────────
-- 0) Setup (MySQL)
-- ─────────────────────────────────────────
DROP DATABASE IF EXISTS p05;
CREATE DATABASE p05;
USE p05;

CREATE TABLE customers (
  customer_id INT,
  segment     VARCHAR(20)
);

INSERT INTO customers VALUES
  (1, 'Retail'),
  (2, NULL),
  (3, 'B2B');

CREATE TABLE orders (
  order_id     INT,
  customer_id  INT,
  amount       DECIMAL(10,2),
  channel      VARCHAR(20)
);

INSERT INTO orders VALUES
  (101, 1, 120.00, 'web'),
  (102, 1, NULL,   NULL),
  (103, 2,  0.00,  'store'),
  (104, 3,  50.00, NULL);

-- ─────────────────────────────────────────
-- 1) Minimal IF / CASE
-- ─────────────────────────────────────────

-- IF(cond, then, else)
SELECT order_id,
       amount,
       IF(amount IS NULL, 'unknown', IF(amount = 0, 'free', 'paid')) AS amount_bucket
FROM orders
ORDER BY order_id;

-- CASE WHEN
SELECT order_id,
       channel,
       CASE
         WHEN channel IS NULL THEN 'unspecified'
         WHEN channel = 'web'  THEN 'online'
         ELSE 'offline'
       END AS channel_grp
FROM orders
ORDER BY order_id;

-- ─────────────────────────────────────────
-- 2) NULL handling essentials
-- ─────────────────────────────────────────

-- Fill NULLs
SELECT order_id,
       COALESCE(channel, 'unknown') AS channel_filled,
       IFNULL(amount, 0)            AS amount_filled      -- same as COALESCE(amount,0)
FROM orders
ORDER BY order_id;

-- Toggle numbers around NULL/0
SELECT order_id,
       amount,
       IFNULL(amount, 0) AS amount_zero_if_null,  -- Snowflake ZEROIFNULL
       NULLIF(amount, 0) AS amount_null_if_zero   -- Snowflake NULLIFZERO
FROM orders
ORDER BY order_id;

-- ─────────────────────────────────────────
-- 3) NULL-safe vs NOT NULL-safe comparisons
--    MySQL’s NULL-safe equality is "<=>"
--    (treats NULL = NULL as TRUE). Inequality: NOT (a <=> b)
-- ─────────────────────────────────────────

-- (A) WHERE comparisons

-- NOT NULL-safe: "= NULL" never matches
SELECT order_id, channel
FROM orders
WHERE channel = NULL          -- returns 0 rows
ORDER BY order_id;

-- NULL-safe: "<=> NULL" matches rows where channel IS NULL
SELECT order_id, channel
FROM orders
WHERE channel <=> NULL
ORDER BY order_id;

-- Regular equality (not null-safe)
SELECT customer_id, segment
FROM customers
WHERE segment = 'Retail'
ORDER BY customer_id;

-- NULL-safe equality against a value
SELECT customer_id, segment
FROM customers
WHERE segment <=> 'Retail'
ORDER BY customer_id;

-- (B) JOINs

-- Standard join (not null-safe on segment—NULLs won’t match)
SELECT o.order_id, c.customer_id, c.segment
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- NULL-safe join ON a value using "<=>"
CREATE TABLE target_segments (segment VARCHAR(20));
INSERT INTO target_segments VALUES ('Retail'), (NULL);

SELECT c.customer_id, c.segment, t.segment AS target_segment
FROM customers c
LEFT JOIN target_segments t
  ON c.segment <=> t.segment      -- matches when both are NULL too
ORDER BY c.customer_id;

-- ─────────────────────────────────────────
-- 4) Aggregations with NULLs
--    COUNT(col)/SUM/AVG ignore NULLs by default
--    COUNT_IF emulation with SUM(condition)
-- ─────────────────────────────────────────
SELECT
  COUNT(*)                         AS rows_total,
  COUNT(amount)                    AS amount_non_null,        -- ignores NULLs
  SUM(amount IS NULL)              AS amount_nulls,           -- COUNT_IF(amount IS NULL)
  SUM(amount)                      AS sum_ignore_nulls,       -- ignores NULLs
  SUM(IFNULL(amount, 0))           AS sum_nulls_as_zero,
  AVG(amount)                      AS avg_ignore_nulls,
  AVG(IFNULL(amount, 0))           AS avg_nulls_as_zero
FROM orders;
