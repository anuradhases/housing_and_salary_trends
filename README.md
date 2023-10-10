# Boston Housing and Salary Analysis 2023
## 232 departments

## Table of Contents
- [Project Overview](#projectoverview)
- [Data Source](#datasource)
- [Key Insights](#keyinsights)

## Project Overview

Based on analysis of Boston property data, I was curious if owning property was affordable for city employees. In this project, I conducted an analysis on 19511 records from Boston housing in 1700-2022 and Boston employee salary in 2023, aimed at providing a high-level overview on affordability of owning housing.

## Data Source
The [salary data](https://data.boston.gov/dataset/employee-earnings-report), detailing earnings of employees working for Boston, was downloaded as a csv from Analyze Boston and came in with 13 columns. Data was copied into a database in Snowflake. Data cleaning and analysis was done in Snowflake. Using the [payroll definition category](https://data.boston.gov/dataset/employee-earnings-report/resource/609a6014-5ab0-49d9-8c38-1389e7bf0d41), 3 relevant columns were selected. <br>

The [property data]() was downloaded as a csv from Analyze Boston and came in with 50+ columns. Data cleaning and analysis for the property dataset done here. The property data was filtered to include only housing.<br>

The salary and property data were joined on zip code, with 10 relevant columns:


Column Name | Description
--- | ---
Zip Code | location of property <br>
Housing Type | type of housing<br>
Avg Building Cost | average building cost of property <br>
Avg Prpty Total Cost | average total cost of property <br>
Avg Gross Tax | average gross tax for property <br>
Avg Gross Tax Portion | average portion of gross tax based on property total cost<br>
Avg Regular | average annual regular salary <br>
Avg Total Gross | average annual total gross salary <br>
Monthly Salary | average monthly total gross salary <br>
Monthly Mortgage | average monthly mortgage based on average property total cost <br>

- [Forbes Reference](https://www.forbes.com/advisor/income-tax-calculator/massachusetts/) for monthly salary calculation. Assumed 20% of monthly salary goes towards taxes.<br>
- [Rocket Mortgage Reference](https://www.rocketmortgage.com/learn/how-to-calculate-mortgage) for monthly mortgage calculation. [Forbes Reference](https://www.forbes.com/advisor/mortgages/mortgage-interest-rates--forecast/#:~:text=Refinance%20Rates%20for%20September%202023,30%2Dyear%20jumbo%3A%207.32%25) for monthly mortgage interest rates and length of loan. Assumed 30-year fixed, with 5.55% interest rate and no down payment. <br>
- All average costs associated with property are for each housing type for each zip code. <br>
- **Affordability defined as monthly mortgage less than 28% of monthly gross salary.** [Times Reference](https://time.com/personal-finance/article/percentage-of-income-mortgage/) <br>

 After first look at the dataset, the following questions came to mind.<br>
- How many departments are included in the dataset? <br>
- What is the highest salary, and in which zip code? <br>
- How does monthly salary vary with zip code? <br>
- What is the average annual salary and annual mortgage? <br>
- How does monthly mortgage vary for each housing type? <br>
- What housing type(s) are affordable (less than 100% of total gross salary)? <br>
- Is housing affordable (less than 30% of salary) for each zip code and housing type? <br>

This [Tableau dashboard](https://public.tableau.com/app/profile/anuradha.s6397/viz/BostonHousing_and_Salary_Analysis/Dashboard1?publish=yes) provides a visual representation of salary and housing costs for the Boston area, focusing on whether owning housing is affordable for city employees.

## Key Insights:
- **232 departments**
- **Highest salary: 1.11 million for zip code: 02186**
- **No affordable property to own for city employees.**
