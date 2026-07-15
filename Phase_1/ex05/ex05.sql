USE company_db;

-- Display each employee's full name as a single column called full_name.
SELECT 
    CONCAT(first_name, last_name) AS full_name
FROM
    employees;

-- Show all customer emails in upper case.
SELECT 
    UPPER(email) AS customer_emails
FROM
    customers;

-- Find customers whose email address is longer than 20 characters.
SELECT 
    *
FROM
    customers
WHERE
    LENGTH(email) > 20;

-- Show customer city and country concatenated as city, country aliased as location.
SELECT 
    CONCAT(city, ', ', country) AS locatioin
FROM
    customers;

-- Extract just the domain part from each email using SUBSTRING_INDEX
SELECT 
    email, SUBSTRING_INDEX(email, '@', - 1) AS email_domain
FROM
    customers;
