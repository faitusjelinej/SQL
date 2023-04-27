with product_detail as 
(SELECT category,
product,
sum(spend) total_spend
from product_spend
where transaction_date >= '2022-01-01'
and transaction_date <= '2022-12-31'
GROUP BY category,
product )
, prod_rk as (
select *, RANK() over (PARTITION BY category order by total_spend DESC) rk
from product_detail)

select category,
product,
total_spend
from prod_rk
where rk <= 2
;