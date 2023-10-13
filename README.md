# Boston Housing and Salary Analysis 2023
## 232 departments

## Table of Contents
- [Project Overview](#projectoverview)
- [Data Source](#datasource)
- [Key Insights](#keyinsights)

## Project Overview

Based on analysis of Boston property data, I was curious if owning housing was affordable for city employees. In this project, I conducted an analysis on 19511 records from Boston housing in 1700-2022 and Boston employee salary in 2023, aimed at providing a high-level overview on affordability of owning housing.

## Data Source
The [salary data](https://data.boston.gov/dataset/employee-earnings-report), detailing earnings of employees working for Boston, was downloaded as a csv from Analyze Boston and came in with 13 columns. Data was copied into a database in Snowflake. Data cleaning and analysis was done in Snowflake. Using the [payroll definition category](https://data.boston.gov/dataset/employee-earnings-report/resource/609a6014-5ab0-49d9-8c38-1389e7bf0d41), 3 relevant columns were selected. <br>

The [property data]() was downloaded as a csv from Analyze Boston and came in with 50+ columns. Data cleaning and analysis for the property dataset done [here](https://github.com/anuradhases/property_trends). The property data was filtered to include only housing.<br>

The salary and housing data were joined on zip code, with 10 relevant columns:


Column Name | Description
--- | ---
Zip Code | location of housing <br>
Housing Type | type of housing<br>
Avg Building Cost | average building cost of housing <br>
Avg Prpty Total Cost | average total cost of housing <br>
Avg Gross Tax | average gross tax for housing <br>
Avg Gross Tax Portion | average portion of gross tax based on property total cost<br>
Avg Regular | average annual regular salary <br>
Avg Total Gross | average annual total gross salary <br>
Monthly Income | average monthly total gross income based on average total gross salary <br>
Monthly Mortgage | average monthly mortgage based on average property total cost <br>

- [Forbes Reference](https://www.forbes.com/advisor/income-tax-calculator/massachusetts/) for monthly income calculation. Assumed 20% of monthly income goes towards taxes.<br>
- [Rocket Mortgage Reference](https://www.rocketmortgage.com/learn/how-to-calculate-mortgage) for monthly mortgage calculation. [Forbes Reference](https://www.forbes.com/advisor/mortgages/mortgage-interest-rates--forecast/#:~:text=Refinance%20Rates%20for%20September%202023,30%2Dyear%20jumbo%3A%207.32%25) for monthly mortgage interest rates and length of loan. Assumed 30-year fixed, with 5.55% interest rate and no down payment. <br>
- All average costs associated with property are for each housing type for each zip code. <br>
- **Affordability defined as monthly mortgage less than 28% of monthly gross income.** [Times Reference](https://time.com/personal-finance/article/percentage-of-income-mortgage/) <br>

 After first look at the dataset, the following questions came to mind.<br>
- How many departments are included in the dataset? <br>
- What is the highest salary, and in which zip code? <br>
- How does monthly income vary with zip code? <br>
- What is the average annual salary and annual mortgage? <br>
- How does monthly mortgage vary for each housing type? <br>
- What housing type(s) are less than 100% of monthly income? <br>
- How does percent of monthly income towards monthly mortgage vary for each housing type and zip code? <br>

This [Tableau dashboard](https://public.tableau.com/app/profile/anuradha.s6397/viz/BostonHousing_and_Salary_Analysis/Dashboard1?publish=yes) provides a visual representation of salary and housing costs for the Boston area, focusing on whether owning housing is affordable for city employees.

## Key Insights:
- **232 departments**
- **Highest salary: 1.11M for zip code: 02186**
- **Average salary: 67K**
- **No affordable housing to own for city employees. Average monthly mortgage is greater than 28% of monthly income for all housing.**
- **Average Annual Mortgage: 165K**
- **Apartment buildings with 31+ units stand out, with 10X monthly mortgage than other housing, and are the most expensive(~100K).**
- **Residential condo is the cheapest, with 59% of monthly income going towards monthly mortgage of ~3K.**

<img src="https://github.com/anuradhases/housing_and_salary_trends/assets/49212192/71bb8244-6894-4893-b90c-335a45c3e4eb" width = "700" height = "500" />

