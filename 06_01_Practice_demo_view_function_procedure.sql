-- 1) Create a View

-- Views let you save a query as a reusable virtual table.

USE p05;

-- View: customer spending summary
CREATE OR REPLACE VIEW v_customer_totals AS
SELECT
  c.customer_id,
  COALESCE(c.segment, 'Unknown') AS segment,
  COUNT(o.order_id)              AS total_orders,
  SUM(IFNULL(o.amount,0))        AS total_spend
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.segment;

-- Test the view
SELECT * FROM v_customer_totals;

-- 2) User-Defined Function (UDF)

-- Functions return a value and can be used inside queries.
DROP FUNCTION IF EXISTS spend_category;
DELIMITER $$

CREATE FUNCTION spend_category(total DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  DECLARE category VARCHAR(20);

  IF total IS NULL OR total = 0 THEN
    SET category = 'none';
  ELSEIF total < 100 THEN
    SET category = 'low';
  ELSEIF total < 200 THEN
    SET category = 'medium';
  ELSE
    SET category = 'high';
  END IF;

  RETURN category;
END$$


DELIMITER ;

-- Example: use UDF in query
SELECT
  customer_id,
  total_spend,
  spend_category(total_spend) AS spend_cat
FROM v_customer_totals;

-- 3) Stored Procedure

-- Procedures let you run a block of logic with optional parameters.

DROP PROCEDURE IF EXISTS manage_order;
DELIMITER $$

CREATE PROCEDURE manage_order(
    IN action_type VARCHAR(10),
    IN p_order_id INT,
    IN p_customer_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_channel VARCHAR(20)
)
BEGIN
    IF UPPER(action_type) = 'INSERT' THEN
        INSERT INTO orders(order_id, customer_id, amount, channel)
        VALUES (p_order_id, p_customer_id, p_amount, p_channel);

    ELSEIF UPPER(action_type) = 'DELETE' THEN
        DELETE FROM orders
        WHERE order_id = p_order_id;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid action_type. Use INSERT or DELETE.';
    END IF;
END$$

DELIMITER ;

-- Usage
CALL manage_order('INSERT', 200, 1, 75.50, 'web');

-- Check it worked
SELECT * FROM orders WHERE order_id = 200;
