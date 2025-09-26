# 09 Practice Tasks

### 0. Drop all secondary indexes on students_performance table

### 1. Optimize query via index/indexes - **0.25**
```sql
SELECT
  id, name, age, gender, math_score, reading_score, writing_score
FROM students_performance
WHERE age > 16
  AND math_score > 70
ORDER BY reading_score DESC
LIMIT 20;
```

### 2. Optimize query - **0.5**
```sql
EXPLAIN
SELECT
    s.id,
    s.name,
    s.gender,
    s.age,
    s.math_score,
    s.reading_score,
    s.writing_score
FROM students_performance s
WHERE s.age > 16
  AND s.math_score > 70
  AND s.math_score >
        (SELECT AVG(sp2.math_score)
         FROM students_performance sp2
         WHERE sp2.gender = s.gender)
  AND s.reading_score >
        (SELECT AVG(sp2.reading_score)
         FROM students_performance sp2
         WHERE sp2.gender = s.gender)
  AND s.writing_score >
        (SELECT AVG(sp2.writing_score)
         FROM students_performance sp2
         WHERE sp2.gender = s.gender);
;
```