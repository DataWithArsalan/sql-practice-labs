/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 12_SQL_CASE_Statements.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL CASE STATEMENTS
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--					CASE STATEMENT  
-- =======================================================
/* 
	Generate a report showing the toatl sales for each category:
		- High: If the sales higher than 50
		- Medium: If the sales between 20 and 50
		- Low: If the sales equal or lower than 20
	Sort ther resulut from lowest to highest 
*/
SELECT 
	Category,
	SUM(Sales) AS Total_Sales
FROM (
	SELECT 
		orderid,
		sales,
		CASE 
			WHEN sales>50 THEN 'High'
			WHEN sales>20 THEN 'Medium'
			ELSE 'Low'
			END AS Category
	FROM orders
	)t
GROUP BY Category
ORDER BY Total_Sales DESC;


/*
	Retrieve employee details with gender displayed as full text
*/
SELECT 
	employeeid,
	firstname,
	department,
	gender,
	CASE
		WHEN gender='M' THEN 'Male'
		WHEN gender='F' THEN 'Female'
		ELSE 'Not Avaiable'
	END AS Gender_Full_Text
FROM employees;

/*
	Retrieve customers details with abbriveiatted with Country code (Full Form of CASE Statement)
*/
SELECT 
	customerid,
	firstname,
	lastname,
	country,
	CASE
		WHEN country = 'Germany' THEN 'DE'
		WHEN country = 'USA'     THEN 'US'
		ELSE 'Not Avaiable'
		END AS CountryAbbr
FROM customers;


/*
	Retrieve customers details with abbriveiatted with Country code using Quick Form of CASE Statement
*/
SELECT 
	customerid,
	firstname,
	lastname,
	country,
	CASE country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
		ELSE 'Not Avaialbe'
	END AS CountryAbbr
FROM customers;


/*
	Find the average scores of customers and treat NULLs as 0
		- Additionally provide details such CustomerID & LastName
*/
SELECT 
	customerid,
	lastname,
	score,
	CASE
		WHEN score IS NULL THEN 0
		ELSE score
	END AS MakingNULL0,
	AVG(CASE
			WHEN score IS NULL THEN 0
			ELSE score
	END) OVER() AS AverageCleanScore,
	AVG(score) OVER() AS AverageScore
FROM customers;


/*
	Count how many times each customers has made an order with sales 
	greater than 30.
*/
SELECT 
	orderid,
	customerid,
	sales,
	CASE
		WHEN sales > 30 THEN 1
		ELSE 0
	END AS SalesFlag
FROM orders
ORDER BY customerid;

-------------------------
/*
	
*/
SELECT 
	customerid,
	-- Conditional Aggregations
	SUM(CASE
			WHEN Sales > 30 THEN 1
			ELSE 0
	END) AS TotalOrdersHighScore,
	-- Normal Aggregations using CASE STATEMENT
	COUNT(*) AS TotalOrders
FROM orders
GROUP BY customerid
