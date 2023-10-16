--bai1
SELECT 
SUM(CASE WHEN device_type='laptop' then 1 ELSE 0 end) as laptop_views,
SUM(CASE WHEN device_type IN ('phone','tablet') then 1 else 0 END) 
as mobile_views
FROM viewership
--bai2
SELECT *,
CASE WHEN x + y > z AND y + z > x AND z + x > y THEN 'Yes'
ELSE 'No' END AS triangle
FROM Triangle
--bai3
SELECT CAST(COUNT(CASE WHEN call_category = 'n/a' 
or call_category is NULL then 1 else 0 end)*100 /
COUNT(call_category) as decimal) as call_percentage
from callers
--bai4
select name from Customer
where (referee_id is NULL) or (referee_id != 2);
--bai5
select
case when survived=0 then 'non-survived'
 when survived=1 then 'survived' end as status,
sum(case when pclass=1 then passengerid end) as first_class,
sum(case when pclass=2 then passengerid end) as second_class,
sum(case when pclass=3 then passengerid end) as third_class
from titanic
group by survived
