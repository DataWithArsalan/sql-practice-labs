/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 10_sql_date_and_time_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL SINGLE ROW DATE & TIME FUNCTIONS: DATE PART EXTRACTIONS, DATE FORMAT & CASTING, 
												 CALCULATIONS (DATEADD, DATEIFF), DATE VALIDATION 
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--  GETDATE() | DATE VALUES 
-- =======================================================
-- Display OrderID, CreationTime, a hard-coded date, and the current system date.
SELECT 
	orderdate AS DateColumnFromTable, 
	shipdate AS DateColumnFromTable, 
	creationtime AS DateColumnFromTable, 
	'2005-01-25' AS HardCoded,
	GETDATE() AS TodayOrGetFuction
FROM orders;

-- =======================================================
--					Types of DATE & TIME Fuctions
-- =======================================================
-- =======================================================
--  1) PART EXTRACTIONS
-- =======================================================
--------------------------------------------------------------------------
--	YEAR(), MONTH(), DAY(), DATEPART(), DATENAME(), DATETURN(), EOMONTH()
--------------------------------------------------------------------------
/*
	Extract various parts of CreationTime using DATETRUNC, DATENAME, 
	DATEPART,YEAR, MONTH, and DAY.
*/
SELECT 
	creationtime,

	-- Quick Functions
	YEAR(creationtime) AS Year_Function,
	MONTH(creationtime) AS Month_Function,
	DAY(creationtime) AS Day_Function,

	-- DATEPART Functions
	-- The day, month, year, hour , mintues etc are INT there
	DATEPART(QUARTER, creationtime) AS Quarter_dp,
	DATEPART(WEEK, creationtime) AS Week_dp,
	DATEPART(DAY, creationtime) AS Day_dp,
	DATEPART(MONTH, creationtime) AS Month_dp,
	DATEPART(Year, creationtime) AS Year_dp,
	DATEPART(HOUR, creationtime) AS Hour_dp,
	DATEPART(MINUTE, creationtime) AS Mintue_dp,
	DATEPART(SECOND, creationtime) AS Second_dp,

	-- DATENAME Functions
	-- The Day & Year are STRING there 
	DATENAME(WEEKDAY, creationtime) AS Week_Day_dn,
	DATENAME(MONTH, creationtime) AS Month_dn,
	DATENAME(DAY, creationtime) AS Day_dn,
	DATENAME(YEAR, creationtime) AS Year_dn,

	-- DATETURNC Function
	DATETRUNC(MINUTE, creationtime) AS Minute_dt,
	DATETRUNC(HOUR, creationtime) AS Hour_dt,
	DATETRUNC(DAY, creationtime) AS Day_dt,
	DATETRUNC(MONTH, creationtime) AS Month_dt,
	DATETRUNC(YEAR, creationtime) AS Year_dt,

	-- EOMONTH()
	EOMONTH(creationtime) AS End_of_Month,
	CAST(DATETRUNC(MONTH, creationtime) AS DATE ) AS Start_Of_Month
FROM orders;

-- Aggregate orders by year using DATETRUNC on CreationTime.
SELECT 
--	DATETRUNC(MONTH,creationtime),
	DATETRUNC(YEAR, creationtime),
	COUNT(*)
FROM orders
GROUP BY DATETRUNC(YEAR,creationtime); 

-- How many orders were placed each year?
SELECT 
	YEAR(orderdate) AS Years ,
	COUNT(*) AS NoOfOrders
FROM orders
GROUP BY YEAR(orderdate);

-- How many orders were placed each month?
SELECT 
	DATENAME(MONTH,orderdate),
	COUNT(*)
FROM orders
GROUP BY DATENAME(MONTH,orderdate);

-- Show how much orders that were placed during the month of February?
SELECT 
	DATENAME(MONTH,orderdate),
	COUNT(*)
FROM orders
GROUP BY DATENAME(MONTH,orderdate)
HAVING DATENAME(MONTH,orderdate) = 'February';

-- Show all orders that were placed during the month of January?
SELECT *
FROM orders
WHERE MONTH(orderdate) = 2;

--Filtering Data using an Integer is faster than uisng a String 
-- Avoid uisng DATENAME for filtering data, instead use DATEPART 


-- Display OrderID, CreationTime, and the end-of-month date for CreationTime.
SELECT
    OrderID,
    CreationTime,
    EOMONTH(CreationTime) AS EndOfMonth
FROM Orders;
------------------------------------------------------------------------------

-- =======================================================
--  02) DATE FORMAT & CASTING
-- =======================================================
----------------------------------------------------------
--	FORMAT()
----------------------------------------------------------
-- Format CreationTime into various string representations.
SELECT 
	orderid,
	creationtime,
	FORMAT(creationtime, 'MM-dd-yyyy') AS USE_Format,
	FORMAT(creationtime, 'dd-MM-yyyy') AS EURO_Format,
	FORMAT(creationtime, 'MMM-yyy') AS Another_Format,
	FORMAT(creationtime,'dd') AS Day,
	FORMAT(creationtime,'ddd') AS Day_Name,
	FORMAT(creationtime,'dddd') AS Full_Day_Name,
	FORMAT(creationtime,'MM') AS Month,
	FORMAT(creationtime, 'MMM') AS Month_name,
	FORMAT(creationtime, 'MMMM') AS Full_Month_Name,
	FORMAT(creationtime, 'yyyy') AS Year
FROM orders;

-- Tasks:
/* Display CreationTime using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT 
	creationtime,
	'Day ' + FORMAT(creationtime, 'ddd MMM') +
	' Q' + DATENAME(quarter, creationtime) +
	FORMAT(creationtime, ' yyyy HH:mm:ss tt') AS Custom_Format 
FROM orders;


/* How many orders were placed each year, formatted by month and
   year (e.g., "Jan 25")?
*/
SELECT 
	FORMAT(creationtime, 'MMM yyyy') AS Year_Month,
	COUNT(*) AS Total_Orders
FROM orders
GROUP BY FORMAT(creationtime, 'MMM yyyy');

/* How many orders were placed each year, formatted by month and
   year (e.g., "Jan 25")?
*/
SELECT 
	FORMAT(creationtime, 'yyyy MMMM'),
	COUNT(*) AS TotalOrders
FROM orders
GROUP BY FORMAT(creationtime, 'yyyy MMMM');

----------------------------------------------------------
--	CONVERT()
----------------------------------------------------------
-- Demonstrate conversion using CONVERT.
SELECT 
	CONVERT(INT , '123') AS [Stirng Convert inot INT],
	CONVERT(DATE, '2005-01-25') AS [String Convert inot Date],
	creationtime,
	CONVERT(DATE, creationtime) AS [DateTime Convert into Date],
	CONVERT(VARCHAR, creationtime , 32) AS  [USA Std. Style:32],
	CONVERT(VARCHAR, creationtime , 34) AS  [EURO Std. Style:34]
FROM Orders;

----------------------------------------------------------
--	CAST()
---------------------------------------------------------- 
-- Convert data types using CAST.
SELECT
	CAST('123' AS INT) AS [String into INT],
	CAST(123 AS VARCHAR) AS [INT into String],
	CAST('2005-01-25' AS DATE) AS [String into DATE],
	CAST('2005-01-25' AS DATETIME2) AS [String Into DATETIME2],
	creationtime,
	CAST(creationtime AS DATE) AS [DateTime TO Date]
FROM orders;
------------------------------------------------------------------------------

-- =======================================================
--  03) CALCULATIONS (DATEADD, DATEIFF)
-- =======================================================
----------------------------------------------------------
--	DATEADD()
----------------------------------------------------------
-- Perform date arithmetic on OrderDate.
SELECT 
	orderid,
	orderdate,
	DATEADD(Year,2,orderdate) AS TwoYearsLater,
	DATEADD(Month,4,orderdate) AS FourMonthsLater,
	DATEADD(Day,10,orderdate) AS TenDaysLater,
	DATEADD(Year,-2,orderdate) AS TwoYearsBefore,
	DATEADD(Month,-4,orderdate) AS FourMonthsBefore,
	DATEADD(Day,-10,orderdate) AS TenDaysBefore
FROM orders;

----------------------------------------------------------
--	DATEDIFF()
----------------------------------------------------------
-- Calculate the age of employee?
SELECT 
	employeeid,
	firstname,
	lastname,
	DATEdIFF(year, birthdate , GETDATE()) AS Emp_Age
FROM employees;


--	Find the average shipping duration in days for each month?
SELECT 
	MONTH(orderdate),
	AVG(DATEDIFF(DAY,orderdate,shipdate)) AS AVG_Shipping
FROM orders
GROUP BY MONTH(orderdate);

-- USE CASE:
-- Time Gap Anaylsis
--Find the number of days between each order and previous order
SELECT 
	orderid,
	orderdate AS CurrentOderDate,
	LAG(orderdate) OVER(ORDER BY orderdate) AS PreviousOrderDate,
	DATEDIFF(Day,LAG(orderdate) OVER(ORDER BY orderdate),orderdate) AS NoOfDays
FROM orders;
------------------------------------------------------------------------------

-- =======================================================
--  04) DATE VALIDATION
-- =======================================================
----------------------------------------------------------
--	ISDATE()
----------------------------------------------------------
-- Using ISDATE() Function below:
SELECT
	ISDATE('2005-01-25') AS CheckDate1,
	ISDATE(25-01-2005) AS CheckDate2,
	ISDATE('25-01-2005') AS CheckDate3,
	ISDATE(2005) AS CheckDate4,
	ISDATE(02) AS CheckDate5;

------------------------------------------------------------------------------
-- Validate OrderDate using ISDATE and convert valid dates.
-- SQL Practice Question (Using in Data Analysis)
SELECT
	OrderDate,
	ISDATE(OrderDate),
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
		ELSE '9999-01-01'
	END NewOrderDate
FROM	
	(
		SELECT '2025-08-20' AS OrderDate UNION
		SELECT '2025-08-21' UNION
		SELECT '2025-08-23' UNION
		SELECT '2025-08'
	)T
-- WHERE ISDATE(OrderDate) = 0;
-------------------------------------- THE END ------------------------------------

