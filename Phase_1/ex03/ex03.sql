USE company_db;

SELECT 
    COUNT(*) AS total_employees
FROM
    employees;

SELECT SUM(salary) AS
	Engineering_salary_total
FROM
	employees
WHERE
	department = 'Engineering';

SELECT ROUND(AVG(salary), 2) AS
	average_salary
FROM
	employees;

SELECT MAX(amount) AS
	highest_sale
FROM
	sales_transactions;

SELECT COUNT(amount) AS
	Total_sales_transaction
FROM
	sales_transactions
	



    
	
