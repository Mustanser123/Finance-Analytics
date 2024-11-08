/*Which channel helped to bring more gross sales in the fiscal year 2021 
and the percentage of contribution?  The final output  contains these fields, 
channel 
gross_sales_mln 
percentage */

WITH total_sales AS (
    SELECT 
        round(SUM(fsm.sold_quantity * fgp.gross_price/1000000),2) AS total_gross_sales
    FROM 
        fact_sales_monthly fsm
    JOIN 
        fact_gross_price fgp ON fsm.product_code = fgp.product_code
    WHERE 
        fsm.fiscal_year = 2021
),
channel_sales AS (
    SELECT 
        dc.channel,
        round(SUM(fsm.sold_quantity * fgp.gross_price/1000000),2) AS gross_sales_mln
    FROM 
        fact_sales_monthly fsm
    JOIN 
        fact_gross_price fgp ON fsm.product_code = fgp.product_code
    JOIN 
        dim_customer dc ON fsm.customer_code = dc.customer_code
    WHERE 
        fsm.fiscal_year = 2021
    GROUP BY 
        dc.channel
)
SELECT 
    cs.channel,
    cs.gross_sales_mln,
    round((cs.gross_sales_mln / ts.total_gross_sales) * 100,2) AS percentage
FROM 
    channel_sales cs
JOIN 
    total_sales ts ON 1 = 1
ORDER BY 
    cs.gross_sales_mln DESC;
