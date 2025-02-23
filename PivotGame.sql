create table players (name varchar(100),game varchar(100));

-- Pivot the Game column 
-- Each Player Name should be sorted alphabetically
-- Display Names under its corresponding Game


insert into players values('Sachin Tendulkar','Cricket');
insert into players values('Brian Lara','Cricket');
insert into players values('Ricky Ponting','Cricket');
insert into players values('MS Dhoni','Cricket');
insert into players values('Roger Federer','Tennis');
insert into players values('Novak Djokovic','Tennis');
insert into players values('Pete Sampras','Tennis');
insert into players values('Magnus Carlsen','Chess');
insert into players values('Gukesh Dommaraju','Chess');

with cte as 
(select *,
row_number() over (partition by game order by name asc) rn
from players)

select rn,  
min(case when game = 'Chess' then name end) as Chess,
min(case when game = 'Cricket' then name end) as Cricket,
min(case when game = 'Tennis' then name end) as Tennis
from cte
group by rn
;
