# Boston Housing and Salary Analysis 2023
## 232 departments

## Table of Contents
- [Project Overview](#projectoverview)
- [Data Source](#datasource)
- [Key Insights](#keyinsights)
- [Interesting Facts](#keyinsights)

## Project Overview

In this project, I conducted an analysis on ____- Boston salary records in 2023 and 

, aimed at providing a high-level overview of salary and property cost in each city.

## Data Source
This dataset was downloaded as a csv from Boston Open Source Data and came in with __ columns.
Data cleaning and analysis was done in Snowflake.
Details of each column were provided here and
In order to have an effective analysis, __ columns were selected.
In order to determine which columns were relevant,
This left with 11 relevant columns. 

-- with more than 60% data missing, conclusions invalid
-- remove injured, quinn_education, overtime

Zip Code <br>
Housing Type <br>
Avg Building Cost <br>
Avg Prpty Total Cost <br>
Avg Gross Tax <br>
Avg Gross Tax Portion <br>
Avg Regular <br>
Avg Total Gross <br>
Monthly Salary <br>
Monthly Mortgage <br>


-- land cost was excluded as values were 0 for all zip codes

--monthly take home salary: : assumed 20% of income goes to taxes  
-- https://www.forbes.com/advisor/income-tax-calculator/massachusetts/
-- federal marginal tax rate: 22%
-- state marginal tax rate: 5%
-- taxes are roughly 20% of income, and will use this as basis since formula is complicated
-- filing single

-- monthly mortgage payments
--assume 30 month 
-- https://www.forbes.com/advisor/mortgages/mortgage-interest-rates-forecast/#:~:text=Refinance%20Rates%20for%20September%202023,30%2Dyear%20jumbo%3A%207.32%25
-- interest rate: 5.55%
-- APR: 5.56%
-- length of loan: 30-year fixed
-- assume no down payment
-- https://www.rocketmortgage.com/learn/how-to-calculate-mortgage

-- M = P [ I(1 + I)^N ] / [ (1 + I)^N − 1]

After first look at the dataset, the following questions came to mind.




Exploratory Data Analysis and Data Visualizations:
- How many departments are included in the dataset? <br>
- What is the highest salary, and in which zip code? <br>
- How does monthly salary vary with zip code? <br>
- Is the salary affordable for housing in each zip code? <br>
- What kind of housing is affordable on monthly salary? (assuming mortage is max 1/2 the salary) <br>
- How does monthly mortgage vary for each type of housing with zipcode? (map) <br>
- How does average regular and average total gross salary compare for each department? <br>


[Tableau dashboard]

## Key Insights:

- 232 departments

  
--highest salary (total_gross), and zip code with highest salary
- 1.11 million for zip code: 02186














