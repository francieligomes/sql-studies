-- ============================================
-- METRIC: Revenue Month-over-Month Growth
-- GRAIN: Month
-- DESCRIPTION:
--   Calculates Month-over-Month (MoM) revenue growth
--   based on total monthly revenue.
--
-- TABLES:
--   - orders
--   - order_item
--
-- BUSINESS LOGIC:
--   Revenue is calculated as quantity * unit_price.
--   MoM Growth (%) is calculated as:
--   ((current_month_revenue - previous_month_revenue)
--    / previous_month_revenue) * 100
--
-- STATUS LOGIC:
--   Paid, Shipped, Delivered, Completed
-- ============================================
WITH mensal_sales AS (
    SELECT 
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM 
        orders o
    JOIN 
        order_item oi ON o.order_id = oi.order_id_fk
    GROUP BY 1
),
mom_calc AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_revenue
    FROM 
        mensal_sales
)
SELECT
    month,
    revenue,
    previous_revenue,
    ROUND(
        ((revenue - previous_revenue) / NULLIF(previous_revenue, 0)) * 100,
        2
    ) AS percentage_growth
FROM 
    mom_calc
ORDER BY month;
