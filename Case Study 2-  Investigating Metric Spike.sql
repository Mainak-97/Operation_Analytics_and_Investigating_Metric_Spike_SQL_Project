Create database project3_2;
use project3_2;
# Table 1 Users
-- user_id	created_at	company_id	language	activated_at	state
create table Users (
user_id int,
created_at varchar(100),
company_id int,
language varchar(50),
activated_at varchar(100),
state varchar(50));
select * from users;
-- to show where the file should be placed 
SHOW VARIABLES LIKE 'secure_file_priv';
-- loading data from file
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE Users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- Now the 'created_at' and 'activated_at' tables are in varchar and need to change into datetiem format
alter table users add column temp_created_at datetime;
SET SQL_SAFE_UPDATES = 0;
UPDATE users SET temp_created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i');
alter table users drop column created_at;
alter table users change column temp_created_at created_at datetime;

alter table users add column temp_activated_at datetime;
SET SQL_SAFE_UPDATES = 0;
UPDATE users SET temp_activated_at = STR_TO_DATE(activated_at, '%d-%m-%Y %H:%i');
alter table users drop column activated_at;
alter table users change column temp_activated_at activated_at datetime;

# Table 2 Events
-- user_id	occurred_at	event_type	event_name	location	device	user_type
create table Events (
user_id int,
occured_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int);
select * from events;
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE Events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- same with occured-at, varchar to datetime 
alter table events add column temp_occured_at datetime;
SET SQL_SAFE_UPDATES = 0;
UPDATE events SET temp_occured_at = STR_TO_DATE(occured_at, '%d-%m-%Y %H:%i');
alter table events drop column occured_at;
alter table events change column temp_occured_at occured_at datetime;

# Table 3 Email Events
--  user_id	occurred_at	action	user_type
create table Email_Events (
user_id int,
occured_at varchar(100),
action varchar(100),
user_type int);
select * from email_events;
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE Email_Events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- same with occured-at, varchar to datetime
alter table Email_Events add column temp_occured_at datetime;
SET SQL_SAFE_UPDATES = 0;
UPDATE Email_Events SET temp_occured_at = STR_TO_DATE(occured_at, '%d-%m-%Y %H:%i');
alter table Email_Events drop column occured_at;
alter table Email_Events change column temp_occured_at occured_at datetime;

-- Now the project is ready to start
use project3_2;
select * from users;
select * from events;
select * from email_events;

-- Objective: Measure the activeness of users on a weekly basis. Calculate the weekly user engagement.
select extract(week from occured_at) as Week_No,
count(distinct user_id) as Active_users from events 
where event_type = "engagement"
group by week_no
order by week_no;

-- Objective: Analyze the growth of users over time for a product. Calculate the user growth for the product.

SELECT Months, Users, ROUND((Users / LAG(Users, 1) OVER (ORDER BY Months-1) * 100), 2) AS "Growth_in_%"
FROM ( SELECT 
EXTRACT(MONTH FROM created_at) AS Months, 
COUNT(activated_at) AS Users 
FROM users
WHERE activated_at IS NOT NULL
GROUP BY Months
ORDER BY Months
) sub;

-- Calculate the weekly retention of users based on their sign-up cohort.
SELECT first AS `Week Numbers`,

SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS `Week 0`,
SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS `Week 1`,
SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS `Week 2`,
SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS `Week 3`,
SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS `Week 4`,
SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS `Week 5`,
SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS `Week 6`,
SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS `Week 7`,
SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS `Week 8`,
SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS `Week 9`,
SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS `Week 10`,
SUM(CASE WHEN week_number = 11 THEN 1 ELSE 0 END) AS `Week 11`,
SUM(CASE WHEN week_number = 12 THEN 1 ELSE 0 END) AS `Week 12`,
SUM(CASE WHEN week_number = 13 THEN 1 ELSE 0 END) AS `Week 13`,
SUM(CASE WHEN week_number = 14 THEN 1 ELSE 0 END) AS `Week 14`,
SUM(CASE WHEN week_number = 15 THEN 1 ELSE 0 END) AS `Week 15`,
SUM(CASE WHEN week_number = 16 THEN 1 ELSE 0 END) AS `Week 16`,
SUM(CASE WHEN week_number = 17 THEN 1 ELSE 0 END) AS `Week 17`,
SUM(CASE WHEN week_number = 18 THEN 1 ELSE 0 END) AS `Week 18`
FROM
(
    SELECT m.user_id, 
           m.login_week, 
           n.first, 
           m.login_week - n.first AS week_number 
    FROM
    (
        SELECT user_id, EXTRACT(WEEK FROM occured_at) AS login_week 
        FROM events 
        GROUP BY user_id, login_week
    ) m
    JOIN
    (
        SELECT user_id, MIN(EXTRACT(WEEK FROM occured_at)) AS first 
        FROM events 
        GROUP BY user_id
    ) n
    ON m.user_id = n.user_id
) sub
GROUP BY first 
ORDER BY first;

-- Calculate the weekly engagement per device.
SELECT EXTRACT(WEEK FROM occured_at) AS `Week Numbers`,

COUNT(DISTINCT CASE WHEN device = 'dell inspiron notebook' THEN user_id ELSE NULL END) AS `Dell Inspiron Notebook`,
COUNT(DISTINCT CASE WHEN device = 'iphone 5' THEN user_id ELSE NULL END) AS `iPhone 5`,
COUNT(DISTINCT CASE WHEN device = 'iphone 4s' THEN user_id ELSE NULL END) AS `iPhone 4S`,
COUNT(DISTINCT CASE WHEN device = 'windows surface' THEN user_id ELSE NULL END) AS `Windows Surface`,
COUNT(DISTINCT CASE WHEN device = 'macbook air' THEN user_id ELSE NULL END) AS `Macbook Air`,
COUNT(DISTINCT CASE WHEN device = 'iphone 5s' THEN user_id ELSE NULL END) AS `iPhone 5S`,
COUNT(DISTINCT CASE WHEN device = 'macbook pro' THEN user_id ELSE NULL END) AS `Macbook Pro`,
COUNT(DISTINCT CASE WHEN device = 'kindle fire' THEN user_id ELSE NULL END) AS `Kindle Fire`,
COUNT(DISTINCT CASE WHEN device = 'ipad mini' THEN user_id ELSE NULL END) AS `iPad Mini`,
COUNT(DISTINCT CASE WHEN device = 'nexus 7' THEN user_id ELSE NULL END) AS `Nexus 7`,
COUNT(DISTINCT CASE WHEN device = 'nexus 5' THEN user_id ELSE NULL END) AS `Nexus 5`,
COUNT(DISTINCT CASE WHEN device = 'samsung galaxy s4' THEN user_id ELSE NULL END) AS `Samsung Galaxy S4`,
COUNT(DISTINCT CASE WHEN device = 'lenovo thinkpad' THEN user_id ELSE NULL END) AS `Lenovo Thinkpad`,
COUNT(DISTINCT CASE WHEN device = 'samsung galaxy tablet' THEN user_id ELSE NULL END) AS `Samsung Galaxy Tablet`,
COUNT(DISTINCT CASE WHEN device = 'acer aspire notebook' THEN user_id ELSE NULL END) AS `Acer Aspire Notebook`,
COUNT(DISTINCT CASE WHEN device = 'asus chromebook' THEN user_id ELSE NULL END) AS `Asus Chromebook`,
COUNT(DISTINCT CASE WHEN device = 'htc one' THEN user_id ELSE NULL END) AS `HTC One`,
COUNT(DISTINCT CASE WHEN device = 'nokia lumia 635' THEN user_id ELSE NULL END) AS `Nokia Lumia 635`,
COUNT(DISTINCT CASE WHEN device = 'samsung galaxy note' THEN user_id ELSE NULL END) AS `Samsung Galaxy Note`,
COUNT(DISTINCT CASE WHEN device = 'acer aspire desktop' THEN user_id ELSE NULL END) AS `Acer Aspire Desktop`,
COUNT(DISTINCT CASE WHEN device = 'mac mini' THEN user_id ELSE NULL END) AS `Mac Mini`,
COUNT(DISTINCT CASE WHEN device = 'hp pavilion desktop' THEN user_id ELSE NULL END) AS `HP Pavilion Desktop`,
COUNT(DISTINCT CASE WHEN device = 'dell inspiron desktop' THEN user_id ELSE NULL END) AS `Dell Inspiron Desktop`,
COUNT(DISTINCT CASE WHEN device = 'ipad air' THEN user_id ELSE NULL END) AS `iPad Air`,
COUNT(DISTINCT CASE WHEN device = 'amazon fire phone' THEN user_id ELSE NULL END) AS `Amazon Fire Phone`,
COUNT(DISTINCT CASE WHEN device = 'nexus 10' THEN user_id ELSE NULL END) AS `Nexus 10`

FROM events

WHERE event_type = 'engagement'
GROUP BY `Week Numbers`
ORDER BY `Week Numbers`;

-- Calculate the email engagement metrics.
SELECT Week,
    ROUND((weekly_digest / total * 100), 2) AS `Weekly Digest Rate`,
    ROUND((email_opens / total * 100), 2) AS `Email Open Rate`,
    ROUND((email_clickthroughs / total * 100), 2) AS `Email Clickthrough Rate`,
    ROUND((reengagement_emails / total * 100), 2) AS `Reengagement Email Rate`
FROM (
    SELECT EXTRACT(WEEK FROM occured_at) AS Week,
        COUNT(CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS weekly_digest,
        COUNT(CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS email_opens,
        COUNT(CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS email_clickthroughs,
        COUNT(CASE WHEN action = 'sent_reengagement_email' THEN user_id ELSE NULL END) AS reengagement_emails,
        COUNT(user_id) AS total
    FROM email_events
    GROUP BY Week
) sub
ORDER BY Week;


