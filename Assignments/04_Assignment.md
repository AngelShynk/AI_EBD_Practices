# Assignment: Steam Dataset Analysis (17 Points)

## Overview

You will work directly with the **raw semi-structured Steam dataset**:
[https://github.com/vintagedon/steam-dataset-2025/tree/main](https://github.com/vintagedon/steam-dataset-2025/tree/main)

This assignment focuses strictly on **analysis of semi-structured data**, JSON parsing, and SQL-level unnesting. You will not design data models or build a DWH structure.

---

## Part 1 — Data Preparation and Parsing (5 points)

1. Load all raw dataset files into your warehouse or SQL engine (DuckDB, BigQuery, Snowflake, PostgreSQL, etc.).
2. Identify all JSON or semi-structured columns.
3. Parse JSON using SQL JSON functions.
4. Use **UNNEST** (or `json_each`, `json_extract_array_elements`, etc.) to flatten nested arrays.
5. Produce cleaned, structured tables ready for analytical queries.

---

## Part 2 — Analytical Insights (6 points)

Provide at least 5 insights based on the prepared dataset, for example:

1. Top 20 games by number of reviews.
2. Distribution of game release years.
3. Average price by genre (after JSON parsing and unnesting).
4. Identify the most common tags across all games.


Each insight must include:

* SQL used
* A short interpretation (1–2 sentences)

---

## Part 3 — Theoretical Questions (4 points)

1. What is semi-structured data?
2. How can semi-structured data be transformed into structured data?
3. What is JSON and why is it commonly used in modern datasets?
4. What is XML and how does it compare to JSON?
5. What is Parquet and why is it used in analytical systems?
6. How do columnar file formats differ from row-based formats?
7. Why do many APIs return data in JSON rather than CSV?
8. How can SQL engines analyze external datasets without loading them (examples: external tables, stage references, `read_csv_auto`, `read_parquet`, etc.)?

---

## Part 4 — Data Visualization (2 additional points)

Create one chart based on your analytical results. Tools: Tableau, PowerBI, Looker Studio, Google Sheets, Python or other.

Add a brief interpretation.

---

## Submission Requirements

* Provide one `.sql` or `.md` file with all SQL and written answers.
* Exported result tables where needed.
* All code must reference the raw dataset files from the GitHub repository.

---

## Total: 17 Points
