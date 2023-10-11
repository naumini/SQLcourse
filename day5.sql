--CAU1
select DISTINCT CITY from STATION
WHERE ID%2=0
--CAU2
select COUNT(CITY)-COUNT(DISTINCT CITY) FROM STATION 
--CAU3
SELECT
CEILING(AVG(Salary)-AVG(Salary*10))
FROM  EMPLOYEES
--CAU4
SELECT 
SUM(item_count * order_occurrences) as total_items,
SUM(order_occurrences) as total_orders, 
ROUND(CAST(SUM(item_count * order_occurrences) / SUM(order_occurrences) AS DECIMAL),1) mean
FROM items_per_order
--CAU5
SELECT candidate_id FROM candidates 
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
having COUNT (skill)=3
ORDER BY candidate_id ASC
--CAU6
SELECT user_id,
DATE(MAX(post_date))-DATE(MIN(post_date)) as day
FROM posts
WHERE post_date BETWEEN ('01/01/2021') AND ('01/01/2022')
GROUP BY user_id
--CAU7
SELECT card_name,
(MAX(issued_amount)-MIN(issued_amount)) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC
--CAU8
SELECT manufacturer,
COUNT (drug) as drug_count,
ABS(SUM(cogs-total_sales)) as total_loss
from pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
--CAU9
select * from Cinema
WHERE id%2= 1 and description <> 'boring'
ORDER BY rating DESC
--CAU10
select teacher_id, 
count(distinct subject_id) as cnt
from Teacher
group by teacher_id
--CAU11
select user_id, 
count(follower_id ) as followers_count
from Followers
group by user_id  
ORDER BY user_id ASC
--CAU12
SELECT class from Courses
HAVING COUNT(student)>=5

