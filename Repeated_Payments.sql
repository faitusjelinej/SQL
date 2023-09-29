# Repeated Payments

with cte as 
(SELECT merchant_id,
credit_card_id,
amount,
transaction_timestamp,
lag(transaction_timestamp) over (PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp) as prev_transaction 
FROM transactions
) 

select count(*)
from cte
where transaction_timestamp - prev_transaction <= INTERVAL '10 minutes'
;
