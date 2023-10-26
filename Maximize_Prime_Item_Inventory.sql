-- Maximize Prime Item Inventory

with summary as (
SELECT item_type,
SUM(square_footage) as total_sq,
COUNT(*) as item_count
FROM inventory
GROUP BY item_type),

prime as 
(select item_type,
floor(500000/total_sq) * item_count as item_count,
floor(500000/total_sq) * total_sq as total_sq
from summary
where item_type = 'prime_eligible')

select item_type, item_count
from prime
UNION
(SELECT item_type,
floor((500000 - (select total_sq from prime))/total_sq)*item_count as item_count
from summary
where item_type = 'not_prime')
order by item_type desc
;
