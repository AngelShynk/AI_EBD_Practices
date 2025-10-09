# 🧠 Practical Assignment: MySQL Query Optimization

## 🎯 Objective
In this assignment, you will **learn to identify and optimize inefficient SQL queries** in MySQL.  
You will start by generating an **unoptimized query via AI**, and then **apply optimization techniques** to improve its performance.  
You will demonstrate your understanding by comparing execution plans, explaining your steps, and using indexes, CTEs, and optimizer hints.

---

## 📋 Requirements (15 Points)

| Criteria | Description |
|-----------|--------------|
| **Data volume** | Use **at least 3 tables** with **≥1 000 000 rows each** |
| **Query complexity** | Include **at least 2 JOINs** (joining 3+ tables) |
| **Two query variants** | 1️⃣ Non-optimized (AI-generated) <br> 2️⃣ Optimized (your version) |
| **Identical results** | Both queries must return **exactly the same data** |
| **Optimization methods** | Use **CTEs**, **indexes**, and **query rewriting** |
| **Execution plans** | Compare **before/after** using `EXPLAIN` and `EXPLAIN ANALYZE` |
| **Documentation** | Step-by-step explanation with correct terminology |
| **GitHub submission** | All code and documentation must be committed to your repo |
| **Presentation** | Be ready to discuss your optimization approach |

**Bonus (2 points):**
- Use **MySQL optimizer hints** such as `USE INDEX` or `/*+ SUBQUERY(MATERIALIZATION) */`
- Explain their impact (positive or negative)

---

## 🧠 10 Practice Questions About MySQL Optimization

During the assignment defense, each student will be asked two questions related to MySQL query optimization (examples provided below).

- For each incorrect or incomplete answer, 2 points will be deducted from your total score.
- Therefore, you can lose up to 4 points in this section.

Be prepared to explain your optimization decisions clearly using proper terminology (e.g., indexing, join strategy, CTE usage, execution plan interpretation).


1. What is the difference between EXPLAIN and EXPLAIN ANALYZE in MySQL?
2. What is a covering index, and why is it useful?
3. What does “Table scan” mean in an execution plan?
4. How can a composite index improve query performance?
5. What’s the difference between clustered and non-clustered indexes in MySQL?
6. How does join order affect query performance?
7. When is it better to use a CTE over a subquery?
8. What are optimizer hints, and when should you avoid them?
9. How can you detect a full table scan, and when is it acceptable?
10. Why might adding too many indexes hurt performance?
