--bai1
SELECT COUNTRY.CONTINENT, ROUND(AVG(CITY.POPULATION),0) FROM COUNTRY
INNER JOIN CITY
on CITY.COUNTRYCODE=COUNTRY.CODE
group by COUNTRY.CONTINENT
--bai2
SELECT 
ROUND(SUM(CASE WHEN signup_action = 'Confirmed' then 1 else 0 end)*1.0/COUNT(*),2)
as confirm_rate 
FROM emails as e INNER join texts as t on e.email_id=t.email_id
--bai3
SELECT b.age_bucket,
CASE WHEN a.activity_type = 'send' then SUM(a.time_spent) END as send_time,
CASE WHEN a.activity_type = 'open' then SUM(a.time_spent) END as open_time,
SUM(a.time_spent) as total_time,
ROUND((CASE WHEN a.activity_type = 'send' then send_time END/total_time)*1.00,2) as send_perc,
ROUND((CASE WHEN a.activity_type = 'open' then open_time END/total_time)*1.00,2) as open_perc
FROM activities as a
JOIN age_breakdown as b on a.user_id=b.user_id
GROUP BY b.age_bucket, a.activity_type
--bai4
SELECT c.customer_id
FROM customer_contracts as c
LEFT JOIN products as p
ON c.product_id=p.product_id
GROUP BY customer_id
--bai5
select E.employee_id, E.name, count(E.reports_to) as reports_count,
round(avg(E.age)) as average_age
from Employees as E
LEFT JOIN Employees as EE ON E.reports_to=EE.employee_id
--bai6
select p.product_name, SUM(o.unit) AS unit 
from products as p
INNER JOIN Orders as o
ON p.product_id=o.product_id
WHERE month(o.order_date) =2 and year (o.order_date)=2020
Group by p.product_name
HAVING unit>=100
--bai7
SELECT p.page_id FROM pages as p
LEFT JOIN page_likes as pl 
ON p.page_id=pl.page_id
where pl.liked_date is NULL
ORDER BY p.page_id



  
 --MID TEST
--q1
select replacement_cost
from film
order by replacement_cost 
--q2
select 
case when replacement_cost between 9.99 and 19.99 then 'low'
 when replacement_cost between 20.00 and 24.99 then 'medium'
else 'high' end as level,
count(*) as so_luong
from film
group by level
--q3
select fc.film_id, fc.category_id, fm.title, fm.length  from film_category as fc
INNER JOIN film as fm on 
fm.film_id=fc.film_id
order by length desc
--q4
select cat.category_id, cat.name,
count(*) as so_luong
from category as cat
JOIN film_category as fc on
fc.category_id=cat.category_id
JOIN film as fm ON
fm.film_id=fc.film_id
group by cat.category_id, cat.name
order by so_luong desc
--q5
select a.first_name, a.last_name,
count(*) as sl_phim
from actor as a
JOIN film_actor as fa ON
a.actor_id=fa.actor_id
group by a.first_name, a.last_name
order by sl_phim desc
--q6
select ad.address from address as ad
LEFT JOIN customer as cm ON
cm.address_id=ad.address_id
WHERE cm.address_id is NULL  
--q7
select c.city,
count(pm.amount) as revenue from city as c
JOIN address as ad on c.city_id=ad.city_id
JOIN customer as cr on cr.address_id=ad.city_id
JOIN payment as pm on pm.customer_id=cr.customer_id
group by c.city
order by revenue desc
--q8
select c.city,
count(pm.amount) as revenue, ct.country from city as c
JOIN address as ad on c.city_id=ad.city_id
JOIN customer as cr on cr.address_id=ad.city_id
JOIN payment as pm on pm.customer_id=cr.customer_id
JOIN country as ct on c.country_id=ct.country_id
group by c.city, ct.country
order by revenue desc









