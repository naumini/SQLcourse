--bai1
select Name from STUDENTS 
WHERE Marks >75
order by RIGHT(Name,3), ID ASC 
--bai2
select
lower(LEFT (name,1)) || upper(substring(name,2)) as full_name
from Users
order by user_id
--bai3
SELECT DISTINCT manufacturer,
'$' || ROUND(SUM(total_sales)/1000000,0) || ' ' || 'milion' as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY sale DESC, manufacturer 
--bai4
SELECT EXTRACT(month from submit_date) as mth,
product_id as product,
ROUND(AVG(stars),2) as avg_stars 
FROM reviews
GROUP BY mth, product
ORDER BY mth, product 
--bai5
SELECT DISTINCT sender_id,
COUNT(sender_id) as message_count
FROM messages
WHERE EXTRACT(year from sent_date)=2022 AND EXTRACT(month from sent_date)=8
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2
--bai6
select tweet_id
from Tweets
where length(content)>15
--bai7
select 
activity_date as day, count(distinct user_id) as active_users
from Activity
where activity_date between "2019-06-28" and "2019-07-27"
group by activity_date
--bai8
select joining_date,  
count(id) as employess_hired
from employees
group by count(id)
where joining_date "2022-01-01" BETWEEN "2022-08-01"
--bai9
select
position('a' in first_name)
from worker
where first_name= 'Amitah'
--bai10


