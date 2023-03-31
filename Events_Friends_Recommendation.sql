

create table friendship_status
(user_a_id int,
user_b_id int,
status  enum ('friends', 'not_friends')
);

insert into friendship_status values (111, 333, 'not_friends');
insert into friendship_status values (222, 333, 'not_friends');
insert into friendship_status values (333, 222, 'not_friends');
insert into friendship_status values (222, 111, 'friends');
insert into friendship_status values (111, 222, 'friends');
insert into friendship_status values (333, 111, 'not_friends');

select *
from friendship_status;


create table event_rsvp
(user_id int,
event_id int,
event_type enum ('public', 'private'),
attendance_status enum  ('going', 'maybe', 'not_going'),
event_date date
);

insert into event_rsvp values (111, 567,'public','going' ,'2022-07-12');
insert into event_rsvp values (222, 789,'private','going' ,'2022-07-15');
insert into event_rsvp values (333, 789,'private','maybe' ,'2022-07-15');
insert into event_rsvp values (111, 234,'private','not_going' ,'2022-07-18');
insert into event_rsvp values (222, 234,'private','going' ,'2022-07-18');
insert into event_rsvp values (333, 234,'private','going' ,'2022-07-18');

-- solution

with private_event as (
select user_id, event_id
from event_rsvp
where attendance_status != 'not_going'
and event_type = 'private')

select event1.user_id,
event2.user_id
from private_event event1
join private_event event2
on event1.user_id != event2.user_id
and event1.event_id = event2.event_id
join friendship_status friends 
on event1.user_id = friends .user_a_id
and event2.user_id = friends .user_b_id
where friends.status = 'not_friends'
group by event1.user_id,
event2.user_id
having count(*) > 1
;




