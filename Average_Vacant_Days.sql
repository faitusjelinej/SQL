-- https://datalemur.com/questions/average-vacant-days

with vacancies as (select l.listing_id, 365 - COALESCE(sum(CASE WHEN checkout_date> '12/31/2021' THEN '12/31/2021' ELSE checkout_date END -
CASE WHEN checkin_date< '01/01/2021' THEN '01/01/2021' ELSE checkin_date END ), 0) as vacant_days
from listings l
left join bookings b
on l.listing_id = b.listing_id
where l.is_active = 1
GROUP BY l.listing_id )

select ROUND(AVG(vacant_days))
from vacancies
;
