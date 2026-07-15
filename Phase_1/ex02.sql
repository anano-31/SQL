USE company_db;

SELECT 
    *
FROM
    employees
WHERE
    department IN ('Engineering' , 'HR');

SELECT 
    *
FROM
    employees
WHERE
    salary BETWEEN 50000 AND 80000;

SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'S%';
    
SELECT 
    *
FROM
	employees
WHERE
	hire_date IS NULL;
  
SELECT 
    *
FROM
    employees
WHERE
    department NOT IN ('Sales' , 'Marketing')
        AND salary > 55000;