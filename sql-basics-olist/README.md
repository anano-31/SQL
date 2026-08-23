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
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS undelivered,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) / COUNT(*),
        2
    ) AS pct_undelivered
FROM orders;
```
Answers: how much of the dataset represents failed deliveries — relevant
for any "why did we lose this customer" business question later.

**2. Order statuses over 5% of total volume** (subquery in `HAVING`)
```sql
SELECT
    order_status,
    COUNT(*) AS status_count
FROM orders
GROUP BY order_status
HAVING COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders) > 5;
```
Filters out rare/noise statuses so a status breakdown isn't cluttered
with edge cases that barely register.

**3. Price segmentation with CASE + GROUP BY**
```sql
SELECT
    CASE
        WHEN price < 50 THEN 'cheap'
        ELSE 'expensive'
    END AS price_bucket,
    COUNT(*) AS item_count
FROM order_items
GROUP BY
    CASE
        WHEN price < 50 THEN 'cheap'
        ELSE 'expensive'
    END;
```
Buckets items into segments for a rough view of product pricing mix.

## What surprised me

- [Fill in: the actual % of undelivered orders you found]
- [Fill in: which order statuses cleared the 5% threshold and which didn't]
- [Fill in: anything about the cheap/expensive split that stood out]

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

## Next stage

Multi-table joins across the full Olist schema (customers, products,
sellers, payments) — business questions like top products by revenue
per month and customer retention.
