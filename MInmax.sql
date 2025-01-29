create table Organization_info (emp_name varchar(10),department varchar(10),salary int);

insert into Organization_info values('Edwin','Marketing',1000);
insert into Organization_info values('Mark','Marketing',1020);
insert into Organization_info values('Ken','Marketing',870);
insert into Organization_info values('Sam','Finance',1200);
insert into Organization_info values('Bill','Finance',1500);
insert into Organization_info values('Frank','Finance',1100);
insert into Organization_info values('Philip','Sales',1050);
insert into Organization_info values('Jen','Sales',1350);
insert into Organization_info values('Mike','Sales',1700);

select department, min(salary) minsalary, max(salary) maxsalasry
from Organization_info
group by department
;

with cte as 
(select *,
row_number() over (partition by department order by salary) as minsalary,
row_number() over (partition by department order by salary desc) as maxsalary
from Organization_info)

select department,
min(case when minsalary = 1 then salary end) as minsalary,
min(case when maxsalary = 1 then salary end) as maxsalary
from cte
group by department
;
