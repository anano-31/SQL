use company_bd;

-- A query showing total headcount and average salary per department, ordered by headcount descending.
select
	count(id) as headcount,
    round(avg(salary), 2) as avg_salary_department,
    department
from
	employees
group by
	department
order by
	headcount desc;
    
-- A query finding the top 3 highest earners using ORDER BY and LIMIT.
SELECT 
    id, first_name, last_name, salary
FROM
    employees
ORDER BY salary DESC
LIMIT 3;
	
-- A query showing each employee's full name, department, salary, and whether their salary is above or below the department average.
SELECT 
    CONCAT(e.first_name, e.last_name) AS full_name,
    e.department,
    e.salary,
    CASE
        WHEN
            e.salary > (SELECT 
                    AVG(salary)
                FROM
                    employees
                WHERE
                    department = e.department)
        THEN
            'Above avgerage'
        ELSE 'below average'
    END AS salary_vs_department_average
FROM
    employees AS e;

-- A query showing total revenue per employee, including employees with zero sales using LEFT JOIN.


-- A written list of 3 observations from the data in SQL comments using --.




