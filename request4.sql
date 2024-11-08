/* Follow-up: Which segment had the most increase in unique products in 
2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference */

WITH product_count_by_year AS (
    SELECT 
        segment,
        fiscal_year,
        COUNT(DISTINCT fgp.product_code) AS product_count
    FROM 
        dim_product dp
    JOIN 
        fact_gross_price fgp ON dp.product_code = fgp.product_code
    WHERE 
        fiscal_year IN (2020, 2021)
    GROUP BY 
        segment, fiscal_year
),
product_comparison AS (
    SELECT 
        p1.segment,
        p1.product_count AS product_count_2020,
        p2.product_count AS product_count_2021,
        (p2.product_count - p1.product_count) AS difference
    FROM 
        product_count_by_year p1
    JOIN 
        product_count_by_year p2 
    ON 
        p1.segment = p2.segment AND p1.fiscal_year = 2020 AND p2.fiscal_year = 2021
)
SELECT 
    segment,
    product_count_2020,
    product_count_2021,
    difference
FROM 
    product_comparison
ORDER BY 
    difference DESC;
