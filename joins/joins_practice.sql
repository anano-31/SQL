--1
select *
from order_items;

select *
from products;

select
	oi.order_id,
	p.product_id,
	oi.price,
	p.product_category_name
from order_items as oi
inner join 
	products as p on 
		oi.product_id = p.product_id;

--2
select *
from orders;

select *
from customers;

select
	o.order_id,
	o.order_status,
	c.customer_city,
	c.customer_state
from orders as o
inner join 
	customers as c on 
		o.customer_id = c.customer_id;

--3
select *
from sellers;

select
 	oi.order_id,
	s.seller_id,
	s.seller_city,
	oi.price
from order_items as oi
inner join 
	sellers as s on
		oi.seller_id=s.seller_id;

--4
select *
from order_payments;

select *
from
	orders;

select
	op.order_id,
	op.payment_type,
	op.payment_value,
	o.order_status
from orders as o
inner join
	order_payments as op on
		o.order_id = op.order_id;
--5
select *
from order_reviews;

select
	r.review_score,
	r.review_comment_message,
	o.order_status
from order_reviews as r
inner join 
	orders as o on
		r.order_id = o.order_id;
	
--6
select *
from products;

select
	p.product_category_name,
	oi.price,
	oi.freight_value,
	oi.product_id
from order_items as oi
inner join 
	products as p on
		oi.product_id = p.product_id;

--7
select
	c.customer_city,
	o.order_purchase_timestamp,
	c.customer_state
from orders as o
inner join 
	customers as c on
		o.customer_id = c.customer_id
where
	c.customer_state = 'SP';

--8
select
	s.seller_city,
	oi.order_item_id,
	s.seller_id,
	s.seller_state
from sellers as s
inner join
	order_items as oi on
		oi.seller_id = s.seller_id
where
	s.seller_state = 'SP';

--9
select
	o.order_id,
	o.order_status,
	op.payment_type
from order_payments as op
inner join
	orders as o on
		op.order_id = o.order_id
where payment_type = 'boleto';

--10
select
	p.product_category_name,
	r.review_score,
	r.review_id
from products as p
inner join
	order_items as oi on
		oi.product_id = p.product_id
inner join
	order_reviews as r on
		oi.order_id = r.order_id;

--11
select *
from
	order_items;

select
	s.seller_id,
	s.seller_city,
	oi.order_id
from sellers as s
left join 
	order_items as oi on
		s.seller_id = oi.seller_id;

--12
select *
from
	products;

select *
from
	order_items;

select
	p.product_id,
	p.product_category_name,
	oi.order_id
from
	products as p
left join
	order_items as oi on
		oi.product_id = p.product_id;

--13
select
	o.order_id,
	o.order_status,
	r.review_score
from orders as o
left join
	order_reviews as r on
		r.order_id = o.order_id;

--14
select
	c.customer_id,
	o.order_id
from customers as c
left join 
	orders as o on
		o.customer_id = c.customer_id;

--15
select
	o.order_id,
	p.payment_type
from orders as o
left join
	order_payments as p on
		p.order_id = o.order_id;
	
--16
select
	s.seller_id,
	count(oi.order_item_id) as sold_count
from sellers as s
left join
	order_items as oi on
		s.seller_id = oi.seller_id
group by s.seller_id
order by sold_count;

--17
select
	p.product_category_name,
	avg(oi.price) avg_price
from products as p
left join
	order_items as oi on
		oi.product_id = p.product_id
group by p.product_category_name
order by avg_price asc;

--18
select
    o.order_id,
    o.order_delivered_carrier_date
from orders as o
order by o.order_id;

--19 false
select
	c.customer_state,
	count(s.seller_id)
from customers as c
left join
	orders as o on
		o.customer_id = c.customer_id
left join
	order_items as oi on
		oi.order_id = o.order_id
left join
	sellers as s on
		s.seller_id = oi.seller_id
group by c.customer_state
where c.customer_state = s.seller_state;

--20 not studied yet
select
	o.order_id,
	r.review_comment_title
from orders as o
left join 
	order_reviews as r on
		o.order_id = r.order_id;

--21
select
	s.seller_id
from sellers as s
left join 
	order_items as oi on
		oi.seller_id = s.seller_id
where
	oi.seller_id is NULL;

--22
select
	p.product_id
from products as p
left join
	order_items as oi on
		p.product_id = oi.product_id
where oi.product_id is NULL;
	
--23
select
	o.order_id
from 
	orders as o
left join
	order_reviews as r on
		o.order_id = r.order_id
where r.order_id is NULL;

--24
select
	o.order_id
from
	orders as o
left join order_payments as op on
	o.order_id = op.order_id
where op.order_id is NULL;

--25
select
	c.customer_id
from
	customers as c
left join
	orders as o on
		o.customer_id = c.customer_id
where
	o.order_id is NULL;

--26
select distinct
	s.seller_id
from sellers as s
inner join order_items as oi on
	oi.seller_id = s.seller_id;

--27
select distinct
	p.product_id
from products as p
inner join order_items as oi on
	oi.product_id = p.product_id
where
	p.product_category_name is not NULL 
	and
	product_photos_qty != 0
	and
	product_photos_qty is not NULL;

--28
select
	o.order_id,
	r.review_score
from orders as o
inner join order_reviews as r on
	o.order_id = r.order_id
where
	r.review_score = 1
	or
	r.review_score = 2;

--29 ???
select distinct
	s.seller_id,
	s.seller_state,
	oi.price
from sellers as s
left join order_items as oi on
	s.seller_id = oi.seller_id
	and
	oi.price > 500
where
	s.seller_state = 'SP'
	and
	oi.seller_id is NULL;

--30
select
	op.order_id,
	count(op.payment_sequential)
from order_payments as op
group by op.order_id
having count (op.payment_sequential) > 1;

--41
select 
	op.order_id,
	sum(op.payment_value)
from order_payments as op
group by op.order_id;


 
	


