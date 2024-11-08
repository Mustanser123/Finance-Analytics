
/* Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, 
product_code 
product 
manufacturing_cost */
with cte as (
SELECT fm.product_code, p.product, fm.manufacturing_cost 
from fact_manufacturing_cost fm 
join
dim_product p on p.product_code=fm.product_code)
select product_code, product, manufacturing_cost from cte
where 
manufacturing_cost=(select max(manufacturing_cost) from cte)
or 
manufacturing_cost=(select min(manufacturing_cost) from cte)
