USE company_db;

SELECT 
    first_name,
    last_name
FROM
    employees;

SELECT 
    *
FROM
    employees
WHERE
    department = 'Engineering';

SELECT 
    *
FROM
    employees
WHERE
    salary > 60000;

SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2020-01-01'
        AND department = 'Sales';

SELECT 
    id,
    first_name,
    department
FROM
    employees
WHERE
    salary >= 40000
		AND salary <= 70000;




