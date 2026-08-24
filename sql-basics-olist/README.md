# SQL Basics Practice — Olist E-Commerce Orders

First project in my SQL learning path. Focus: single-table querying —
`SELECT`/`WHERE`, `GROUP BY`/`HAVING`, aggregates, `CASE` statements, and
a first look at subqueries. No joins yet (that's the next project).

## Dataset

[Brazilian E-Commerce (Olist) — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Only two tables used at this stage:
- `orders` — order status, timestamps (purchase, approval, delivery)
- `order_items` — line items with price and freight value

Loaded into PostgreSQL via `\copy`.

## Questions explored

1. What percentage of orders were never delivered?
2. Which order statuses make up more than 5% of total orders?
3. What percentage of orders never had payment approved?
4. How do order items split between "cheap" and "expensive" price buckets?

## Example queries

**1. % of orders never delivered** (handling NULLs with `FILTER`)
```sql
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
```
Answers: how much of the dataset represents failed deliveries — relevant
for any "why did we lose this customer" business question later.

**2. Order statuses over 5% of total volume** (subquery in `HAVING`)
```sql
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
```
Filters out rare/noise statuses so a status breakdown isn't cluttered
with edge cases that barely register.

**3. Price segmentation with CASE + GROUP BY + %**
```sql
SELECT
	CASE
		WHEN PRICE >= 50 THEN 'expensive'
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
```
Buckets items into segments for a rough view of product pricing mix.

## What surprised me

- 2.98% of orders were not delivered, the number is low, so it's a good sign.
- Only one status survived 5% threshold - delivered
- 34% of products where cheap

## Setup

```sql
CREATE DATABASE olist_basics;

CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE order_items (
    order_id VARCHAR,
    order_item_id INT,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);

\copy orders FROM 'data/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;
\copy order_items FROM 'data/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;
```

