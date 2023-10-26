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
--b6
--b7
--b8
--b9
--b10
--b11
--b12
