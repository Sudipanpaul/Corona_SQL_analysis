
use covid;

select * from cvd;


select column_name,data_type
from INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'cvd';

-- The abovse shows date is text lets change it into actual date format

update cvd
set date = str_to_date(date,"%d-%m-%Y");

-- Write a code to check NULL values
-- lets focus on Conf,dts,rec to check null values

select * 
from cvd
where Confirmed is  null
or Deaths is  null 
or Recovered is null;

-- Lets count
select count(*)
from cvd
where Confirmed is  null
or Deaths is  null 
or Recovered is null;

-- zero nulls

-- counting rows

SELECT COUNT(*)
FROM  cvd;  -- 78386

-- max date and mind date

select min(Date) as starting_date,max(Date) as end_date
from cvd;

-- number of months present in the dataset will be from two years 
-- no of months from 20

select count(distinct(EXTRACT(MONTH from Date))) AS year_2020
from cvd
where EXTRACT(YEAR FROM Date) = '2020';
-- answer 12

select count(distinct(EXTRACT(MONTH from Date))) AS year_2021
from cvd
where EXTRACT(YEAR FROM Date) = '2021';

-- ans 6
-- total no of months = 6+12 = 18

-- lets use DATE_FORMAT("%Y-%m) which will take account of all months of both years
select date_format(Date,'%Y-%m') as month,
AVG(Confirmed) as avg_conf,
AVG(Deaths) AS avg_death,
AVG(Recovered) AS avg_rec
from cvd
group by month;

-- Most freq month


-- order by count(Deaths) desc;

-- min caes ,death ,recovered by year

select date_format(Date,'%Y') as year,
min(Confirmed) as min_con,
min(Deaths) as min_deaths,
min(Recovered) as min_rec
from cvd
group by year;  --  min values are zero

-- lets go beyond zeros
select date_format(Date,'%Y') as year,
min(Confirmed) as min_con,
min(Deaths) as min_deaths,
min(Recovered) as min_rec
from cvd
where Confirmed <> 0 and Deaths <>0 and Recovered <> 0
group by year; 


-- finidg max for the same

select date_format(Date,'%Y') as year,
max(Confirmed) as mx_con,
max(Deaths) as mx_deaths,
max(Recovered) as mx_rec
from cvd
group by year;


-- monthly totals

select date_format(Date,'%Y-%m') as month,
sum(Confirmed) as total_confirmed,
sum(Deaths) as total_deaths,
sum(Recovered) as total_recovered
from cvd
group by month;

--  spread wrt to confirmed

select sum(Confirmed) as total_conf,
avg(Confirmed) as avg_confirmed,
stddev(Confirmed) as std_confirmed,
variance(Confirmed) as var_confirmed
from cvd;

-- spread wrt death per month
select date_format(Date,'%Y-%m') as month,
sum(Deaths) as total_death,
avg(Deaths) as avg_death,
round(stddev(Deaths),3) as std_deaths,
round(variance(Deaths),3) as var_deaths
from cvd
group by month;

-- spread wrt recovered
select sum(Recovered) as total_rec,
avg(Recovered) as avg_rec,
stddev(Recovered) as std_rec,
variance(Recovered) as var_rec
from cvd;

-- Country with higest number of conf cases
select `Country/Region`, sum(Confirmed) as total_conf
from cvd
group by `Country/Region`
order by total_conf desc
limit 1; 

-- lowest death case
select `Country/Region`, sum(Deaths) as total_deaths
from cvd
group by `Country/Region`
order by total_deaths ASC
limit 1; 

-- top five country with good recovery

select `Country/Region`, sum(Recovered) as total_rev
from cvd
group by `Country/Region`
order by total_rev DESC
limit 5; 





