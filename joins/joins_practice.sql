SELECT *
FROM ORDERS;

SELECT*
FROM CUSTOMERS;

SELECT
	ORDERS.ORDER_ID,
	ORDERS.ORDER_STATUS,
	CUSTOMERS.CUSTOMER_CITY
FROM
	ORDERS
INNER JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID;

-- Write a query using olist_order_items_dataset and olist_sellers_dataset that 
-- returns every order item along with its seller's city and state.
SELECT *
FROM ORDER_ITEMS;

SELECT
	*
FROM
	SELLERS;

SELECT
	OI.PRODUCT_ID,
	S.SELLER_CITY,
	S.SELLER_STATE
FROM
	ORDER_ITEMS AS OI
	INNER JOIN SELLERS AS S ON OI.SELLER_ID = S.SELLER_ID;

-- Write a query that joins olist_orders_dataset with olist_customers_dataset. 
-- Show customer locations and label orders as 'Fast' if freight/delivery was 
-- fulfilled ahead of schedule or 'Delayed' otherwise. Filter only for orders with status 'delivered'.
SELECT *
FROM ORDERS;

SELECT*
FROM CUSTOMERS;

SELECT
	O.ORDER_ID,
	C.CUSTOMER_CITY,
	C.CUSTOMER_STATE,
	CASE
		WHEN O.ORDER_DELIVERED_CUSTOMER_DATE < O.ORDER_ESTIMATED_DELIVERY_DATE THEN 'fast'
		ELSE 'delayed'
	END AS SHIPPING_SPEED
FROM
	ORDERS AS O
	INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE
	O.ORDER_STATUS = 'delivered';

-- Write a query joining olist_order_items_dataset with olist_products_dataset.
-- Group by the product category name and calculate total revenue (sum of price),
-- showing only the top 5 highest-grossing categories.
SELECT
	*
FROM
	ORDER_ITEMS;

SELECT
	*
FROM
	PRODUCTS;

SELECT
	P.PRODUCT_CATEGORY_NAME,
	SUM(OI.PRICE) AS TOTAL_REVENUE
FROM
	PRODUCTS AS P
	INNER JOIN ORDER_ITEMS AS OI ON P.PRODUCT_ID = OI.PRODUCT_ID
GROUP BY
	P.PRODUCT_CATEGORY_NAME
ORDER BY
	TOTAL_REVENUE DESC
LIMIT
	5;

-- Write a query that retrieves all records from olist_orders_dataset and 
-- joins olist_order_reviews_dataset. Return the order ID, order status, and review score.
select *
from orders;

select *
from order_reviews;

SELECT
	O.ORDER_ID,
	O.ORDER_STATUS,
	R.REVIEW_SCORE
FROM
	ORDERS AS O
	LEFT JOIN ORDER_REVIEWS AS R ON O.ORDER_ID = R.ORDER_ID;

-- Using a LEFT JOIN between olist_orders_dataset and olist_order_reviews_dataset, 
-- filter for rows where the review data is missing
SELECT
	O.ORDER_ID,
	O.ORDER_STATUS,
	R.REVIEW_SCORE
FROM
	ORDERS AS O
	LEFT JOIN ORDER_REVIEWS AS R ON O.ORDER_ID = R.ORDER_ID
WHERE
	r.review_score is NULL;

-- Write a query joining olist_orders_dataset with olist_order_payments_dataset using a LEFT JOIN.
-- Group by order_id and count the number of payment records per order. Include orders that have no 
-- payment records registered (their count should be 0).
select *
from orders;

select *
from order_payments;

select
	o.order_id,
	count(p.payment_sequential) as payment_records
from
	orders as o
left join order_payments as p on o.order_id = p.order_id
group by o.order_id;
	
-- Join orders, customers, and order_items. Group by customer city, calculate 
-- total spend (sum of price), and return the top 5 highest-spending cities for 
-- orders with status 'delivered'.
SELECT
	*
FROM
	ORDER_ITEMS;

SELECT
	*
FROM
	ORDERS;

SELECT
	*
FROM
	CUSTOMERS;

SELECT
	C.CUSTOMER_CITY,
	SUM(OI.PRICE) AS TOTAL_SPENT
FROM
	ORDERS AS O
	INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
	INNER JOIN ORDER_ITEMS AS OI ON O.ORDER_ID = OI.ORDER_ID
WHERE
	O.ORDER_STATUS = 'delivered'
GROUP BY
	C.CUSTOMER_CITY
ORDER BY
	TOTAL_SPENT DESC
LIMIT
	5;

-- Join sellers, order_items, orders, and order_reviews
-- using LEFT JOINs starting from sellers. Calculate:
--1. Total items sold per seller state.
--2. Total reviews received per seller state.
select *
from sellers;

select *
from order_items;

select *
from orders;

select * 
from order_reviews;

select
	s.seller_state,
	count(oi.order_id) as items_sold_per_state,
	count(r.review_id) as reviws_per_state
from sellers as s
left join order_items as oi on oi.seller_id = s.seller_id
left join order_reviews as r on r.


	









	

