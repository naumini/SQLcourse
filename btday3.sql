--bai1
select NAME from CITY 
where COUNTRYCODE = 'USA' 
and POPULATION > 120000;
--bai2
select * from CITY
where COUNTRYCODE ='JPN';
--bai3
select CITY, STATE from STATION;
--bai4
select DISTINCT CITY from STATION
where CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%';
--bai5
select Distinct CITY from STATION
where CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%I' OR CITY LIKE '%O' OR CITY LIKE '%U';
--bai6
select distinct CITY from STATION 
where CITY Not like 'A%' and CITY Not like 'E%' and CITY Not like 'I%' and CITY Not like 'O%' and CITY not like 'U%';
--bai7
select name from Employee
order by name;
--bai8
select distinct author_id from Views
where author_id = viewer_id
order by author_id ASC  
--bai9
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y';
--bai10
select name from Customer
where (referee_id is NULL) or (referee_id != 2);
--bai11
select name, population, area from World
where area >= 3000000 or population >= 25000000;
--bai12
select distinct author_id as id from Views
where author_id = viewer_id
order by author_id ASC ;
--bai13
SELECT * FROM parts_assembly
WHERE finish_date is NULL
--bai14
select * from lyft_drivers
where yearly_salary <= 30000 or yearly_salary >= 70000
--bai15
select * from uber_advertising
where money_spent > 100000;

