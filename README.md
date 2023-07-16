# Bellabeat-Case-Study

This case study asked the question: How Can A Wellness Company Play It Smart? The central task was to analyze smart device data to gain insight into how customers use their smart devices then allow those insights to guide the company's marketing strategy. As a result of the analysis, the marketing recieves recommendations drawn from the analysis.

## ASK
To gain insights into how consumers use non-Bellabeat smart devices, I asked questions such as
* What are trends in smart device usage?
  * the type of data that is tracker
  * The age of the users
  * Different health conditions
  * Reasons for choosing to use a smart device
  * Time spent using the device
* How could these trends apply to Bellabeat customers?
* What is the problem to be solved?
    * Insights inform Bellabeat on how to grow and cater to their user-base
* How can insights drive business decisions?
    * When Bellabeat knows how users interact with their smart device, they can make informed decisions about feautres, products, and adverstisements to increase their userbase or customer loyalty.

## Prepare, Process, Analyze
**METHOD: Data cleaning and analysis in Google Sheets and SQL (BigQuery)**

In Google Sheets, I performed the following tasks:
* data verification
    * verifying that the information was consistent with the description from Kaggle (it was not)
    * during this step, it is evident that the sample size was too small to draw conclusions for an entire population of users
* filtering and sorting
     *filtering and sorting the data using pivot tables gave an initial depiction of the types of data collected in the study
*  data cleaning
    * formatting dates to "YYYY-MM-DD"
    * formatting records to be compatible for processing in SQL

In Google BigQuery, I performed the following tasks:
* Joined two or more tables (OUTER JOIN)
* Format dates and strings to other data types (CAST)
* Create new tables from joined data depending on certain conditions (CASE) 
<p>
In SQL, I also performed calculation of sums and percentages, cast dates to day of the week strings, and organized datetimes into categories. After all oricesses were completed, I exported the new tables to CSVs for visualization.</p>

[See SQL analysis](https://github.com/almostelle/Bellabeat-Case-Study/blob/f7f910188f0ec7012c010b6fbb41db9f23c33d8c/SQLprocesses.sql)

## Share
Using Tableau, I imported the clean, organized, and formatted tables to tell a clear story about the trends in fitness data in an interactive dashboard. This presentation also gives recommendations based on the conclusions drawn from the data.<p>
[See Tableau Dashboard](https://github.com/almostelle/Bellabeat-Case-Study/blob/f7f910188f0ec7012c010b6fbb41db9f23c33d8c/TableauDashboard.md) </p>
