
create TABLE transactions (
    ID int,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Price FLOAT
);

INSERT INTO transactions (ID,CustomerName, Product, Price)
VALUES 
    (1, 'Alex Thomas', 'Ipad', 450),
	(1, 'Alex Thomas', 'Ipad', NULL),
    (2, 'Emily Johnson', 'Iphone', 950),
    (2, 'Emily Johnson', 'Iphone', 950),
    (3, 'Michael Brown', 'Macbook', NULL),
    (3, 'Michael Brown', 'Macbook', 2000),    
    (4, 'Jessica Wilson', 'Apple Watch',300),
    (5, 'Bill Zee', 'AirPod',NULL),
    (5, 'Bill Zee', 'AirPod',100),
    (5, 'Bill Zee', 'AirPod',100),
    (6, 'Mark Lee', 'Apple TV',NULL),
    (6, 'Mark Lee', 'Apple TV',NULL),
    (7, 'Ben Jacob', 'AirTag',NULL),
    (7, 'Ben Jacob', 'AirTag',NULL), 
    (7, 'Ben Jacob', 'AirTag',50)
    ;
with cte as 
(select *,
row_number() over (partition by id, CustomerName, Product order by Price desc) as rn,
count(Price) over (partition by id,  CustomerName, Product ) as cnt_notnull
FROM transactions)

select id, CustomerName, Product, Price
from cte
where cnt_notnull > 0
and rn = 1
order by id
;
;
