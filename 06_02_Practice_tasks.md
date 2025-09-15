#MySQL Practice Tasks — Views, Functions, Procedures

## 📝 Task 1: Create a Simple View (0.25)
Create a view named **`v_customer_totals`** in database **`p05`** that summarizes totals per customer from tables **`customers`** and **`orders`**.

**Requirements:**
- Columns: `customer_id`, `segment` (use `COALESCE(segment,'Unknown')`), `total_orders` (`COUNT(o.order_id)`), `total_spend` (`SUM(IFNULL(o.amount,0))`)
- Join `customers c` to `orders o` on `c.customer_id = o.customer_id` (LEFT JOIN so customers with no orders still appear)
- Group by `c.customer_id, c.segment`

**Steps:**
1. `USE p05;`
2. Create the view **`v_customer_totals`** with the requirements above.  
3. Verify:  
   - `SELECT * FROM v_customer_totals;`  
   - Optionally, `DESCRIBE v_customer_totals;`

---

## 📝 Task 2: Create a Simple Function (0.5)
Create a **deterministic** scalar function named **`spend_category`** that classifies a numeric total into a text label.

**Requirements:**
- Signature: `spend_category(total DECIMAL(10,2)) RETURNS VARCHAR(20)`
- Logic:
  - `NULL` or `0` → `'none'`
  - `total < 100` → `'low'`
  - `total < 200` → `'medium'`
  - otherwise → `'high'`

**Steps:**
1. `USE p05;`  
2. `DROP FUNCTION IF EXISTS spend_category;`  
3. Create the function:  
   ```sql
   CREATE FUNCTION spend_category(total DECIMAL(10,2))
   RETURNS VARCHAR(20)
   DETERMINISTIC
   RETURN CASE
     WHEN total IS NULL OR total = 0 THEN 'none'
     WHEN total < 100 THEN 'low'
     WHEN total < 200 THEN 'medium'
     ELSE 'high'
   END;
   ```
4. Verify:  
   ```sql
   SELECT spend_category(NULL), spend_category(0), spend_category(50), spend_category(150), spend_category(250);
   ```

---

## 📝 Task 3: Create a Procedure for Insert/Delete (0.5)
Create a stored procedure **`manage_order`** that performs **INSERT** or **DELETE** on the `orders` table based on an input parameter.

**Requirements:**
- Inputs:  
  - `action_type VARCHAR(10)` → `'INSERT'` or `'DELETE'`  
  - `p_order_id INT`  
  - `p_customer_id INT`  
  - `p_amount DECIMAL(10,2)`  
  - `p_channel VARCHAR(20)`  
- Behavior:  
  - If `action_type = 'INSERT'`: insert row into `orders`  
  - If `action_type = 'DELETE'`: delete from `orders` by `order_id`  

**Steps:**
1. `USE p05;`  
2. `DROP PROCEDURE IF EXISTS manage_order;`  
3. Create the procedure:  
   ```sql
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
   ```
4. Verify:  
   - `CALL manage_order('INSERT', 999, 1, 42.50, 'web');`  
   - `CALL manage_order('DELETE', 999, NULL, NULL, NULL);`

---
