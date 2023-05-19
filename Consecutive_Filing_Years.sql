-- Consecutive Filing Years

with tax as (
SELECT user_id,
lag(EXTRACT(year from filing_date)) over (PARTITION BY user_id ORDER BY filing_date) as prev_year,
EXTRACT(year from filing_date) as current_year,
lead(EXTRACT(year from filing_date)) over (PARTITION BY user_id ORDER BY filing_date) as next_year

FROM filed_taxes
where lower(product) like 'turbotax%')

select distinct user_id
from tax
where next_year - prev_year = 2
;
