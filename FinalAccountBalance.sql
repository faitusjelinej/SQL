SELECT account_id,
sum(case when transaction_type = 'Deposit' then amount else 0 END) -
sum(case when transaction_type = 'Withdrawal' then amount else 0 END)
FROM transactions 
GROUP BY account_id
;
