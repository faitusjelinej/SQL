-- Assume you are given the table containing measurement values obtained from a Google sensor over several days. 
-- Measurements are taken several times within a given day.
-- Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns. 


create table measurements
(measurement_id int,
measurement_value float,
measurement_time timestamp
);

insert into measurements values (131233,1109.51,'2022-07-10 09:00:00');
insert into measurements values (135211,1662.74,'2022-07-10 11:00:00');
insert into measurements values (523542,1246.24,'2022-07-10 13:15:00');
insert into measurements values (143562,1124.50,'2022-07-11 15:00:00');
insert into measurements values (346462,1234.14,'2022-07-11 16:45:00');

-- Solutions

with cte as
(select CAST(measurement_time as date) measurement_day,
measurement_value,
row_number() over (PARTITION BY CAST(measurement_time as date) order by measurement_time) rn
from measurements)
select measurement_day,
sum(case when rn%2 != 0 then measurement_value else 0 end) odd_sum,
sum(case when rn%2 = 0 then measurement_value else 0 end) even_sum
from cte
GROUP BY measurement_day;

