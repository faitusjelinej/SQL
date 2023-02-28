-- A phone call is considered an international call when the person calling is in a different country than the person receiving the call.
-- What percentage of phone calls are international? Round the result to 1 decimal.

-- Assumption:
-- The caller_id in phone_info table refers to both the caller and receiver.

create table phone_calls 
(caller_id int,
receiver_id int,
call_time timestamp
);

insert into phone_calls values (1,2,'2022-07-04 10:13:49');
insert into phone_calls values (1,5,'2022-08-21 23:54:56');
insert into phone_calls values (5,1,'2022-05-13 17:24:06');
insert into phone_calls values (5,6,'2022-03-18 12:11:49');

create table phone_info
(caller_id int,
country_id varchar(2),
network varchar(10),
phone_number varchar(20)
);

insert into phone_info values (1,'US','Verizon','+1-212-897-1964');
insert into phone_info values (2,'US','Verizon','+1-703-346-9529');
insert into phone_info values (3,'US','Verizon','+1-650-828-4774');
insert into phone_info values (4,'US','Verizon','+1-415-224-6663');
insert into phone_info values (5,'IN','Vodafone','+91 7503-907302');
insert into phone_info values (6,'IN','Vodafone','+91 2287-664895');

select * from phone_calls;
select * from phone_info;

-- Steps:
-- Join the tables to obtain the caller's and receiver's country information.
-- Count the international calls and the total number of calls.
-- Calculate the percentage of international calls.

-- Solution
with cte as 
(Select caller.country_id caller, receiver.country_id receiver,
case when caller.country_id !=  receiver.country_id then 1 else 0 end ct
from phone_calls p
join phone_info caller
on p.caller_id = caller.caller_id
join phone_info receiver
on p.receiver_id  = receiver.caller_id
)
select round(sum(ct)*1.0/count(ct)*100,1)
from cte
;

