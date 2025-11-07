/* -----------------------------------------------------------------------------
  File: 02_ddl_basics.sql
  Author: Muhammad Arsalan
  DB: ShopDB (SQL Server)
  Purpose: DDL practice - CREATE / ALTER / DROP / TRUNCATE.
----------------------------------------------------------------------------- */
-- =======================================================
--   CREATE TABLE
-- =======================================================
-- Create a new table called persons with columns: id, person_name, birth_date, and phone.
CREATE TABLE dbo.Persons (
    id INT NOT NULL CONSTRAINT PK_Persons PRIMARY KEY,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE NULL,
    phone VARCHAR(15) NULL
);

-- =======================================================
--   ALTER/MODIFY TABLE
-- =======================================================
-- Add a new column called email to the persons table.
ALTER TABLE Persons
ADD Email VARCHAR(50) NOT NULL;

-- Add a new column called age to the persons table.
ALTER TABLE Persons 
ADD Age VARCHAR(20);
-- The new columns are appended at the end of table by default

-- Changes the Age column’s data type from VARCHAR to INT.
ALTER TABLE Persons
ALTER COLUMN Age INT;

-- Remove the column phone from the persons table.
ALTER TABLE Persons
DROP COLUMN Phone;

-- Verify 
SELECT *
FROM Persons;

-- =======================================================
--   DROP TABLE
-- =======================================================
-- Delete the table persons from the database.
DROP TABLE Persons;

-- Delete the table persons from the database.
DROP TABLE IF EXISTS Persons;

-- =======================================================
--   TRUNCATE TABLE
-- =======================================================
-- Remove all records table persons from the database
TRUNCATE TABLE Persons;

