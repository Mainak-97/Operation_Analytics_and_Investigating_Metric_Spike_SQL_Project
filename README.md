
# Operation Analytics and Investigating Metric Spike


![Logo](https://i.imgur.com/ZiOdAjd.jpeg)


# Overview
This project involves advanced SQL queries and data analysis to investigate and solve real-world business problems using MySQL. The focus is on two main case studies: Job Data Analysis and Investigating Metric Spike. The project demonstrates how to analyze large datasets, derive meaningful insights, and optimize operations through efficient SQL querying techniques.


# Project Description
Operational Analytics is vital for enhancing a company's operations by identifying areas of improvement.

The project is tasked with analyzing datasets to answer questions posed by different departments within the company. 

The project is divided into two main case studies:
1. Job Data Analysis: 
Analyze job-related data to understand trends, throughput, and language distribution, and to identify duplicate records.

2. Investigating Metric Spike: 
Analyze user engagement metrics to investigate sudden changes and understand user behavior across different dimensions.
# Objectives
## Case Study 1: Job Data Analysis
### Dataset
#### job_data csv file with the following columns:
- job_id: Unique identifier of jobs
- actor_id: Unique identifier of actor
- event: The type of event (decision/skip/transfer)
- language: The Language of the content
- time_spent: Time spent reviewing the job in seconds
- org: The Organization of the actor
- ds: The date in the format yyyy/mm/dd (stored as text)
### Tasks
* Jobs Reviewed Over Time: Calculation of the number of jobs reviewed per hour for each day in November 2020.
* Throughput Analysis: Calculation of the 7-day rolling average of throughput (number of events per second).
* Language Share Analysis: Calculation of the percentage share of each language over the last 30 days.
* Duplicate Rows Detection: Identification of duplicate rows in the data.
### Insights
* Language Share: The analysis showed that Persian had the highest share at 37.5%, with other languages having smaller shares.
* Duplicate Rows: Several duplicate rows were identified across different job IDs, which could indicate data quality issues that need to be addressed.

## Case Study 2: Investigating Metric Spike
### Datasets
- users table: Contains one row per user, with descriptive information about the user’s account.
- events table: Contains one row per event, where an event is an action that a user has taken (e.g., login, messaging, search).
- email_events table: Contains events specific to the sending of emails.
### Tasks
* Weekly User Engagement: Measure the activeness of users on a weekly basis.
* User Growth Analysis: Calculation the growth of users over time for a product.
* Weekly Retention Analysis: Calculation of the weekly retention based on sign-up cohort.
* Weekly Engagement Per Device: Calculation of the activeness of users on a weekly basis per device.
* Email Engagement Analysis: Analyze how users are engaging with the email service.
### Insights
* User Engagement: Weekly engagement metrics provide insights into how active users are over time, which is critical for understanding user retention and behavior.
* Device Engagement: Understanding engagement across different devices can help tailor experiences and improve overall user satisfaction.
* Email Metrics: Analyzing email engagement can reveal how effective email communications are in driving user actions.

## Screenshots [Query + Outcome]

### Job data analysis
* Jobs Reviewed Over Time
![Query 1](https://i.imgur.com/IBtVocZ.jpeg)
![Outcome 1](https://i.imgur.com/OWnsC3A.jpeg)
* Throughput Analysis
![Query 2](https://i.imgur.com/xX67Ui5.jpeg)
![Outcome 2](https://i.imgur.com/GewG6f1.jpeg)
* Language Share Analysis
![Query 3](https://i.imgur.com/EfR990b.jpeg)
![Outcome 3](https://i.imgur.com/6YGostP.jpeg)
* Duplicate Rows Detection
![Query 4](https://i.imgur.com/ZjKTCI1.jpeg)
![Outcome 4](https://i.imgur.com/KaU95au.jpeg)

### Investigating Metric Spike
* Weekly User Engagement
![Query 1](https://i.imgur.com/IaAM201.jpeg)
![Outcome 1.1](https://i.imgur.com/izlctFm.jpeg)
![Outcome 1.2](https://i.imgur.com/RGk7OCC.jpeg)
* User Growth Analysis
![Query 2](https://i.imgur.com/yCwNYy1.jpeg)
![Outcome 2](https://i.imgur.com/a5yiPnr.jpeg)
* Weekly Retention Analysis
![Query 3.1](https://i.imgur.com/Z165VBo.jpeg)
![Query 3.2](https://i.imgur.com/P1PBsvH.jpeg)
![Query 3.3](https://i.imgur.com/OzodidS.jpeg)
![Outcome 3](https://i.imgur.com/nf6lkC3.jpeg)
* Weekly Engagement Per Device
![Query 4.1](https://i.imgur.com/m5Xxhpv.jpeg)
![Query 4.2](https://i.imgur.com/2WdnaTd.jpeg)
![Outcome 4.1](https://i.imgur.com/yCiNCFG.jpeg)
![Outcome 4.2](https://i.imgur.com/Z1Nvw3t.jpeg)
![Outcome 4.3](https://i.imgur.com/3sSCwpH.jpeg)
* Email Engagement Analysis
![Query 5](https://i.imgur.com/MLl15Q7.jpeg)
![Outcome 5](https://i.imgur.com/7rRvmEM.jpeg)



## Project Approach
The approach to this project involved several key steps:

* Data Examination: Thoroughly examining the datasets and creating an ER Diagram to understand the relationships between tables.
* Data Profiling: Understanding the structure of the dataset, including the number of rows and columns, data types, and key relationships.
* SQL Queries: Writing advanced SQL queries to perform the analysis required for both case studies.
* Result Interpretation: Interpreting the results of the queries to provide actionable insights.
### Author

- Mainak Mukherjee 
Email: subha.mainak@gmail.com

Linkedin: www.linkedin.com/in/mainakmukherjee08

### Tech Stack
* MySQL Workbench (Version 8.0.31)
A graphical user interface that simplifies database management and querying.

Provides tools for data modeling, SQL development, and server administration.

### Difficulty Level
Advanced SQL
## Installation and Setup
* Download the Repository:

-> Navigate to the GitHub repository and click on the Code button.

-> Select Download ZIP to download the repository to your local machine.

* Import the SQL Files:
-> The SQL dump file is included in the repository. Locate the SQL file in the extracted folder.
Open MySQL Workbench.

-> Navigate to File > Open SQL Script and select the SQL file from the repository.

-> Execute the script by clicking on the lightning bolt icon or pressing CTRL + Enter.

* Run SQL Scripts:
-> The repository also contains individual SQL scripts for each case study analysis in the scripts/ directory.

-> Open these scripts in MySQL Workbench to reproduce the results of the case studies.
    
## Project Impact and Learning Experience
Throughout this project, I gained insights into operational metrics, user engagement, and language preferences. For instance, in the Language Share Analysis, I observed that Persian had the highest share at 37.5%, with other languages sharing the remaining 62.5%.

The project helped improve the understanding of operational metrics, especially in identifying spikes and trends in user engagement. This analysis can guide decision-making and strategic planning in various departments.
