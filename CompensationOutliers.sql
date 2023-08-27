-- Data Engineering Studies  / https://www.youtube.com/@faitusjeline/videos

-- Compensation Outliers

with payout as 
(SELECT *,
(AVG(salary) OVER(PARTITION BY title))*2 as double_salary,
(AVG(salary) OVER(PARTITION BY title))/2 as half_salary 
FROM employee_pay)

select employee_id,
salary,
case when salary > double_salary then 'Overpaid'
    when salary < half_salary then 'Underpaid'
End as outlier_status    
from payout
where salary > double_salary OR
salary < half_salary
;
