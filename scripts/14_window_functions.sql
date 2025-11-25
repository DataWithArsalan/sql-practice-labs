/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 14_window_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL WINDOW FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--				WINDOW FUNCTIONS  
-- =======================================================
-- -------------------------------------------------------
-- SQL WINDOW FUNCTIONS | BASICS
-- -------------------------------------------------------
-- Calculate the Total Sales Across All Orders?
SELECT 
	SUM(sales) AS TotalSales
FROM orders;

-- Calculate the Total Sales for Each Product?
SELECT 
	productid,
	SUM(sales) AS TotalSales
FROM orders
GROUP BY productid;


-- -------------------------------------------------------
-- SQL WINDOW FUNCTIONS | OVER CLAUSE
-- -------------------------------------------------------
/* 
   Find the total sales across all orders,
   additionally providing details such as OrderID and OrderDate?
*/
SELECT 
	orderid,
	orderDate,
	productid,
	sales,
	sum(sales) OVER() AS TotalSales
FROM orders;


-- -------------------------------------------------------
-- SQL WINDOW FUNCTIONS | PARTITION CLAUSE
-- -------------------------------------------------------
/*  
   Find the total sales across all orders and for each product,
   additionally providing details such as OrderID and OrderDate 
*/
SELECT
	orderid,
	orderdate,
	ProductID,
	SUM(sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS SalesByProduct
FROM orders;

/*
   Find the total sales across all orders, for each product,
   and for each combination of product and order status,
   additionally providing details such as OrderID and OrderDate
*/
SELECT 
	orderid,
	orderdate,
	productID,
	orderstatus,
	sales,
	SUM(sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY productID) AS SalesByProduct,
	SUM(sales) OVER(PARTITION BY productID, orderstatus) AS SalesByProductStatus
FROM orders;


-- -------------------------------------------------------
-- SQL WINDOW FUNCTIONS | ORDER CLAUSE
-- -------------------------------------------------------
/* 
	Rank each order based on their sales from highest to lowest, 
	additionally provide details such order id & Order date.
*/
SELECT 
	orderid,
	orderdate,
	sales,
	RANK() OVER(ORDER BY sales DESC ) AS RankSales
FROM orders;


-- -------------------------------------------------------
--  SQL WINDOW FUNCTIONS | FRAME CLAUSE
-- -------------------------------------------------------
-- Calculate Total Sales by Order Status for current and next two orders?
SELECT 
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(Sales) OVER(
	    PARTITION BY Orderstatus
		ORDER BY Orderdate
	    ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
	) AS TotalSales
FROM orders;

-- Calculate Total Sales by Order Status for current and previous two orders?
SELECT 
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(Sales) OVER(
	    PARTITION BY OrderStatus
		ORDER BY OrderDate
	    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	) AS TotalSales
FROM orders;

-- Calculate Total Sales by Order Status from previous two orders only?
SELECT 
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(Sales) OVER(
	    PARTITION BY orderstatus
		ORDER BY OrderStatus
	    ROWS 2 PRECEDING
	) AS TotalSales
FROM orders;

-- Calculate cumulative Total Sales by Order Status up to the current order?
SELECT
	orderid,
	orderdate,
	productid,
	orderstatus,
	sales,
	SUM(sales) OVER(
	    PARTITION BY orderstatus
		ORDER BY orderdate
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS TotalSales
FROM orders;

-- Calculate cumulative Total Sales by Order Status from the start to the current row?
SELECT
	orderid,
	orderdate,
	productid,
	orderstatus,
	sales,
	SUM(sales) OVER(
	    PARTITION BY orderstatus
		ORDER BY orderdate
		ROWS UNBOUNDED PRECEDING
	) AS TotalSales
FROM orders;

-- =======================================================
--	SQL WINDOW FUNCTIONS | RULES  
-- =======================================================
-- -------------------------------------------------------
--  RULE 1:
-- -------------------------------------------------------
-- Window functions can only be used in SELECT or ORDER BY clauses.
SELECT 
	orderid,
	orderdate,
	productid,
	orderstatus,
	sales,
	SUM(sales) OVER(PARTITION BY orderstatus) AS TotalSales
FROM orders
WHERE SUM(sales) OVER(PARTITION BY orderstatus) > 100; -- Invalid: Window function in WHERE clause

-- -------------------------------------------------------
--  RULE 2:
-- -------------------------------------------------------
-- Window functions cannot be nested.
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(SUM(Sales) OVER (PARTITION BY OrderStatus)) OVER (PARTITION BY OrderStatus) AS Total_Sales  -- Invalid nesting
FROM Orders;

-- -------------------------------------------------------
--  SQL WINDOW FUNCTIONS | GROUP BY
-- -------------------------------------------------------
-- Rank customers based on their total sales
-- NOTE: Use GROUP BY for simple Aggregations
SELECT 
	customerid,
	SUM(sales) AS TotalSales,
	RANK() OVER(ORDER BY SUM(sales) DESC) AS RankCustomers
FROM orders
GROUP BY customerid;
----------------------------------------------- END ------------------------------------------------------------------