/* Get the Top 3 products in each division that have a high 
total_sold_quantity in the fiscal_year 2021? The final output contains these 
fields, 
division 
product_code */

WITH ranked_products AS (
    SELECT 
        dp.division,
        fsm.product_code,
        SUM(fsm.sold_quantity) AS total_sold_quantity,
        ROW_NUMBER() OVER (PARTITION BY dp.division ORDER BY SUM(fsm.sold_quantity) DESC) AS rnk
    FROM 
        fact_sales_monthly fsm
    JOIN 
        dim_product dp ON fsm.product_code = dp.product_code
    WHERE 
        fsm.fiscal_year = 2021
    GROUP BY 
        dp.division, fsm.product_code
)
SELECT 
    division,
    product_code
FROM 
    ranked_products
WHERE 
    rnk <= 3
ORDER BY 
    division, rnk;
