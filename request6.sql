/*Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
customer_code 
customer 
average_discount_percentage */

with cte as (select dc.customer_code, dc.customer, avg(pd.pre_invoice_discount_pct) as average_discount_pct from dim_customer dc
join fact_pre_invoice_deductions pd on dc.customer_code=pd.customer_code where pd.fiscal_year= 2021 and dc.market="india"
group by dc.customer_code, dc.customer)
select customer_code, customer, average_discount_pct from cte order by average_discount_pct desc limit 5