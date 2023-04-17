
create table transactions
(transaction_id int,
customer_id int,
product_name varchar(50),
transaction_timestamp timestamp
);


delete
from transactions
;

insert into transactions values (1,101, 'iPhone', '2022-08-08 12:00:00');
insert into transactions values (2,101, 'AirPods', '2022-08-08 12:00:00');
insert into transactions values (5,301, 'iPhone', '2022-09-05 00:00:00');
insert into transactions values (6,301, 'iPad', '2022-09-06 12:00:00');
insert into transactions values (7,301, 'AirPods', '2022-09-07 00:00:00');
insert into transactions values (3,201, 'iPhone', '2022-08-11 00:00:00');
insert into transactions values (4,201, 'AirPods', '2022-08-12 00:00:00');

-- solution

with cust_trans as (
select customer_id,
product_name,
lag(product_name) over (partition by customer_id order by transaction_timestamp) prev_prod_name
from transactions)

select round(sum(case when product_name = 'Airpods' and prev_prod_name = 'iPhone' then 1 else 0 end)*100 / count(distinct customer_id),0) followup_percentage
from cust_trans
;

