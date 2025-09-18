# MySQL Practice Tasks — Views, Functions, Procedures (Movies Dataset)

This set uses a tiny **Movies** dataset (no `orders`/`customers`).  
Each task includes the **necessary table creation** and **sample inserts** so you can run it from scratch.

---

## 📝 Task 1: Create a Simple View (0.25)

Create a view named **`v_director_stats`** in database **`p05`** that summarizes films per director.

### Starter schema + sample data
```sql
-- Create isolated sandbox
DROP DATABASE IF EXISTS p05;
CREATE DATABASE p05;
USE p05;

-- Base tables
CREATE TABLE directors (
  director_id INT PRIMARY KEY,
  name        VARCHAR(50) NOT NULL
);

CREATE TABLE movies (
  movie_id     INT PRIMARY KEY,
  director_id  INT,
  title        VARCHAR(100) NOT NULL,
  release_year INT,
  rating       DECIMAL(3,1),       -- e.g., 7.5
  FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

-- Sample data
INSERT INTO directors VALUES
  (1, 'Greta Gerwig'),
  (2, 'Christopher Nolan'),
  (3, 'Hayao Miyazaki');

INSERT INTO movies VALUES
  (101, 1, 'Lady Bird',           2017, 7.4),
  (102, 1, 'Little Women',        2019, 7.8),
  (201, 2, 'Inception',           2010, 8.8),
  (202, 2, 'Interstellar',        2014, 8.6),
  (301, 3, 'Spirited Away',       2001, 8.6),
  (302, 3, 'Howl''s Moving Castle', 2004, 8.2);
```

### Your task
Create **`v_director_stats`** with columns:
- `director_id`
- `director_name` (from `directors.name`)
- `film_count` (`COUNT(m.movie_id)`)
- `avg_rating` (`AVG(m.rating)`, rounded to 2 decimals)

**Steps:**
1. `USE p05;`

   ```

---

## 📝 Task 2: Create a Simple Function (0.5)

Create a **deterministic** scalar function **`rating_level`** that classifies a movie rating.

**Requirements:**
- Signature: `rating_level(score DECIMAL(3,1)) RETURNS VARCHAR(20)`
- Logic:
  - `NULL` → `'unrated'`
  - `< 6.0` → `'weak'`
  - `< 7.5` → `'decent'`
  - `< 8.5` → `'strong'`
  - otherwise → `'excellent'`
- Use a **single-statement** `RETURN CASE …` (no delimiter hassles).
- Then use it with `v_director_stats` or `movies`.

**Steps:**
1. Ensure DB: `USE p05;`
2. Create the function:

3. Verify with the **movies** table:

---

## 📝 Task 3: Create a Procedure for Insert/Delete (0.5)

Create a stored procedure **`manage_movie`** that can **INSERT** or **DELETE** rows in the `movies` table based on an input parameter.

**Requirements:**
- Inputs:
  - `action_type VARCHAR(10)` → `'INSERT'` or `'DELETE'` (case-insensitive)
  - `p_movie_id INT`
  - `p_director_id INT`
  - `p_title VARCHAR(100)`
  - `p_year INT`
  - `p_rating DECIMAL(3,1)`
- Behavior:
  - If `action_type = 'INSERT'`: insert a new row into `movies`
  - If `action_type = 'DELETE'`: delete by `movie_id`
  - Otherwise: raise an error with `SIGNAL SQLSTATE '45000'`

**Steps:**
1. `USE p05;`
2. Create the procedure (note delimiter change):
   
---

### ✅ Points
- View: **0.25**
- Function: **0.5**
- Procedure: **0.5**

Good luck & have fun! 🎬
