/* -----------------------------------------------------------------------------
  File: 03_dml_basics.sql
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: DML practice - INSERT / UPDATE / DELETE.
----------------------------------------------------------------------------- */
-- =======================================================
--   INSERT
-- =======================================================
-- #1 Method: Manual INSERT using VALUES. 
-- INSERT some data in Customers Table uisng Manual Entry Method.
-- ONE Manual Entry.
INSERT INTO customers (id,first_name,country,score) 
VALUES (6,'Sihra','Germany',30);

-- Multiple Manual Entries
INSERT INTO customers (id,first_name,country,score) 
VALUES 
	(7,'Heri','France',NULL),
	(8,'Merter',NULL,40),
	(9,NULL,NULL,NULL);

-- Insert a new record with full column values
INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'Max', 'USA', 368);

-- Insert a new record without specifying column names (not recommended)
INSERT INTO Customers
VALUES (10,'Meria','Findland',30);

-- When Insert only few columns
INSERT INTO customers (id, first_name)
VALUES (11,'Bara');

-- Incorrect column order 
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (8, 'Max', 'USA', NULL);

-- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES 
	('Max', 9, 'Max', NULL);


--------------------------------------------------------------------
-- #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another.
-- Copy data from the 'customers' table into 'persons'
INSERT INTO Persons (id,person_name,birth_date,Email,Age)(
	SELECT 
	id,
	first_name,
	NULL,
	'UNKNOWN',
	NULL
FROM customers);

-- Verify
SELECT * 
FROM Persons;


-- =======================================================
--   UPDATE
-- =======================================================
--  Change the score of customers with ID = 6 to 0.
UPDATE customers
SET score = 0
WHERE id = 6;

-- Change the score of customers 8 to 0 and update the country to UK.
UPDATE customers
SET score = 0 ,country = 'UK'
WHERE id = 8;

-- Update all customers with a NULL score by setting thier score to 0.
UPDATE customers
SET score = 0
WHERE score IS NULL;


-- Before updating and deleting use SELECT to check the values.
-- Verify the update
SELECT * 
FROM customers
WHERE score  IS NULL;


-- =======================================================
--   DELETE
-- =======================================================
-- Select customers with an ID greater than 5 before deleting.
SELECT *
FROM customers
WHERE id > 5;

-- Delete all customers with ID greater than 5.
DELETE customers
WHERE id > 5;


-- Delete all data from persons table
DELETE Persons;

-- But here we use TRUNCATE() to delete all data from table and structure will be remain.
-- Faster method to delete all rows, especially useful for large tables

TRUNCATE TABLE Persons;
												-- THE END --

