-- Consecutive Filing Years
-- ------------------------
-- Intuit offers several tax filing products, such as TurboTax and QuickBooks, which come in multiple versions.
-- Write a query to find the user ids of everyone who filed their taxes with any version of TurboTax three or more years in a row. Display the output in the ascending order of user ids.
-- Assumption:
-- As reflected in the table, a user can only file taxes once a year using one product.

/* filed_taxes Table:
---------------------
Column Name	Type
filing_id	integer
user_id	varchar
filing_date	datetime
product	varchar */

-- Solution

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
