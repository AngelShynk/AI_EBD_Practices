# 🧠 Practical Assignment 3: Data Warehouse Modeling

## 🎯 Objective
In this assignment, you will **design and model a Data Warehouse (DWH)** for a chosen business.  
You will apply **dimensional modeling principles** and organize data into **layered architecture (raw → stage → mart)**.

### 👥 Teamwork
This is a **team assignment**.  

Teams consist of 2–3 students and are formed independently by the students. Working individually is also allowed if a team cannot be joined. Each team evaluates and reports the contribution of every member, which is taken into account during grading.

---

## 📋 Requirements (15 Points)

| Criteria | Description |
|-----------|--------------|
| **Business case** | Choose a real or hypothetical business (e.g., retail, e-commerce, marketing) |
| **Source data** | At least **3 raw data sources** (You can generate your data or use public dataset) |
| **Data lineage** | Visualize Data Lineage |
| **Layers** | Implement **raw**, **stage**, and **mart** layers |
| **Model type** | Use **dimensional modeling** (facts + dimensions) |
| **Fact table** | Include **at least 1 fact table** with numeric measures |
| **Dimensions** | Include **at least 3 dimension tables** (e.g., date, product, customer) |
| **Transformation logic** | Show how data moves from raw → stage → mart |
| **Documentation** | Short README explaining design choices |
| **GitHub submission** | Include SQL/DBT scripts and Lineage Graph |

**Bonus (2 points):**
- Implement **Slowly Changing Dimension (SCD) Type 2** handling in one dimension table



## 🧠 Practice Questions About DWH & Modeling

1. What is a fact table and what kind of data does it store?  
2. What is a dimension table and how does it relate to a fact table?  
3. Explain the difference between **star** and **snowflake** schemas.  
4. What is the purpose of the **stage layer** in a DWH?  
5. Why is the **raw layer** important in data pipelines? 
6. What is the purpose of the **mart layer** in a DWH?  
7. How would you handle slowly changing dimensions (SCD Type 1 vs Type 2)?  
8. What is the main difference between **Type 1**, **Type 2**, and **Type 3** SCDs?  
9. What is Data Lineage? 
10. What is a Data Warehouse (DWH), and what is its main purpose?