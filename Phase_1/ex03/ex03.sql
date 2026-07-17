use company_db;

-- How many employees are in the company total?
SELECT 
    COUNT(*) AS total_employees
FROM
    employees;

-- What is the total salary paid to the Engineering department?
SELECT 
    SUM(salary) AS total_salary_engineering
FROM
    employees
WHERE
    department = 'Engineering';

-- What is the average salary across all employees rounded to 2 decimal places?
SELECT 
    ROUND(AVG(salary), 2) AS employees
FROM
    employees;

-- What was the single highest sale amount in sales_transactions?
SELECT 
    MAX(amount) AS highest_sale_amount
FROM
    sales_transactions;

-- How many sales transactions were recorded in total?
SELECT 
    COUNT(amount) AS total_transactions
FROM
    sales_transactions;
