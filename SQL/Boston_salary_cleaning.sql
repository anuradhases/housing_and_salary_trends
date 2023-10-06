------------------------------
-- Boston Salary Cleaning --
------------------------------

--view data
SELECT * 
FROM BOSTON_SALARY_DETAILS
LIMIT 10;

-- remove duplicates

DROP TABLE IF EXISTS boston_salary_details_cleaned;
CREATE TABLE boston_salary_details_cleaned AS
SELECT DISTINCT *
FROM boston_salary_details;

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


UPDATE boston_salary_details_cleaned
SET "QUINN_EDUCATION" = REPLACE("QUINN_EDUCATION", ',', '');
UPDATE boston_salary_details_cleaned
SET "QUINN_EDUCATION" =  ROUND("QUINN_EDUCATION");

UPDATE boston_salary_details_cleaned
SET "TOTAL_GROSS" = REPLACE("TOTAL_GROSS", ',', '');
UPDATE boston_salary_details_cleaned
SET "TOTAL_GROSS" = ROUND("TOTAL_GROSS");

--count nulls
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
SELECT 'postal' as column_name, ROUND((COUNT(*)- COUNT("POSTAL"))/(COUNT(*))* 100) AS null_percent 
FROM boston_salary_details_cleaned;

SELECT *
FROM boston_salary_null_counts
WHERE null_percent >= 5
ORDER BY null_percent DESC;

-- with more than 60% data missing, conclusions invalid
-- remove injured, quinn_education, overtime

--add 0 to zip code
UPDATE boston_salary_details_cleaned
SET "POSTAL" = LPAD("POSTAL"::text, 5,'0');

DROP TABLE IF EXISTS boston_salary_details_cleaned_by_zip_code;
CREATE TABLE boston_salary_details_cleaned_by_zip_code AS
SELECT "POSTAL", 
ROUND(AVG("REGULAR"::float)) as avg_regular,
ROUND(AVG("TOTAL_GROSS"::float)) as avg_total_gross
FROM boston_salary_details_cleaned
GROUP BY "POSTAL";


