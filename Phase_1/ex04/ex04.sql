USE company_bd;

-- Show the number of employees in each department.
select
	department,
    count(*) as employee_count_department
from
	employees
group by
	department;

-- Show the average salary per department, rounded to 2 decimal places.
select
	department,
    round(avg(salary))
from
	employees
group by
	department;
	
-- Show the total sales amount per employee_id from sales_transactions.
select
	employee_id,
    sum(amount) as total_sales
from
	sales_transactions
group by
	employee_id;

-- Find departments that have more than 2 employees.
select
	department,
    count(*) as employee_count
from
	employees
group by
	department
having
	employee_count > 2;

-- Find employees by employee_id whose total sales exceed 5000.
select
	employee_id,
    sum(amount) as total_sales_more_5000
from
	sales_transactions
group by
	employee_id
having
	total_sales_more_5000 > 5000;

-- Show minimum and maximum salary per department, ordered by maximum salary descending.
select
	department,
    min(salary) AS min_salary,
    max(salary) AS max_salary
from
	employees
group by
	department
order by
	max_salary DESC;


	