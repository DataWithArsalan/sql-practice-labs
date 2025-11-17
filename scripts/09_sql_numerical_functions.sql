/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 09_sql_numerical_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL SINGLE ROW NUMERICAL FUNCTIONS: Number Functions
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--  NUMBER FUNCTIONS  
-- =======================================================
-- ------------------------------
-- ROUND()
-- ------------------------------
SELECT 
	3.516 AS RandomNumberForTesting,
	ROUND(3.516,2) AS RoundTwoDigitAfterPoint,
	ROUND(3.516,1) AS RoundOneDigitAfterPoint,
	ROUND(3.516,0) AS RoundZeroDigitAfterPoint

-- ------------------------------
-- ABS()
-- ------------------------------
SELECT
	-10 AS NegativeNumber,
	10 AS PostiveNumber,
	ABS(-10) AS ABS_FunctionUsingNegativeNumber,
	ABS(10) AS ABS_FunctionUsingPostiveNumber

-------------------------------------- THE END ------------------------------------
