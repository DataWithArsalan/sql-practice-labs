/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 15_window_aggregate_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL WINDOW AGGREGATE FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--				WINDOW AGGREGATE FUNCTIONS  
-- =======================================================
-- -------------------------------------------------------
-- SQL WINDOW AGGREGATION | COUNT
-- -------------------------------------------------------
-- -------------------------------------------------------------------------------
-- USE CASE 01: OVERALL ANALYSIS:~  Quick summary or Snapshot of entire dataset
-- -------------------------------------------------------------------------------
-- Find total number of orders?
SELECT 
	COUNT(*) AS TotalNrOrders,
	COUNT(1) AS TotalNrOrders
	-- Both use 
FROM orders;

-- Find total number of orders?
-- Additionally provide details such as OrderID, orderDate?
SELECT 
	orderid,
	orderdate,
	COUNT(*) OVER() AS TotalOrders
FROM orders;

-- ------------------------------------------------------------------------------------------------------
-- USE CASE 02: TOTAL PER GROUP:~ Group-wise analysis, to understand patterns within different categories
-- ------------------------------------------------------------------------------------------------------
-- Find total number of orders?
-- Find total number of orders for each customers?
-- Additionally provide details such as OrderID, orderDate?
SELECT 
	orderid,
	orderdate,
	customerID,
	COUNT(*) OVER() AS TotalOrders,
	COUNT(1) OVER(PARTITION BY CustomerID) AS EachCustomerOrders
FROM orders;

-- -----------------------------------------------------------------------------------------------------
-- USE CASE 03: DATA QUALITY CHECK:~ Detecting Number of NULLs by comparing to total number of rows
-- -----------------------------------------------------------------------------------------------------
-- Find the total number of customers?
-- Additionally provide All customers details?
SELECT 
	*,
	COUNT(customerid) OVER() AS TotalCustomers
FROM customers;

-- Find the total number of customers?
-- Additionally provide All customers details?
-- Find the total number of score for each customers?
SELECT 
	*,
	COUNT(*) OVER() AS TotalNrOfCustomers,
	COUNT(score) OVER() AS TotalScoreEachCustomers
FROM customers;
-- ------------------------------------------------------------------------------------------------
-- USE CASE 04: IDENTIFY DUPLICATES:~ Identify duplicate rows to improve data quality
-- ------------------------------------------------------------------------------------------------
-- Check whether the table 'Orders' contains any duplicate rows
SELECT 
	orderid,
	COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
FROM orders
-- Divides the data by the primary key (OrderID)
-- EXPECTATION:~ Maximum number of rows for each window(ID) = 1

SELECT *
FROM (
	SELECT 
		orderid,
		COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
	FROM orders_archive
	)t WHERE CheckPK > 1;
-- Duplicates in OrderID


-- -------------------------------------------------------
-- SQL WINDOW AGGREGATION | SUM
-- -------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
-- USE CASE 02: TOTAL PER GROUPS:~ Group-wise analysis, to understand patterns within different categoroies
-- ----------------------------------------------------------------------------------------------------------
-- Find the total sales across all orders
-- And the total sales for each product
-- Additionally provide details such orderID, orderDate
SELECT 
	orderid,
	orderdate,
	productid,
	sales,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS EachProductSales
FROM orders;

-- ----------------------------------------------------------------------------------------------------------
-- USE CASE 03: PART-TO-WHOLE:~ Show the contribution of each data point to the overall dataset
-- ----------------------------------------------------------------------------------------------------------
-- Find the percentage contribution of each product's sales to the total sales?
SELECT 
	orderid,
	orderdate,
	sales,
	SUM(Sales) OVER() AS TotalSales,
	ROUND(CAST(sales AS float) / SUM(Sales) OVER() * 100, 3) AS PercentageOfTotal
FROM orders;


-- -------------------------------------------------------
-- SQL WINDOW AGGREGATION | AVERAGE / AVG()
-- -------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
-- USE CASE 02: TOTAL PER GROUPS:~ Group-wise analysis, to understand patterns within different categoroies
-- ----------------------------------------------------------------------------------------------------------
-- Find the average sales across all orders
-- And find the average sales for each product 
-- Additionally provide details such orderID, orderDate
SELECT 
	orderid,
	orderdate,
	productid,
	sales,
	AVG(Sales) OVER() AS TotalAvgSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AS EachProductAvgSales
FROM orders;

-- Find the average scores of customers
-- Additionally provide details such as CustomerID and LastName
SELECT 
	customerid,
	lastname,
	score,
	AVG(Score) OVER() AS AvgScore,
	-- Remove NULLs with specified value
	COALESCE(Score,0) AS NullZero,
	AVG(COALESCE(Score,0)) OVER() AS AvgScroe
FROM customers
-- This is the CASE where NULL consider as ZERO

-------------------------------------------------------------------------------------------------------------
-- USE CASE 03: PART-TO-WHOLE:~ Show the contribution of each data point to the overall dataset
-- ----------------------------------------------------------------------------------------------------------
-- Find all orders where sales are higher than the average sales across all orders.
-- Sub-Query
SELECT *
FROM (
	SELECT 
		orderid,
		orderdate,
		productid,
		sales,
		AVG(Sales) OVER() AS AvgSales
	FROM orders
 )T WHERE Sales > AvgSales;


 -- -------------------------------------------------------
-- SQL WINDOW AGGREGATION | MAX / MIN
-- -------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-- USE CASE 01: OVERALL ANALYSIS:~  Quick summary or Snapshot of entire dataset
-------------------------------------------------------------------------------------------------------------
-- Find the highest & lowest sales across all orders?
SELECT 
	MIN(Sales) AS LowestSales,
	MAX(Sales) AS HighestSales
FROM orders;

-------------------------------------------------------------------------------------------------------------
-- USE CASE 02: TOTAL PER GROUPS:~ Group-wise analysis, to understand patterns within different categoroies
-------------------------------------------------------------------------------------------------------------
-- Find highest & lowest sales for each product.
-- Additionally, provide details such as orderID and orderDate.
SELECT 
	orderid,
	orderdate,
	productid,
	sales,
	MIN(sales) OVER() AS LowestSales,
	MIN(sales) OVER(PARTITION BY ProductID) AS  LowestSalesByProduct,
	MAX(sales) OVER() AS HighestSales,
	MAX(sales) OVER(PARTITION BY ProductID) AS HighestSalesByProduct
FROM orders;

-- Show the employees who have the highest salaries?
SELECT *
FROM (
	SELECT 
	   	*,
		 MAX(Salary) OVER() AS HighestSalary
	FROM employees
	)T WHERE salary = HighestSalary;


-- Show the employees who have the lowest salaries?
SELECT *
FROM (
	SELECT 
	   	*,
		 MIN(Salary) OVER() AS LowestSalary
	FROM employees
	)T WHERE salary = LowestSalary;

-------------------------------------------------------------------------------------------------------------
-- USE CASE 04: COMPARE TO EXTREMES:~ Help to evaluate how well a value is performing relative to the extremes
-- DISTANCE FROM EXTEME:~ The lower the deviation,the closer the data point is to the extreme
-------------------------------------------------------------------------------------------------------------
-- Calculation the deviation of each sales from both Minimum and Maximum sales amount?
SELECT 
	orderid,
	orderdate,
	productid,
	sales,
	MAX(Sales) OVER() AS HighestSales,
	MAX(Sales) OVER() - sales AS DeviationFromMAX,
	sales,
	MIN(Sales) OVER() AS LowestSales,
	Sales - MIN(Sales) OVER() AS DeviationFromMIN
FROM orders;


-- -------------------------------------------------------
-- Use Case | ROLLING SUM & AVERAGE
-- -------------------------------------------------------
-- Calculate moving average of sales for each product over time?
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS MovingAvg
FROM Orders;


-- Calculate moving average of sales for each product over time, including only the next order?
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Orders;
----------------------------------------------- END ------------------------------------------------------------------