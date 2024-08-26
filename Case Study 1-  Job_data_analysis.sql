create database project3;
show databases;
use project3;

# table creation
create table job_data
(ds date,
job_id int not null,
actor_id int not null,
event varchar(15) not null,
language varchar(15) not null,
time_spent int not null,
org char(2)
);
select * from job_data;

# value insertation

insert into job_data (ds, job_id, actor_id, event, language, time_spent, org)
values
("2020-11-30", 21, 1001, "skip", "English", 15, "A"),
("2020-11-30", 22, 1006, "transfer", "Arabic", 25, "B"),
("2020-11-29", 23, 1003, "decision", "Persian", 20, "C"),
("2020-11-28", 23, 1005, "transfer", "Persian", 22, "D"),
("2020-11-28", 25, 1002, "decision", "Hindi", 11, "B"),
("2020-11-27", 11, 1007, "decision", "French", 104, "D"),
("2020-11-26", 23, 1004, "skip", "Persian", 56, "A"),
("2020-11-25", 20, 1003, "transfer", "Italian", 45, "C");

/*Job_data_analysis*/

# 1. Jobs Reviewed Over Time: Calculate the number of jobs reviewed per hour for each day in November 2020.
select 
date(ds) as review_date,
hour(ds) as review_hour,
count(*) as job_reviewed_per_hr_day
from job_data
where month(ds) = 11 and year(ds) = 2020
group by review_date, review_hour
order by review_date, review_hour;

# 2. Throughput Analysis: Calculate the 7-day rolling average of throughput.
select ds, jobs_reviewed, total_events, avg(total_events)
over ( order by ds rows between 6 preceding and current row)
as avg_7day_rolling_throughput
from
(select ds, count(distinct event) as total_events,
count(distinct job_id) as jobs_reviewed
from job_data
group by ds
order by ds) base;

# 3. Language Share Analysis: Calculate the percentage share of each language over the last 30 days
select language, count(language) as total_language,
(count(language)*100) / sum(count(language))
over () as percentage_share_language
from job_data
group by language
order by language desc;

# 4. Duplicate Rows Detection: Display duplicate rows from the job_data table. 
With T as (select *, row_number() over (partition by event) as Duplicate_rows
from job_data)
select * from T where duplicate_rows >= 1;
