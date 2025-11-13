/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 05_basic_joins.sql
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL Joins - NO JOIN, INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--   NO JOINS 
-- =======================================================
-- Retrieve all data from customers and orders as separate results 
SELECT *
FROM customers;

SELECT * 
FROM orders;

-- =======================================================
--   INNER JOINS 
-- =======================================================
-- Get all customers along with their orders, but only for customers who have placed an order 
SELECT 
	c.id,
	C.first_name,
	O.order_id,
	O.sales
FROM customers AS C
INNER JOIN orders AS O
ON C.id = O.customer_id;

-- =======================================================
--   LEFT JOINS 
-- =======================================================
-- Get all customers along with their orders, including those without orders 
SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM customers AS C
LEFT JOIN orders AS O
ON C.id = O.customer_id;

-- =======================================================
--   RIGHT JOINS 
-- =======================================================
-- Get all customers along with their orders, including orders without matching customers 
SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM customers AS C
RIGHT JOIN orders AS O
ON C.id = O.customer_id;

-- Alternative to RIGHT JOIN using LEFT JOIN
-- Get all customers along with their orders, including orders without matching customers 
SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM orders AS O 
LEFT JOIN customers AS C 
ON O.customer_id = C.id;

-- =======================================================
--   FULL JOINS 
-- =======================================================
-- FULL JOIN
-- Get all customers and all orders, even if there’s no match 
SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM customers AS C
FULL JOIN orders AS O
ON C.id = O.customer_id;

-------------------------------------- THE END ------------------------------------






