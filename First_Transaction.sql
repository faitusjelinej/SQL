-- Assume you are given the table below on user transactions. 
-- Write a query to obtain the list of customers whose first transaction was valued at $50 or more. 
-- Output the number of users.

create table user_transactions
(transaction_id int,
user_id int,
spend float,
transaction_date timestamp
);

insert into user_transactions values (615348,145, 36.30, '2022-03-22 00:00:00');
insert into user_transactions values (137424,156, 151.00, '2022-04-04 00:00:00');
insert into user_transactions values (759274,111, 49.50,'2022-02-03 00:00:00');
insert into user_transactions values (850371,111, 51.00,'2022-03-15 00:00:00');
insert into user_transactions values (248475,156, 87.00, '2022-04-16 00:00:00');
insert into user_transactions values (563301,180, 78.50, '2022-03-25 00:00:00');
insert into user_transactions values (968585,268, 47.30, '2022-03-24 00:00:00');
insert into user_transactions values (632020,179, 36.89, '2022-04-29 00:00:00');
insert into user_transactions values (120562,268, 96.70, '2022-02-28 00:00:00');
insert into user_transactions values (362514,179, 250.00, '2022-05-23 00:00:00');
insert into user_transactions values (563021,180, 36.89, '2022-06-28 00:00:00');
insert into user_transactions values (248476,156, 78.90, '2022-04-04 00:00:00');

select *
from user_transactions
;

-- Solution 1 using row_number() window function

with cte as 
(select user_id,
spend,transaction_date,
row_number() over (PARTITION BY user_id ORDER BY transaction_date) rn
from user_transactions)

select COUNT(*)
from cte
where spend > 50.00 and
rn = 1
;

-- Solution 2 using rank() window function

with cte as 
(select user_id,
spend,transaction_date,
rank() over (PARTITION BY user_id ORDER BY transaction_date) rn
from user_transactions)

select COUNT(distinct user_id)
from cte
where spend > 50.00 and
rn = 1
;

-- Solution 3 using first_value() window function

with cte as 
(select user_id,
spend,
first_value(spend) over (PARTITION BY user_id ORDER BY transaction_date) fv
from user_transactions)

select count(distinct user_id) 	users
from cte
where fv >= 50.00 
;

