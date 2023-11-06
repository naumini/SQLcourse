--q1
Alter table sales_dataset_rfm_prj 
ALTER COLUMN ordernumber type numeric using (trim(ordernumber)::numeric),
ALTER COLUMN quantityordered type numeric using (trim(quantityordered)::numeric),
ALTER COLUMN priceeach type numeric using (trim(priceeach)::numeric),
ALTER COLUMN sales type numeric using (trim(sales)::numeric),
Alter column orderdate type timestamp without time zone USING orderdate::timestamp without time zone,
Alter column productcode type varchar,
Alter column status type text,
Alter column productline type text, 
Alter column msrp type numeric using (trim(msrp)::numeric),
Alter column productcode type varchar,
Alter column customername type text,
Alter column phone type varchar,
ALTER COLUMN city TYPE text,
Alter column state type text,
Alter column postalcode type varchar,
Alter column country type text,
Alter column territory type text, 
Alter column contactfullname type varchar,
Alter column dealsize type text

--q2
select * from public.sales_dataset_rfm_prj
where ordernumber is NULL or ordernumber = ''
select * from public.sales_dataset_rfm_prj
where quantityordered is NULL or quantityordered = ''
select * from public.sales_dataset_rfm_prj
where priceeach is NULL or priceeach = ''
select * from public.sales_dataset_rfm_prj
where orderlinenumber is NULL or orderlinenumber = ''
select * from public.sales_dataset_rfm_prj
where sales is NULL or sales = ''
select * from public.sales_dataset_rfm_prj
where orderdate is NULL or orderdate = ''
  
--q3
Alter table sales_dataset_rfm_prj
Add column contactlastname VARCHAR (100),
Add column contactfirstname VARCHAR (100)
UPDATE sales_dataset_rfm_prj 
SET contactlastname = UPPER(substring(contactfullname,POSITION('-' IN contactfullname)+1,1))||
LOWER(SUBSTRING(contactfullname,POSITION('-' IN contactfullname)+2))
UPDATE sales_dataset_rfm_prj
SET contactfirstname = UPPER(LEFT(contactfullname,1))||
LOWER(SUBSTRING(contactfullname,2,POSITION('-' IN contactfullname)-2))
--q4
Alter table sales_dataset_rfm_prj
ADD COLUMN QTR_ID VARCHAR ,
ADD COLUMN MONTH_ID VARCHAR,
ADD COLUMN YEAR_ID VARCHAR
Update sales_dataset_rfm_prj 
SET QTR_ID = extract (quarter from new_orderdate)
Update sales_dataset_rfm_prj 
SET MONTH_ID = EXTRACT (MONTH from new_orderdate)
Update sales_dataset_rfm_prj 
SET YEAR_ID = EXTRACT (YEAR FROM new_orderdate)
--q5
*cach 1
with bang1 as(
select Q1-1.5*IQR as minv, Q3+1.5*IQR as maxv from (
select 
percentile_cont (0.25) within group (order by quantityordered) as Q1,
percentile_cont (0.75) within group (order by quantityordered) as Q3,
percentile_cont (0.75) within group (order by quantityordered) - percentile_cont (0.25) within group (order by quantityordered) 
as IQR from sales_dataset_rfm_prj ) as a)
select * from sales_dataset_rfm_prj 
where quantityordered < (select minv from bang1) or quantityordered > (select maxv from bang1)

 *cach2
with bang2 as (
select quantityordered,
(select avg(quantityordered) from sales_dataset_rfm_prj)  as avg,
(select stddev(quantityordered) from sales_dataset_rfm_prj) as stddev from sales_dataset_rfm_prj)

select quantityordered, (quantityordered-avg)/stddev as zscore from bang2
where abs(zscore)>3

--q6


