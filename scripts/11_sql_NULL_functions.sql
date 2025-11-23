/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 11_sql_NULL_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL SINGLE ROW NULL FUNCTIONS: ISNULL(), COALESCE(), NULLIF(), IS NULL & IS NOT NULL
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--					NULL FUNCTIONS  
-- =======================================================
-- =======================================================
--	ISNULL() & COALESCE() NULL FUNCTIONS 
-- =======================================================
-- Find the average scores of the customers?
SELECT 
	customerid,
	score,
	COALESCE(score,0) AS Score1,
	AVG(score) OVER() AS AvgScore,
	AVG(COALESCE(score,0)) OVER() AS AvgScore2
FROM customers;

/* Displaly the full name of customers in a single field 
   by merging their first and last names,
   adn add 10 bonus points to each customer's score? */
SELECT 
	customerid,
	firstname,
	lastname,
	COALESCE(lastname, '') AS LastName2,
	firstname + ' ' + COALESCE(lastname, '')  AS Full_Name,
	score,
	score+10 AS ScoreWithBonus,
	COALESCE(score,0) AS Score2,
	COALESCE(score,0)+10 AS ScoreWithBonus2
FROM customers;

-- Sort the cusotmers from lowest to highest scores, with NULLs appearing last?
-- Lazy Method not Professional 
SELECT 
	customerid,
	firstname,
	lastname,
	country,
	score,
	COALESCE(score, 999999) As LazyMethodNotProfessionalToSortNull 
FROM customers
ORDER BY COALESCE(score, 999999);

-- Professional Method 
SELECT 
	customerid,
	firstname,
	lastname,
	country,
	score
	-- CASE WHEN Score IS NULL THEN 1 ELSE 0 END AS Flag
FROM customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, score;
------------------------------------------------------------------------------

-- =======================================================
--	NULLIF NULL FUNCTIONS 
-- =======================================================
-- Find the sales price for each order by dividing sales by quantity?
-- Uses NULLIF to avoid division by zero.
SELECT 
	orderid,
	sales,
	quantity,
	sales / NULLIF(quantity, 0) AS Price
FROM orders;
------------------------------------------------------------------------------

-- =======================================================
--	IS NULL & IS NOT NULL NULL FUNCTIONS 
-- ======================================================= 
-- Identify the customers who have no scores?
SELECT *
FROM customers
WHERE score IS NULL;

-- Identify the cusotomers who have no last name?
SELECT * 
FROM customers
WHERE lastname IS NULL;

-- Identify the customers who have no score and also no lastname?
SELECT *
FROM customers
WHERE score IS NULL
OR lastname IS NULL;
-- List all customers who have scores>
SELECT *
FROM customers
WHERE score IS NOT NULL;

-- List all customers who have lastname?
SELECT *
FROM customers
WHERE lastname IS NOT NULL;

-- List all customers who have score and their lastname?
SELECT *
FROM customers
WHERE score IS NOT NULL
AND lastname IS NOT NULL;

-- >> Left Anti Join
-- List all details for customers who have not placed any order?
SELECT 
	C.customerid,
	C.firstname,
	C.lastname,
	O.orderdate,
	O.orderid,
	O.orderstatus
FROM customers AS C
LEFT JOIN orders AS O
ON C.customerid= O.customerid
WHERE O.customerid IS NULL;
------------------------------------------------------------------------------

-- =======================================================
--	NULLs vs EMPTY STRING vs BLANK SPACES 
-- =======================================================
-- Demonstrate differences between NULL, empty strings, and blank spaces 
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT 
    *,
    DATALENGTH(Category) AS LenCategory,
    TRIM(Category) AS Policy1,
    NULLIF(TRIM(Category), '') AS Policy2,
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;

-- Demonstrate differences between NULL, empty strings, and blank spaces 
WITH Orders AS (
	SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, ' ' UNION
    SELECT 4, ''
)
SELECT 
	*,
	DATALENGTH(Category) CategoryLen,
	DATALENGTH(TRIM(Category)) AS Policy1_BlankSpacesAvoid,
	NULLIF(TRIM(Category),'') AS Policy2_BothEmptyStringAndBlankSpacesAvoid,
	COALESCE(NULLIF(TRIM(Category),''), 'Unknown') AS Policy3_DefaultValueInsteadOfNULLs
FROM Orders;
-------------------------------------- THE END ------------------------------------
