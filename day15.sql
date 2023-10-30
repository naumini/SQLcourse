--b1
SELECT year, product_id, curr_year_spend, prev_year_spend,
ROUND((curr_year_spend/prev_year_spend-1)*100.0,2) as yoy_rate 
FROM
(SELECT EXTRACT(year from transaction_date) as year,
product_id, spend as curr_year_spend,
LAG(spend) OVER(PARTITION BY product_id ORDER BY product_id) as prev_year_spend
FROM user_transactions) as b1;
--b2 (chi sua giup em cau nay nhe)
with c1 AS
(select card_name, FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name)  
FROM monthly_cards_issued
where card_name = 'Chase Sapphire Reserve'),
c2 as 
(select card_name, FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name) FROM monthly_cards_issued
where card_name = 'Chase Freedom Flex')
select a.card_name, a.issued_amount, b.card_name, b.issued_amount
from monthly_cards_issued as a 
JOIN monthly_cards_issued As b ON a.card_name=b.card_name
--b3
with bang1 as
(select *, rank() over (partition by user_id order by transaction_date) as rank 
from transactions)
select user_id, spend, transaction_date from bang1 where rank=3
--b4
with bang1 as
(select user_id,transaction_date,count(product_id) as purchase_count,
rank() over (partition by user_id order by transaction_date ) as rank
from user_transactions
group by user_id,transaction_date)
select transaction_date,user_id,purchase_count from bang1 where rank=1
order by transaction_date
--b5
--b6
WITH bang1 AS
(SELECT merchant_id, 
EXTRACT(epoch from transaction_timestamp-
LAG(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount
ORDER BY transaction_timestamp))/60 as diff
FROM transactions)
SELECT COUNT(merchant_id) as payment_count from 
bang1
where diff<=10
--b7
WITH bang1 AS
(SELECT category, product, sum(spend) as total_spend
from product_spend
where extract(year from transaction_date)=2022
GROUP BY category, product),
bang2 AS 
(SELECT *, ROW_NUMBER() OVER(PARTITION BY category
ORDER BY total_spend DESC) as rank from bang1)
select category, product, total_spend
from bang2
where rank <3
--b8
bai 8 em chua lam kip nha c Julie oi, de mai em lam tiep :>>
