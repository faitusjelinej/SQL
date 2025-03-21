use testdb;

create TABLE employees (
    id INT,
    skills JSON
);

INSERT INTO employees (id, skills)
VALUES 
    (1, '{"Python": 1, "Java": 2, "Spark": 4, "Azure": 5}'),
    (2, '{"Java": 2, "Python": 6}'),
    (3, '{"Spark": 4, "Azure": 7, "Python": 8}'),
    (4, '{"Azure": 1, "Java": 9}');
 
 with cte as 
(select id,
a.Spark,
a.Java,
a.Python,
a.Azure
from employees,
JSON_TABLE(skills,'$'
	COLUMNS (
		Spark INT PATH '$.Spark',
        Java INT PATH '$.Java',
        Python INT PATH '$.Python',
        Azure INT PATH '$.Azure'
        )) as a
        )
, cte2 as 
(select id,"Spark" as Technology, Spark as Year from cte
UNION ALL
select id,"Java" as Technology, Java as Year from cte
UNION ALL
select id,"Python" as Technology, Python as Year from cte
UNION ALL
select id,"Azure" as Technology, Azure as Year from cte
)

select *
from cte2
where year is not null
order by id
;


