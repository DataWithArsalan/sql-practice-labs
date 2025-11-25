/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 13_aggregate_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL AGGREGATE FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--				AGGREGATE FUNCTIONS  
-- =======================================================
-- -------------------------------------------------------
-- COUNT, SUM, AVG, MAX, MIN, 
-- -------------------------------------------------------
-- Find the total number of Orders
-- Find the total sales of all Orders
-- Find the AVG sales of all Orders
-- Find the Highest score among the customers
-- Find the Lowest score among the customers
SELECT 
	customerid,
	COUNT(*) AS TotalNumberOfAllOrders,
	SUM(sales) AS TotalSales,
	AVG(sales) AS AverageSales,
	MAX(sales) AS HighestSales,
	MIN(sales) AS LowestSales
FROM orders
GROUP BY customerid;

-- Analyze the scores in customers table
SELECT
	Country,
	COUNT(*) AS TotalNumberOfCustomers,
	SUM(score) AS TotalScore,
	AVG(score) AS AverageScore,
	MAX(score) AS HighestScore,
	MIN(score) AS LowestScore
FROM customers
GROUP BY country;
----------------------------------------------- END ------------------------------------------------------------------