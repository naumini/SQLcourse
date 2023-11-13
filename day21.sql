I.
1. Số lượng đơn hàng và số lượng khách hàng mỗi tháng
SELECT
  extract(year from created_at)|| '-' || extract (month from created_at)  as month_year,
  COUNT(DISTINCT user_id) as total_user,
  COUNT(order_id) as total_order
 FROM bigquery-public-data.thelook_ecommerce.orders
 WHERE created_at BETWEEN '2019-01-01' AND '2022-04-30'
 AND status = 'Complete'
 GROUP BY 1
 ORDER BY 1 ASC
2.Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
SELECT 
 extract(year from created_at)|| '-' || extract (month from created_at)  AS month_year,
COUNT(DISTINCT a.user_id) AS distinct_users,
ROUND(SUM(sale_price)/ COUNT(DISTINCT a.order_id),2) AS average_order_value
FROM bigquery-public-data.thelook_ecommerce.order_items AS a
INNER JOIN bigquery-public-data.thelook_ecommerce.orders AS b
ON a.order_id = b.order_id
WHERE (a.created_at) BETWEEN '2019-01-01' AND '2022-04-30'
AND a.status = 'Complete'
GROUP BY month_year
ORDER BY month_year
3. Nhóm khách hàng theo độ tuổi
SELECT
first_name,
last_name,
gender,
MIN(age) OVER(PARTITION BY gender) AS youngest_age
FROM bigquery-public-data.thelook_ecommerce.users 
WHERE created_at BETWEEN '2019-01-01' AND '2022-04-30'
AND age IN (SELECT MIN(age) 
FROM bigquery-public-data.thelook_ecommerce.users)
UNION ALL
SELECT
first_name,
last_name,
gender,
MAX(age) OVER(PARTITION BY gender) AS oldest_age
FROM bigquery-public-data.thelook_ecommerce.users 
WHERE created_at BETWEEN '2019-01-01' AND '2022-04-30'
AND age IN (SELECT MAX(age) 
FROM bigquery-public-data.thelook_ecommerce.users)
ORDER BY youngest_age
4. Top 5 sản phẩm mỗi tháng.
WITH bang1 as (
SELECT DISTINCT a.product_id, product_name, 
extract(year from created_at)|| '-' || extract (month from created_at)  AS month_year, 
ROUND(SUM(sale_price),2) AS sales,
ROUND(SUM(cost),2) AS cost,
ROUND((SUM(sale_price) - SUM(cost)),2) AS profit
FROM bigquery-public-data.thelook_ecommerce.order_items AS a
JOIN bigquery-public-data.thelook_ecommerce.inventory_items AS b
ON a.product_id = b.product_id
WHERE (a.created_at) BETWEEN '2019-01-01'AND '2022-04-30'
AND a.status= 'Complete'
GROUP BY 1,2,3
ORDER BY month),
ranks as
(SELECT month,product_id,product_name,sales,cost,profit,
RANK() OVER (PARTITION BY month ORDER BY profit DESC) AS rank_per_month
FROM bang1
ORDER BY bang1.month)
SELECT ranks.*
FROM ranks
WHERE rank_per_month <=5
5. Doanh thu tính đến thời điểm hiện tại trên mỗi danh mục
WITH bang1 as 
(SELECT 
DISTINCT category AS product_categories,
DATE_TRUNC(DATE(a.created_at),day) AS dates, 
DATE_TRUNC(DATE(a.created_at),month) AS month, 
ROUND(SUM(sale_price),2) AS revenue
FROM bigquery-public-data.thelook_ecommerce.order_items AS a
JOIN bigquery-public-data.thelook_ecommerce.products as b
ON a.product_id= b.id
WHERE DATE(a.created_at) BETWEEN '2022-01-15'AND '2022-04-15'
AND a.status = 'Complete'
GROUP BY 1,2,3),
revenues as
(SELECT 
dates,
product_categories,
revenue,
SUM(revenue) OVER (PARTITION BY product_categories, month ORDER BY dates) AS running_total_revenue
FROM bang1
ORDER BY dates DESC)
SELECT
dates,
product_categories,
revenue,
ROUND(running_total_revenue,2) AS running_total_revenue
FROM revenues
ORDER BY 2, dates desc
