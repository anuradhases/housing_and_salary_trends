-------------------------------------
-- Boston Housing and Salary Analysis
-------------------------------------

-- Create table of housing for each zip code and city
DROP TABLE IF EXISTS boston_housing_details_cleaned_groupedby_zipcode;
CREATE TABLE boston_housing_details_cleaned_groupedby_zipcode AS
SELECT
"ZIP_CODE",
"CITY",
"PRPTY_TYPE",
ROUND(AVG("LAND_COST"::float)) AS avg_land_cost,
ROUND(AVG("BUILDING_COST"::float)) AS avg_building_cost,
ROUND(AVG("PRPTY_TOTAL_COST"::float)) AS avg_prpty_total_cost,
ROUND(AVG("GROSS_TAX"::float)) AS avg_gross_tax,
ROUND(AVG(CASE WHEN "PRPTY_TOTAL_COST"::float > "GROSS_TAX"::float AND "GROSS_TAX"::float != 0 AND "PRPTY_TOTAL_COST"::float != 0 AND "GROSS_TAX" IS NOT NULL AND "PRPTY_TOTAL_COST" IS NOT NULL THEN "GROSS_TAX"::float/"PRPTY_TOTAL_COST"::float*100 END),2) AS avg_gross_tax_portion
FROM boston_property_details_cleaned
WHERE "ZIP_CODE" IS NOT NULL AND
"PRPTY_TYPE" LIKE '%DWELLING' 
OR  "PRPTY_TYPE" LIKE'APT%'
OR "PRPTY_TYPE" LIKE'APARTMENT%'
OR "PRPTY_TYPE" LIKE'RESIDENTIAL CONDO'
GROUP BY "ZIP_CODE", "CITY","PRPTY_TYPE";


-- Create table of average regular salary and average total gross salary for each zip code
DROP TABLE IF EXISTS boston_salary_details_cleaned_by_zip_code;
CREATE TABLE boston_salary_details_cleaned_by_zip_code AS
SELECT "ZIP_CODE",
ROUND(AVG("REGULAR"::float)) as avg_regular,
ROUND(AVG("TOTAL_GROSS"::float)) as avg_total_gross
FROM boston_salary_details_cleaned
GROUP BY "ZIP_CODE";

-- Join salary & housing details by zip code
DROP TABLE IF EXISTS boston_housing_and_salary;
CREATE TABLE boston_housing_and_salary AS
SELECT bhousing."ZIP_CODE",
bhousing."CITY",
bhousing."PRPTY_TYPE" AS "HOUSING_TYPE",
bhousing."AVG_BUILDING_COST",
bhousing."AVG_PRPTY_TOTAL_COST",
bhousing."AVG_GROSS_TAX",
bhousing."AVG_GROSS_TAX_PORTION",
bsalary."AVG_REGULAR",
bsalary."AVG_TOTAL_GROSS"
FROM boston_housing_details_cleaned_groupedby_zipcode bhousing
JOIN boston_salary_details_cleaned_by_zip_code bsalary
ON bhousing."ZIP_CODE" = bsalary."ZIP_CODE"
WHERE "AVG_BUILDING_COST" > 0;


-- Monthly take home salary
ALTER TABLE boston_housing_and_salary
ADD COLUMN monthly_income FLOAT AS ROUND(("AVG_TOTAL_GROSS" * 0.8)/12);


-- Monthly mortgage payments
ALTER TABLE boston_housing_and_salary
ADD COLUMN monthly_mortgage FLOAT AS ROUND(("AVG_PRPTY_TOTAL_COST" *((0.0555/12*(POWER((1+(0.0555/12)),360)))/
(POWER((1+(0.0555/12)),360) - 1))));


-- View data
SELECT*
FROM boston_housing_and_salary;
