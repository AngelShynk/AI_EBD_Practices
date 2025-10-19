-- Sample data
-- CREATE SCHEMA demo;
CREATE OR REPLACE TABLE demo.company_revenue (
  country STRING,
  company STRING,
  revenue INT64
);

INSERT INTO demo.company_revenue (country, company, revenue) VALUES
  ('US','Apex',1200), ('US','Beacon',1100), ('US','Cobalt',950), ('US','Delta',940), ('US','Echo',900),
  ('DE','Alfa',800),  ('DE','Berg',790),    ('DE','Chem',700),  ('DE','Dorf',690),
  ('JP','Kai',1000),  ('JP','Mori',1000),   ('JP','Neko',600),  ('JP','Oto',550);


  -- Classic top-3 per country; unique 1..N numbering even if revenues tie
SELECT country, company, revenue, rn
FROM (
  SELECT
    country, company, revenue,
    ROW_NUMBER() OVER (PARTITION BY country ORDER BY revenue DESC) AS rn
  FROM demo.company_revenue
)
WHERE rn <= 3
ORDER BY country, rn;

-- QUALIFY lets you filter directly on window function results (like rn) without needing a subquery — cleaner and easier to read.
SELECT
  country,
  company,
  revenue,
  ROW_NUMBER() OVER (PARTITION BY country ORDER BY revenue DESC) AS rn
FROM demo.company_revenue
QUALIFY rn <= 3
ORDER BY country, rn;
