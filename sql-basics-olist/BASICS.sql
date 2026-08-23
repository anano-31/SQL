-- Write a query that returns all orders with order_status = 'canceled'. 
-- Just pull order_id, order_status, and order_purchase_timestamp.
SELECT
	ORDER_ID,
	ORDER_STATUS,
	ORDER_PURCHASE_TIMESTAMP
FROM
	ORDERS
WHERE
	ORDER_STATUS = 'canceled';

-- Now let's look at order value. Using order_items, write a query that returns order_id,
-- product_id, and price, showing the most expensive items first.
SELECT
	ORDER_ID,
	PRODUCT_ID,
	PRICE
FROM
	ORDER_ITEMS
ORDER BY
	PRICE DESC;

-- Using order_items write a query that gives you the total revenue (SUM(price)) and number of items sold 
-- (COUNT(*)) — just overall, not grouped by anything yet. This is a warm-up for aggregates before we add GROUP BY.
SELECT
	SUM(PRICE),
	COUNT(*)
FROM
	ORDER_ITEMS;

-- Using orders alone: write a query that shows how many orders fall into each order_status. 
-- Group by status, count them, order by count descending.
SELECT
	ORDER_STATUS,
	COUNT(*) AS QUANTITY
FROM
	ORDERS
GROUP BY
	ORDER_STATUS
ORDER BY
	QUANTITY DESC;

-- Using orders, write a query that shows only the statuses that have more than 1000 orders.
-- Same GROUP BY as before, but now add a HAVING clause instead of WHERE (since we're 
-- filtering on the aggregate result, not raw rows).
SELECT
	ORDER_STATUS,
	COUNT(*) AS QUANTITY
FROM
	ORDERS
GROUP BY
	ORDER_STATUS
HAVING
	COUNT(*) > 1000;

-- Using orders, write a query that finds what percentage of orders were never delivered — 
-- i.e. order_delivered_customer_date IS NULL.
SELECT
	COUNT(*) AS TOTAL_ORDERS,
	COUNT(*) FILTER (
		WHERE
			ORDER_DELIVERED_CUSTOMER_DATE IS NULL
	) AS UNDELIVERED,
	ROUND(
		100.0 * COUNT(*) FILTER (
			WHERE
				ORDER_DELIVERED_CUSTOMER_DATE IS NULL
		) / COUNT(*),
		2
	) AS PCT_UNDELIVERED
FROM
	ORDERS;

-- Count how many order items have freight_value equal to 0 (free shipping), out of all order items.
SELECT
	COUNT(*) FILTER (
		WHERE
			FREIGHT_VALUE = 0
	)
FROM
	ORDER_ITEMS;

-- Find the percentage of orders where order_approved_at is NULL
-- (payment was never approved). Use total count, filtered count,
-- then calculate percentage using 100.0 * and ROUND.
SELECT
	COUNT(*) AS TOTAL_ORDERS,
	COUNT(*) FILTER (
		WHERE
			ORDER_APPROVED_AT IS NULL
	),
	ROUND(
		100.0 * COUNT(*) FILTER (
			WHERE
				ORDER_APPROVED_AT IS NULL
		) / COUNT(*),
		2
	) AS PCT_NOT_APPROVED
FROM
	ORDERS;

-- Using order_items, find what percentage of items
-- have price greater than 100.
-- Write your query below:
SELECT
	COUNT(*) AS TOTAL_ITEMS,
	COUNT(*) FILTER (
		WHERE
			PRICE > 100
	) AS PRICE_MORE_100,
	ROUND(
		100.0 * COUNT(*) FILTER (
			WHERE
				PRICE > 100
		) / COUNT(*),
		2
	)
FROM
	ORDER_ITEMS;

-- -- Using orders, count how many orders have BOTH
-- order_delivered_carrier_date IS NULL AND order_status = 'canceled'.
-- Combine two conditions inside one FILTER. 
SELECT
	COUNT(*) FILTER (
		WHERE
			ORDER_DELIVERED_CARRIER_DATE IS NULL
			AND ORDER_STATUS = 'canceled'
	)
FROM
	ORDERS;

-- Using orders, in a single query return:
-- count of 'delivered' orders, count of 'canceled' orders,
-- and the ratio of delivered-to-canceled (delivered ÷ canceled), rounded to 2 decimals.
-- Write your query below:
SELECT
	COUNT(*) FILTER (
		WHERE
			ORDER_STATUS = 'canceled'
	) AS CANCELED_ORDERS,
	COUNT(*) FILTER (
		WHERE
			ORDER_STATUS = 'delivered'
	) AS DELIVERED_ORDERS,
	ROUND(
		COUNT(*) FILTER (
			WHERE
				ORDER_STATUS = 'delivered'
		) * 1.0 / COUNT(*) FILTER (
			WHERE
				ORDER_STATUS = 'canceled'
		),
		2
	) AS DLIVERED_CANCELED_RATIO
FROM
	ORDERS;

-- Order volume by status, but only statuses that make up
-- more than 5% of total orders (filter out rare edge-case statuses).
-- Write your query below:
SELECT
	COUNT(ORDER_STATUS) AS STATUS_COUNT,
	ORDER_STATUS
FROM
	ORDERS
GROUP BY
	ORDER_STATUS
HAVING
	5 < COUNT(ORDER_STATUS) * 100.0 / (
		SELECT
			COUNT(*)
		FROM
			ORDERS
	);

-- Question 2: "We want to flag high-value order items for a promo campaign.
-- Using order_items, can you write a query that labels each item as 'high_value' 
-- if the price is over 150, and 'standard' otherwise? Just show order_id, price, 
-- and this new label column."
SELECT
	ORDER_ID,
	PRICE,
	CASE
		WHEN PRICE > 150 THEN 'high_value'
		ELSE 'standard'
	END AS FLAGED_ORDERS
FROM
	ORDER_ITEMS;

-- Using order_items: label each item as 'cheap' if price < 50, otherwise 'expensive'. 
-- Then show how many items fall into each bucket.
SELECT
	CASE
		WHEN PRICE > 50 THEN 'expensive'
		ELSE 'cheap'
	END
FROM
	ORDER_ITEMS;

--     --- CASE 1 ---
SELECT
	COUNT(*) FILTER (
		WHERE
			PRICE > 50
	) AS EXPENSIVE,
	COUNT(*) FILTER (
		WHERE
			PRICE < 50
	) AS CHEAP
FROM
	ORDER_ITEMS;

--     --- Case 2 ---
SELECT
	CASE
		WHEN PRICE > 50 THEN 'expensive'
		ELSE 'cheap'
	END AS FLAGED_PRICE,
	COUNT(*) AS ITEM_COUNT,
	ROUND
	(
	COUNT(*) * 100.0/(SELECT COUNT(*) FROM ORDER_ITEMS), 2
	) AS PCT_OF_TOTAL
FROM
	ORDER_ITEMS
GROUP BY
	CASE
		WHEN PRICE > 50 THEN 'expensive'
		ELSE 'cheap'
	END;



