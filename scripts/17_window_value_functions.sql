/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 17_window_value_functions.sql 
  Author: Muhammad Arsalan
  DB: SalesDB (SQL Server)
  Purpose: SQL WINDOW VALUE FUNCTIONS : LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--				SQL WINDOW VALUE FUNCTIONS  
-- =======================================================
-- -------------------------------------------------------
--  SQL WINDOW VALUE | LEAD, LAG
-- -------------------------------------------------------
/* 
   Analyze the Month-over-Month Performance by Finding the Percentage Change in Sales
   Between the Current and Previous Months
*/
SELECT 
	*,
	( CurrentMonthSales - PreviousMonthSales ) AS MoM_Change,
	CONCAT(ROUND(CAST(( CurrentMonthSales - PreviousMonthSales ) AS float) / PreviousMonthSales * 100, 2), ' %') AS MoM_Percentage
FROM (
	SELECT 
		MONTH(orderdate) AS Month,
		SUM(Sales) AS CurrentMonthSales,
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(Orderdate)) AS PreviousMonthSales
	FROM orders
	GROUP BY MONTH(orderdate)
	) AS MonthlySales;


/* 
   Customer Loyalty Analysis - Rank Customers Based on the Average Days Between Their Orders
*/
SELECT 
customerid,
AVG(DaysUntilNextOrder) AS AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), '99999')) AS RankAvg
FROM (
	SELECT 
	 customerid,
	 orderdate,
	 LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate) AS NextOrder,
	 DATEDIFF(DAY, orderdate, LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate)) AS DaysUntilNextOrder
	FROM orders
    ) AS CustomerOrdersWithNext
	GROUP BY customerid;


-- -------------------------------------------------------
--  SQL WINDOW VALUE | FIRST_VALUE, LAST_VALUE
-- -------------------------------------------------------
/* 
   Find the Lowest and Highest Sales for Each Product,
   and determine the difference between the current Sales and the lowest Sales for each Product.
*/
SELECT
    OrderID,
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
    LAST_VALUE(Sales) OVER (
        PARTITION BY ProductID 
        ORDER BY Sales 
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS HighestSales,
    Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Orders;
----------------------------------------------- END ------------------------------------------------------------------

