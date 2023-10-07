------------------------------
-- Boston Salary Cleaning --
------------------------------

-- View first 10 rows of data
SELECT * 
FROM BOSTON_SALARY_DETAILS
LIMIT 10;

-- ***************************
-- DATA CLEANING -------------
-- ***************************

-- Remove duplicate rows
DROP TABLE IF EXISTS boston_salary_details_cleaned;
CREATE TABLE boston_salary_details_cleaned AS
SELECT DISTINCT *
FROM boston_salary_details;

-- Remove commas and rename columns
UPDATE boston_salary_details_cleaned
SET "REGULAR" = REPLACE("REGULAR", ',', '');
UPDATE boston_salary_details_cleaned
SET "REGULAR" = ROUND("REGULAR");

UPDATE boston_salary_details_cleaned
SET "OVERTIME" = REPLACE("OVERTIME", ',', '');
UPDATE boston_salary_details_cleaned
SET "OVERTIME" =  ROUND("OVERTIME");

UPDATE boston_salary_details_cleaned
SET "INJURED" = REPLACE("INJURED", ',', '');
UPDATE boston_salary_details_cleaned
SET "INJURED" =  ROUND("INJURED");

ALTER TABLE boston_salary_details_cleaned
RENAME COLUMN "POSTAL" TO "ZIP_CODE";

UPDATE boston_salary_details_cleaned
SET "QUINN_EDUCATION" = REPLACE("QUINN_EDUCATION", ',', '');
UPDATE boston_salary_details_cleaned
SET "QUINN_EDUCATION" =  ROUND("QUINN_EDUCATION");

UPDATE boston_salary_details_cleaned
SET "TOTAL_GROSS" = REPLACE("TOTAL_GROSS", ',', '');
UPDATE boston_salary_details_cleaned
SET "TOTAL_GROSS" = ROUND("TOTAL_GROSS");

-- Determine % missing data for all columns
DROP TABLE IF EXISTS boston_salary_null_counts;
CREATE TABLE boston_salary_null_counts AS
SELECT 'name' as column_name, ROUND((COUNT(*)- COUNT("NAME"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'dept_name' as column_name, ROUND((COUNT(*)- COUNT("DEPARTMENT_NAME"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'title' as column_name, ROUND((COUNT(*)- COUNT("TITLE"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'regular' as column_name, ROUND((COUNT(*)- COUNT("REGULAR"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'overtime' as column_name, ROUND((COUNT(*)- COUNT("OVERTIME"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'injured' as column_name, ROUND((COUNT(*)- COUNT("INJURED"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'quinn_education' as column_name, ROUND((COUNT(*)- COUNT("QUINN_EDUCATION"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'total_gross' as column_name, ROUND((COUNT(*)- COUNT("TOTAL_GROSS"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned
UNION ALL
SELECT 'zip_code' as column_name, ROUND((COUNT(*)- COUNT("ZIP_CODE"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned;

-- View columns with more than 5% missing data
SELECT *
FROM boston_salary_null_counts
WHERE null_percent >= 5
ORDER BY null_percent DESC;

-- Add 0 to beginning of ZIP_CODE column to graph on map
UPDATE boston_salary_details_cleaned
SET "ZIP_CODE" = LPAD("ZIP_CODE"::text, 5,'0');

-- Trim whitespace for all columns
UPDATE boston_salary_details_cleaned
SET "NAME" = TRIM("NAME", ' '),
"DEPARTMENT_NAME" = TRIM("DEPARTMENT_NAME", ' '),
"TITLE" = TRIM("TITLE", ' '),
"REGULAR" = TRIM("REGULAR", ' '),
"OVERTIME" = TRIM("OVERTIME", ' '),
"INJURED" = TRIM("INJURED", ' '),
"QUINN_EDUCATION" = TRIM("QUINN_EDUCATION", ' '),
"TOTAL_GROSS" = TRIM("TOTAL_GROSS", ' '),
"ZIP_CODE" = TRIM("ZIP_CODE", ' ');

-- ***************************
-- ANALYSIS 
-- ***************************

-- Number of departments 
SELECT COUNT(DISTINCT"DEPARTMENT_NAME")
FROM boston_salary_details_cleaned;

-- Highest salary (TOTAL_GROSS), and zip code with highest salary
SELECT "ZIP_CODE", MAX("TOTAL_GROSS"::float)
FROM boston_salary_details_cleaned
WHERE ("TOTAL_GROSS"::float) = (SELECT(MAX("TOTAL_GROSS"::float)) FROM boston_salary_details_cleaned)
GROUP BY "ZIP_CODE";