with mode_table as (select email_count mode,
count(user_id)
from inbox_stats
group by email_count
ORDER BY count(user_id) desc
limit 1),
mean_table as (
select round(avg(email_count)) mean
from inbox_stats),
median_asc as (
select *,
row_number() over (ORDER BY email_count asc) as rn_asc
from inbox_stats ),
median_desc as (
select *,
row_number() over (ORDER BY email_count desc) as rn_desc
from inbox_stats ),
median_table as (
select round(avg(a.email_count)) median
from median_asc a join median_desc d
on a.email_count = d.email_count
where abs( rn_asc -  rn_desc) <= 1
)

select mean, median, mode
from mode_table,mean_table, median_table;

