# MySQL Practice Tasks

## 📝 Task 1: Create Table with Simple Constraints (0.5)
Create a table named **`students`** with:

- `id` → `INT`, **Primary Key**, **Auto Increment**  
- `name` → `VARCHAR(30)`, **NOT NULL**, **UNIQUE**  
- `age` → `INT` (can be null)  

**Steps:**
1. Create the table with the above structure.  
2. Insert at least 3 sample rows (e.g., Alice, Bob, Charlie).  
3. Run `SELECT * FROM students;` to verify the data.  

---

## 📝 Task 2: Practice `ALTER TABLE` (0.5)
On the **`students`** table, perform the following operations:

1. Add a new column `email VARCHAR(50)`.  
2. Modify the column `age` so it becomes `age INT NOT NULL`.  
3. Rename the column `name` to `full_name`.  
4. Rename the table from `students` to `school_students`.  

---

## 📝 Task 3: Practice `DELETE`, `TRUNCATE`, and `DROP` (0.25)
Using the **`school_students`** table:

1. Delete the row where `full_name = 'Alice'`.  
2. Truncate the table (remove all rows but keep structure).  
3. Drop the table completely so it no longer exists.  

---
