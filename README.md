# Covid-19 Data Exploration using SQL
## Project Overview
* In this project I performed an **EDA** for the COVID 19 Data for deaths and vaccination on a total of 170+ lakh records.
* **Joined** the Deaths and Vaccination table for deeper insights.
* Used **window** functions to perform advanced calculations.
* Used **CTEs** to perform operations on data extracted from window functions.
* Used Microsoft SQL Server for EDA
* The data is taken from January 2020 - April 2021.

[Project Files](https://github.com/apoorvjain1995/EDA-on-Covid-19-Data-using-SQL)

## Findings
* The highest death percentage for India was on 12/4/2020 being 3.5%. This means that 3 of every 100 people were likely to die due to Covid-19.
* The highest infection rate ever was in a country called Andorra being 17% on 30/4/2021. This means that 17 of every 100 people were likely to be infected by Covid-19.
* The overall highest infection rate WRT population for a country was for Andorra being 17%. The second highest overall infection rate WRT population for a country was for Montenegro being 15%.
* The highest overall death count for a country was for United States being 5,75,232.
* If we break things by continents the highest death count was for North America.
* The total cases for the whole world were 15,05,74,977 while the total death count was 31,80,206 and the overall death percentage was at 2.11%.
* **Joining** the Vaccination and Death tables we found out that the highest single day vaccination count was in Thailand being 99,985. We also used the **window** function to record a **running people vaccinated count**.
* To perform operation on the running people vaccinated count which were obtained in the above query we used a **CTE**.
* We also created a temporary table to store the data obtained in the above query which can be used to perform operation on rolling people vaccinated column. 
* Also created a view of the data extracted in the previous query, so that it can be used for visualization.  




