/* -- In which quarter of 2020, got the maximum total_sold_quantity? The final 
output contains these fields sorted by the total_sold_quantity, 
Quarter 
total_sold_quantity */

SELECT 
    QUARTER(fsm.date) AS Quarter,
    SUM(fsm.sold_quantity) AS total_sold_quantity
FROM 
    fact_sales_monthly fsm
WHERE 
    YEAR(fsm.date) = 2020
GROUP BY 
    QUARTER(fsm.date)
ORDER BY 
    total_sold_quantity DESC;
