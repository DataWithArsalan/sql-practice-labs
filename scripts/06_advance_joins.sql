/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 05_advance_joins.sql
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL Joins - LEFT ANTI JOIN, RIGHT ANTI JOIN, FULL ANTI JOIN, CROSS JOIN, MULTI JOINS
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--   LEFT ANTI JOIN  
-- =======================================================
-- Return row from left that have no match in Right OR
-- Get all customers who haven't place any order 
SELECT 
	C.id,
	C.first_name,
	C.country,
	C.score,
	O.order_id,
	O.order_date,
	O.sales
FROM customers AS C
LEFT JOIN orders AS O
ON C.id = o.customer_id
WHERE o.customer_id IS NULL;

-- =======================================================
--  RIGHT ANTI JOIN  
-- =======================================================
-- Return Rows FROM Right that has NoMatch in LEFT  OR
-- Get all orders without matching customers.
SELECT 
	C.id,
	C.first_name,
	C.country,
	C.score,
	O.order_id,
	O.order_date,
	O.sales
FROM customers AS C
RIGHT JOIN orders AS O
ON C.id =  O.customer_id
WHERE C.id IS NULL;

-- Solve the same task using LEFT JOIN 
SELECT 
	C.id,
	C.first_name,
	C.country,
	C.score,
	O.order_id,
	O.order_date,
	O.sales
FROM orders AS O
LEFT JOIN customers AS C
ON O.customer_id = C.id
WHERE C.id IS NULL;

-- =======================================================
--  FULL ANTI JOIN  
-- =======================================================
-- Return all rows that does't match in eaither  tables.  OR
-- Find customers without orders and orders without customers.
SELECT 
	C.id,
	C.first_name,
	C.country,
	C.score,
	O.order_id,
	O.order_date,
	O.sales
FROM customers AS C
FULL JOIN orders AS O
ON C.id = O.customer_id
WHERE C.id IS NULL OR O.customer_id IS NULL;

-- CHALLENGE 
/* Get all customers along with their orders, 
   but only for customers who have placed an order
   without using INNER JOIN!!  */
SELECT 
	C.id,
	C.first_name,
	C.country,
	C.score,
	O.order_id,
	O.order_date,
	O.sales
FROM customers AS C
LEFT JOIN orders AS O
ON C.id = O.customer_id
WHERE  O.customer_id IS NOT NULL;

-- =======================================================
--  CROSS JOIN  
-- ======================================================= 
/* 
	--> Combine every ROW from LEFT with every ROW from RIGHT
		All possible combinatios (Cartersian Join). OR 
	-->	Generate all possible combinations of customers and orders.
*/
SELECT 
	C.id,
	C.first_name,
	C.country,
	C.score,
	O.order_id,
	O.order_date,
	O.sales
FROM customers AS C
CROSS JOIN orders AS O;


-- =======================================================
--  MULTI JOINS  
-- ======================================================= 
/* 
	Using SalesDB, Retrieve a list of all orders, along with the relaed customer,
	product, and employee details.
	For each order,display:
		=> OrderID
		=> Customer's Name
		=> Product Name
		=> Sales Amount 
		=> Product Price
		=> Salesperson's Name
*/
SELECT
	O.orderid,
	C.firstname AS Customer_First_Name,
	C.lastname AS Customer_Last_Name,
	P.product AS Product_Name,
	O.sales,
	P.price,
	E.firstname AS Employee_First_Name,
	E.lastname AS Employee_Last_Name
FROM orders AS O
LEFT JOIN customers AS C
	ON O.orderid = c.customerid
LEFT JOIN products AS P
	ON O.productid = P.productid
LEFT JOIN employees AS E
	ON O.salespersonid = E.employeeid;
-------------------------------------- THE END ------------------------------------

