--1
select
	c.customer_city
from customers as c
union
select
	s.seller_city
from sellers as s;

--2
select
	c.customer_city
from customers as c
union all
select
	s.seller_city
from sellers as s;

select count(*) as all_cities
from(
	select
	c.customer_city
from customers as c
union all
select
	s.seller_city
from sellers as s
) as combined;

select count(*) as all_cities
from(
	select
	c.customer_city
from customers as c
union
select
	s.seller_city
from sellers as s
) as combined;

--3
select
	c.customer_state
from customers as c
union
select
	s.seller_state
from sellers as s;

--4
select
	op.order_id
from order_payments as op
union
select
	r.order_id
from order_reviews as r;

--5
select
	c.customer_city as city,
	'customer' as source
from customers as c


union all

select
	s.seller_city as city,
	'seller' as source
from sellers as s;

--6
select
	source,
	count(*) as roww_count
from(
select
	c.customer_city as city,
	'customer' as source
from customers as c


union all

select
	s.seller_city as city,
	'seller' as source
from sellers as s
) as combined
group by source;

--7
select
	r.order_id,
	review_score
from order_reviews as r
where review_score = 1

union

select
	r.order_id,
	review_score
from order_reviews as r
where review_score = 5
order by review_score asc;

--8
select
	seller_id,
	s.seller_state
from sellers as s
where s.seller_state = 'SP'

union

select
	seller_id,
	s.seller_state
from sellers as s
where s.seller_state = 'RJ';

-- ** --
select
	seller_id,
	seller_state
from sellers
where seller_state in ('RJ', 'SP');

--9
select
	p.product_weight_g,
	'heavy' as label
from products as p
where p.product_weight_g > 10000

union

select
	oi.freight_value,
	'cheap_to_ship' as label
from order_items as oi
where oi.freight_value < 5;

--10
select
	o.order_id,
	'late' as watchlist
from orders as o
where order_delivered_customer_date > order_estimated_delivery_date

union

select
	r.order_id,
	'low_sore' as watchlist
from order_reviews as r
where r.review_score = 1;

--11        --- all money movements --
select
	oi.order_id,
	oi.price as amount,
	'item_price' as type
from order_items as oi

union all

select
	oi.order_id,
	oi.freight_value as amount,
	'freight' as type
from order_items as oi

union all

select
	op.order_id,
	op.payment_value as amount,
	'payment' as type
from order_payments as op;

--12  --- contact points ---
select
	c.customer_city as city,
	c.customer_state as state,
	'cuctomer' as label
from customers as c

union

select
	s.seller_city as city,
	s.seller_state as state,
	'seller' as label
from sellers as s;

--13  -- flaged records -- do it later needs brain

--14
select
	c.customer_city
from customers as c

intersect

select
	s.seller_city
from sellers as s;

--15
select
	c.customer_state
from customers as c

intersect

select
	s.seller_state
from sellers as s;

--16


--19
select
	c.customer_city
from customers as c

except

select
	s.seller_city
from sellers as s;

--20
select
	s.seller_city
from sellers as s

except

select
	c.customer_city
from customers as c;

--21
select
	oi.order_id
from order_items as oi

except

select
	op.order_id
from order_payments as op;


--25  -- High value states
select
	c.customer_state,
	count(c.customer_id)
from customers as c
group by c.customer_state
having count(c.customer_id) > 5000

union

select
	s.seller_state,
	count(s.seller_id)
from sellers as s
group by s.seller_state
having count(s.seller_id) > 100;

--26
select
	p.product_category_name,
	
























 
	
	

