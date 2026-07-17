USE company_db;

-- Retrieve all employees in either 'Engineering' or 'HR' using IN.
SELECT 
    *
FROM
    employees
WHERE
    department IN ('HR' , 'Engineering');
    
-- Find employees with a salary between 50000 and 80000 using BETWEEN.
SELECT 
    *
FROM
    employees
WHERE
    salary BETWEEN 50000 AND 80000;
    
-- Find all employees whose last_name starts with 'S'.
SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'S%';

-- Find all employees whose hire_date is unknown.
SELECT 
    *
FROM
    employees
WHERE
    hire_date IS NULL;
    
-- Find employees not in 'Sales' or 'Marketing', with a salary above 55000.
SELECT 
    *
FROM
    employees
WHERE
    department NOT IN ('Sales' , 'marketing')
        AND salary > 55000;
    