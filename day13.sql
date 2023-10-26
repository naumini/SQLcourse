--bai1
WITH mt AS
(SELECT company_id, title, description,
COUNT(DISTINCT job_id) as jobid
FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(DISTINCT job_id)>1)
SELECT COUNT(DISTINCT company_id) as duplicate_companies from mt 
--b2
WITH bang1 AS
(SELECT category, product, total_spend from (SELECT category, product,
SUM(spend) as total_spend
FROM product_spend
WHERE EXTRACT('YEAR' FROM transaction_date) = '2022'
GROUP BY category, product 
ORDER BY category ASC, total_spend DESC ) as mt),
bang2 as (SELECT a.category, a.product, a.total_spend from bang1 as a 
WHERE a.category = 'appliance' LIMIT 2),
bang3 as (SELECT b.category, b.product, b.total_spend from bang1 as b 
WHERE b.category = 'electronics' LIMIT 2)
SELECT c.category, c.product, c.total_spend,
d.category, d.product, d.total_spend from bang2 as c
JOIN bang3 as d on c.category=d.category
--b3
SELECT COUNT(policy_holder_id) AS member_count FROM 
(SELECT policy_holder_id, COUNT(case_id) 
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >=3 ) as abc
--b4
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id
  FROM page_likes)
--b5
WITH abc as (
select user_id, EXTRACT(month from event_date) 
as Months from user_actions 
where event_type IN ('sign-in','like','comment')
GROUP BY user_id, Months),
def as (
SELECT a.user_id, b.Months from abc as a 
JOIN abc b on a.user_id=b.user_id
and b.Months=7 and a.Months=b.Months-1)
select Months, COUNT(user_id) as monthly_active_users from def 
GROUP BY Months
--b6
select Date_format(trans_date, '%Y-%m') AS month, country, 
count(id) as trans_count,
SUM(case WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(case WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
from Transactions
group by country, month
--b7
select product_id, min(year) as first_year, quantity, price from Sales
group by product_id
--b8
select distinct customer_id from Customer
group by customer_id
having count( distinct product_key) = (select count(*) FROM product)
--b9
select employee_id from Employees
where salary < 30000 and manager_id not in ( select employee_id from Employees )
--b10
WITH mt AS
(SELECT company_id, title, description,
COUNT(DISTINCT job_id) as jobid
FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(DISTINCT job_id)>1)
SELECT COUNT(DISTINCT company_id) as duplicate_companies from mt 
--b11
WITH bang1 as 
(SELECT a.name AS user_name, COUNT(*) AS counts FROM MovieRating AS b
    JOIN Users AS a
    on a.user_id = b.user_id
    GROUP BY b.user_id
    ORDER BY counts DESC, user_name ASC LIMIT 1),
bang2 as 
(SELECT c.title AS movie_name, AVG(d.rating) AS rate FROM MovieRating AS d
    JOIN Movies AS c
    on c.movie_id = d.movie_id
    WHERE substr(d.created_at, 1, 7) = '2020-02'
    GROUP BY d.movie_id
    ORDER BY rate DESC, movie_name ASC LIMIT 1)
select z.user_name, x.movie_name as results from bang1 as z
UNION bang2 as x on z.user_id=x.user_id
--b12
select id, count(*) as num from (
select requester_id as id from RequestAccepted
union all
select accepter_id from RequestAccepted
) as friends_count
group by id
order by num desc limit 1;
