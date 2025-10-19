-- Create dataset demo (run once per project if needed)
-- CREATE SCHEMA demo;

CREATE OR REPLACE TABLE demo.sales_events (
  user_id INT64,
  status STRING,              -- 'COMPLETED' | 'FAILED'
  product STRING,
  ts TIMESTAMP,
  revenue FLOAT64,
  email STRING,
  backup_email STRING,
  url STRING
);

INSERT INTO demo.sales_events
  (user_id, status, product, ts, revenue, email, backup_email, url)
VALUES
  (1,'COMPLETED','Phone',      TIMESTAMP '2025-10-01 10:00:00', 500.0,'a@example.com', NULL,'https://shop.example.com/item/1'),
  (1,'FAILED',   'Case',       TIMESTAMP '2025-10-02 12:00:00',   0.0,'a@example.com', NULL,'https://shop.example.com/item/2'),
  (1,'COMPLETED','Charger',    TIMESTAMP '2025-10-05 09:00:00',  30.0,'a@example.com', NULL,'http://example.org/offer'),
  (2,'FAILED',   'Laptop',     TIMESTAMP '2025-10-03 14:00:00',   0.0, NULL,'b@backup.com','https://store.test.co.uk/deal'),
  (2,'COMPLETED','Mouse',      TIMESTAMP '2025-10-04 16:00:00',  20.0, NULL,'b@backup.com','https://store.test.co.uk/mouse'),
  (3,'FAILED',   'Subscription',TIMESTAMP '2025-10-06 08:30:00',  0.0, NULL, NULL,'https://news.site.com/sub'),
  (1,'COMPLETED','Headphones', TIMESTAMP '2025-10-07 11:00:00',  80.0,'a@example.com', NULL,'https://shop.example.com/item/3');


-- SELECT * FROM demo.sales_events;

-- COUNTIF(condition) – Counts rows matching a condition.

-- total failed
SELECT COUNTIF(status = 'FAILED') AS failed_jobs
FROM demo.sales_events;

-- failed by user
SELECT user_id, COUNTIF(status = 'FAILED') AS failed_jobs
FROM demo.sales_events
GROUP BY user_id
ORDER BY user_id;

-- multiply conditions
SELECT
  COUNT(*) as all_jobs, 
  COUNTIF(status = 'FAILED') AS failed_jobs, 
  COUNTIF(status = 'FAILED' and url LIKE '%/store.test.%') AS failed_jobs_store_test
FROM demo.sales_events;


-- INTERVAL
SELECT 
  CURRENT_DATE() AS today,
  CURRENT_DATE() - INTERVAL 7 DAY AS seven_days_ago,
  CURRENT_TIMESTAMP() + INTERVAL 3 HOUR AS in_three_hours;


--drop table demo.sales_events;

