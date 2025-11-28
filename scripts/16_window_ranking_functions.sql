/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 16_window_ranking_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL WINDOW RANKING FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--				SQL WINDOW RANKING FUNCTIONS  
-- =======================================================
-- -------------------------------------------------------
-- SQL WINDOW RANKING | ROW_NUMBER, RANK, DENSE_RANK
-- -------------------------------------------------------
-- Rank Orders Based on Sales from Highest to Lowest?
SELECT 
	orderid,
	productid,
	sales,
	ROW_NUMBER() OVER (ORDER BY OrderDate DESC) AS SalesRank_Row,
	RANK() OVER(ORDER BY orderdate DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY orderdate DESC) AS SalesRank_Dense
FROM orders;

-- Use Case | Top-N Anaylsis: Find the Highest Sale for Each Product
SELECT *
FROM (
	SELECT 
		orderid,
		productid,
		sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY sales DESC) AS RankByProduct
	FROM orders
	) AS TopProductSales
	WHERE RankByProduct = 1;

-- Use Case | Bottom-N Analysis: Find the Lowest 2 Customers Based on Their Total Sales?
SELECT *
FROM (
	SELECT 
		customerid,
		SUM(Sales) AS TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) AS RankCustomers
	FROM orders
	GROUP BY customerid
   ) AS BottomCustomerSales
   WHERE RankCustomers <=2;

-- Use Case | Assign Unique IDs to the Rows of the 'Order Archive'
SELECT 
	ROW_NUMBER() OVER(ORDER BY orderid, orderdate) AS UniqueID,
	*
FROM orders_archive;

/* 
   Use Case | Identify Duplicates:
   Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates
*/
SELECT *
FROM (
	SELECT 
		ROW_NUMBER() OVER(PARTITION BY orderid ORDER BY creationtime DESC) AS rn,
		*
	FROM orders_archive
   ) AS UniqueOrderArchive
   WHERE rn = 1;

-- -------------------------------------------------------
-- SQL WINDOW RANKING | NTILE
-- -------------------------------------------------------
-- Divide Orders into Groups Based on Sales.
SELECT 
	orderid,
	sales,
	NTILE(1) OVER(ORDER BY sales) AS OneBucket,
	NTILE(2) OVER(ORDER BY sales) AS TwoBuckets,
	NTILE(3) OVER(ORDER BY sales) AS ThreeBuckets,
	NTILE(4) OVER(ORDER BY sales) AS FourBuckets,
	NTILE(2) OVER(PARTITION BY ProductID ORDER BY Sales) AS TwoBucketByProducts
FROM orders;

-- Segment all Orders into 3 Categories: High, Medium, and Low Sales.
SELECT 
	orderid,
	sales,
	Buckets,
	CASE Buckets
		WHEN 1 THEN 'High'
		WHEN 2 THEN 'Medium'
		WHEN 3 THEN 'Low'
	END AS SalesSegmentations
FROM (
	SELECT 
		orderid,
		sales,
		NTILE(3) OVER(ORDER BY sales DESC) AS Buckets
	FROM orders
	) AS SalesBuckets;


-- Divide Orders into Groups for Processing
SELECT 
	NTILE(5) OVER(ORDER BY orderid) AS Buckets,
	*
FROM orders;


-- -------------------------------------------------------
-- SQL WINDOW RANKING | CUME_DIST
-- -------------------------------------------------------
-- Find Products that Fall Within the Highest 40% of the Prices.
SELECT 
	product,
	price,
	DistRank,
	CONCAT(DistRank * 100, ' %') AS DistRankPerc
FROM (
	SELECT 
		product,
		price,
		CUME_DIST() OVER(ORDER BY price DESC) AS DistRank
	FROM products
	) AS PriceDistribution
	WHERE DistRank <= 0.40;


-- -------------------------------------------------------
-- SQL WINDOW RANKING | PERCENT_RANK
-- -------------------------------------------------------
-- find the products that fall within the highest 40% of the prices?
SELECT 
	*,
	CONCAT(PercentRank * 100, '%') AS PercentRankPerc
FROM(
	SELECT 
		product,
		price,
		PERCENT_RANK() OVER(ORDER BY Price DESC) AS PercentRank
	FROM products
)T
WHERE PercentRank<= 0.4;

