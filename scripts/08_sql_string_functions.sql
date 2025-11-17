/* -----------------------------------------------------------------------------------------------------------------------------------------
  File: 08_sql_string_functions.sql 
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: SQL SINGLE ROW STRING FUNCTIONS: Manipulate String, Calculation String, Extraction String
-------------------------------------------------------------------------------------------------------------------------------------------- */
-- =======================================================
--  MANIPULATE STRING FUNCTIONS  
-- =======================================================
-- ------------------------------
-- CONCAT()
-- ------------------------------
-- Show a list of first_Name of customers along with their country in one column.
SELECT 
	first_name,
	country,
	CONCAT(first_name, ' ', country)
FROM customers;

-- ------------------------------
-- UPPER() & LOWER()
-- ------------------------------
-- LOWER()
-- Transfer the customers first_name into lowercase
SELECT 
	first_name,
	LOWER(first_name) AS LowerCaseName
FROM customers;

-- UPPER()
-- Transfer the customers first_name into uppercase
SELECT 
	first_name,
	UPPER(first_name) AS UpperCaseName
FROM customers;

-- ------------------------------
-- TRIM()
-- ------------------------------
-- Find customers whose first_name contian leading or thrilling spaces.
SELECT 
	first_name,
	LEN(first_name) AS LenOf1stNameChar,
	Len(Trim(first_name)) AS LenTrim1stName,
	LEN(first_name) - Len(Trim(first_name)) AS Flag
FROM customers
WHERE LEN(first_name) != Len(Trim(first_name))
-- But mostly cases we use the below technique because that is easy to find spaces and also we says it is just one fuction.
-- WHERE first_name != TRIM(first_name);

-- ------------------------------
-- REPLACE()
-- ------------------------------
-- Remove dash (-) from phone number.
SELECT 
	'123-456-7890' AS PhoneNumber, 
	REPLACE('123-456-7890', '-', '/') AS DashChangeByForwardSlash,
	REPLACE('123-456-7890', '-', '') AS JustRemoveDash;

-- Replace File extence from txt to csv
SELECT 
	'Report.txt' AS ReportFileInTXT_Form,
	REPLACE('Report.txt', 'txt', 'csv') AS ReplaceFileIntoCSV_Form;

------------------------------------------------------------------------------
-- =======================================================
--  CALCULATION STRING FUNCTION  
-- =======================================================
-- ------------------------------
-- LEN() 
-- ------------------------------ 
-- Calculate the length of each customer's first name?
SELECT 
	first_name,
	LEN(first_name) AS TotalCharactersInFirstName
FROM customers;


----------------------------------------------------------------------
-- =======================================================
-- STRING EXTRACTION FUNCTIONS 
-- =======================================================
-- ------------------------------
-- LEFT() & RIGHT() 
-- ------------------------------ 
-- Retrieve the first two characters of each first name?
-- Retrieve the last two characters of each first name?
SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS StartTwoCharUsingLEFT_Function,
	RIGHT(first_name,2) AS LastTwoCharUsingRIGHT_Function
FROM customers;
-- If we have any empty spaces Using TRIM() to remove them 

-- ------------------------------
-- SUBSTRING() 
-- ------------------------------ 
-- Retrieve a list of customers first names removing the first character
SELECT 
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS SUBSTRIG_Method
FROM customers;
-- Using LEN() we retrieve all character till the last character

-------------------------------------- THE END ------------------------------------