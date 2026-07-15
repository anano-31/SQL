USE company_bd;

-- Show the number of employees in each department.
SELECT 
    department, COUNT(*) AS employee_count
FROM
    employees
GROUP BY department;

-- Show the average salary per department, rounded to 2 decimal places.
SELECT
	department,
    round(AVG(salary), 2) AS average_salary
FROM
	employees
GROUP BY
	department;

-- Show the total sales amount per employee_id from sales_transactions.
SELECT
	employee_id,
    sum(amount) AS sales_per_empl_id
FROM
	sales_transactions
GROUP BY
	employee_id;

-- Find departments that have more than 2 employees.
SELECT
	department,
    count(*) AS employee_count
FROM
	employees
GROUP BY
	department
HAVING
	count(*) > 2;
	
-- Find employees by employee_id whose total sales exceed 5000.
SELECT
	employee_id,
    sum(amount) AS exceed_5000
FROM
	sales_transactions
GROUP BY
	employee_id
HAVING
	sum(amount) > 5000;

-- Show minimum and maximum salary per department, ordered by maximum salary descending.
SELECT 
    department,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM
    employees
GROUP BY department
ORDER BY max_salary DESC;
	