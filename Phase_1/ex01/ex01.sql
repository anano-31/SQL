USE company_db;

-- List all employees sorted by salary from highest to lowest
SELECT 
    *
FROM
    employees
ORDER BY salary DESC;
-- Find the 3 most recently hired employees and show all columns
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC
LIMIT 3;

-- List employees in the Engineering department sorted alphabetically by last_name
SELECT 
    *
FROM
    employees
WHERE
    department = 'Engineering'
ORDER BY last_name ASC;
        
-- Find the 5 lowest-paid employees, showing only first_name, last_name, and salary
SELECT 
    first_name,
    last_name
FROM
    employees
ORDER BY salary ASC
LIMIT 5;

--  List employees by department A to Z, then by salary highest first within each department.
SELECT 
    *
FROM
    employees
ORDER BY department ASC , salary DESC;