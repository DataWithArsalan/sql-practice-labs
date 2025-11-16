/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 07_set_operators.sql
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SET Operators: UNION, UNION ALL, EXCEPT(MINUS), INTERSECT
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--  UNION SET OPERATORS   
-- =======================================================
-- Combine the data from employees and customers into one table.
SELECT 
	firstname,
	lastname
FROM employees
UNION
SELECT 
	firstname,
	lastname
FROM customers;

-- =======================================================
--  UNION ALL SET OPERATORS   
-- =======================================================
-- Combine the data from employees and customers into one table,including duplicate.
SELECT 
	firstname,
	lastname
FROM customers
UNION ALL
SELECT 
	firstname,
	lastname
FROM employees;

-- =======================================================
--  EXCEPT(MINUS) SET OPERATORS   
-- =======================================================
-- Find employees who are not customers at the same time.
SELECT 
	firstname,
	lastname
FROM employees
EXCEPT 
SELECT 
	firstname,
	lastname
FROM Customers;

-- The order of queries must affect in the results as following below.
-- Find customers who are not employees at the same time
SELECT 
	firstname,
	lastname
FROM Customers
EXCEPT 
SELECT 
	firstname,
	lastname
FROM employees;

-- =======================================================
--  INTERSECT SET OPERATORS   
-- =======================================================
-- Find employees who are also customers
SELECT  
	firstname,
	lastname
FROM employees
INTERSECT 
SELECT 
	firstname,
	lastname
FROM customers;

-- =======================================================
-- UNION USE CASES 
-- =======================================================
-- COMBINE INFORMATION: 
/* Orders data are stored in a separte tables (Orders & OrdersArchive).
   Combine all orders data into one report without duplicates. */
SELECT
    'Orders' AS SourceTable
	  ,[orderid]
      ,[productid]
      ,[customerid]
      ,[salespersonid]
      ,[orderdate]
      ,[shipdate]
      ,[orderstatus]
      ,[shipaddress]
      ,[billaddress]
      ,[quantity]
      ,[sales]
      ,[creationtime]
FROM orders
UNION
SELECT 
   'OrdersArchive' AS SourceTable
      ,[orderid]
      ,[productid]
      ,[customerid]
      ,[salespersonid]
      ,[orderdate]
      ,[shipdate]
      ,[orderstatus]
      ,[shipaddress]
      ,[billaddress]
      ,[quantity]
      ,[sales]
      ,[creationtime]
FROM orders_archive
ORDER BY orderid;
-------------------------------------- THE END ------------------------------------
