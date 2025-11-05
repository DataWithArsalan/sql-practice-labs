/* -------------------------------------------------------------------------------------------------------------------------------------------------------
   File: 01_query_data_basics.sql
   Author: Muhammad Arsalan
   DB: ShopDB (SQL Server)
   Purpose: Basic SELECT / WHERE / ORDERY BY / GROUP BY / HAVING / DISTINCT / TOP examples for practice.
   Run: Execute in SQL Server Management Studio (SSMS) connected to ShopDB.
---------------------------------------------------------------------------------------------------------------------------------------------------------- */

-- Single-line comment in SQL Server
/*
  Multi-line comment in SQL Server.
*/

-- ========================================================================================
-- SELECT ALL COLUMNS
-- ========================================================================================

-- Retrieve all customer data
SELECT *
FROM dbo.customers;

-- Retrieve all order data
SELECT *
FROM dbo.orders;

-- ========================================================================================
-- SELECT SPECIFIC COLUMNS
-- ========================================================================================

-- Retrieve each customer's name, country, and score.
SELECT
    first_name,
    country,
    score
FROM dbo.customers;

-- ========================================================================================
-- WHERE CLAUSE
-- ========================================================================================

-- Retrieve customers with a score not equal to 0.
SELECT 
    id,
    first_name,
    country,
    score
FROM dbo.customers
WHERE score <> 0; -- use ANSI standard '<>'

-- Retrieve customers from Germany.
SELECT 
    id,
    first_name,
    country,
    score
FROM dbo.customers
WHERE country = 'Germany';

-- Retrieve the name and country of customers from Germany (case-insensitive).
SELECT 
    first_name,
    country
FROM dbo.customers
WHERE UPPER(country) = 'GERMANY';

-- ========================================================================================
-- ORDER BY CLAUSE
-- ========================================================================================

-- Retrieve all customers and sort by the highest score first.
SELECT 
    id,
    first_name,
    country,
    score
FROM dbo.customers
ORDER BY score DESC;

-- Retrieve all customers and sort by the lowest score first.
SELECT 
    id,
    first_name,
    country,
    score
FROM dbo.customers
ORDER BY score ASC; -- ASC = ascending

-- Multi-column sorting: sort by country then highest score.
SELECT 
    id,
    first_name,
    country,
    score
FROM dbo.customers
ORDER BY 
    country ASC, -- primary sort
    score DESC;   -- secondary sort

-- ========================================================================================
-- GROUP BY CLAUSE
-- ========================================================================================

-- Find the total score for each country
SELECT 
    country,
    SUM(score) AS TotalScore
FROM dbo.customers
GROUP BY country
ORDER BY TotalScore DESC;

-- Find total score and total number of customers for each country 
SELECT 
    country,
    SUM(score) AS TotalScore,
    COUNT(id) AS TotalCustomers
FROM dbo.customers
GROUP BY country
ORDER BY TotalCustomers DESC;

-- ========================================================================================
-- HAVING CLAUSE
-- ========================================================================================

-- Find the average score for each country (considering only non-zero scores)
-- and return only countries with average score > 430.
SELECT 
    country,
    AVG(score) AS AverageScore
FROM dbo.customers
WHERE score <> 0
GROUP BY country 
HAVING AVG(score) > 430
ORDER BY AverageScore DESC;

-- ========================================================================================
-- DISTINCT CLAUSE
-- ========================================================================================

-- Return unique list of all countries
SELECT DISTINCT
    country
FROM dbo.customers;

-- ========================================================================================
-- TOP (SQL Server)
-- ========================================================================================

-- Retrieve only 3 customers
SELECT TOP (3)
    id,
    first_name,
    country,
    score
FROM dbo.customers
ORDER BY id;

-- Retrieve the Top 3 customers with the highest scores (deterministic)
SELECT TOP (3)
    id,
    first_name,
    country,
    score
FROM dbo.customers
ORDER BY score DESC, id DESC;

-- Retrieve the lowest 2 customers based on score
SELECT TOP (2)
    id,
    first_name,
    country,
    score
FROM dbo.customers
ORDER BY score ASC, id ASC;

-- Get the two most recent orders (deterministic)
SELECT TOP (2)
    order_id,
    customer_id,
    order_date,
    sales
FROM dbo.orders
ORDER BY order_date DESC, order_id DESC;

-- ========================================================================================
-- COMBINING QUERIES
-- ========================================================================================

-- Average score for each country, only non-zero scores, average > 430, sorted descending
SELECT 
    country,
    AVG(score) AS AvgScore
FROM dbo.customers
WHERE score <> 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AvgScore DESC;

-- ========================================================================================
-- COOL STUFF - Additional SQL Features
-- ========================================================================================

-- Execute multiple queries (example: results in separate result sets)
SELECT * FROM dbo.customers;
SELECT * FROM dbo.orders;
-- Removed SELECT * FROM Persons; because table may not exist.

-- Selecting static data (unique aliases)
SELECT 
    'Hello Arsalan' AS Greeting,
    '123' AS ExampleCode;

-- Assign a constant value to a column in a query
SELECT
    id,
    first_name,
    'N/A' AS last_name,
    country,
    score
FROM dbo.customers;

--  THE END
