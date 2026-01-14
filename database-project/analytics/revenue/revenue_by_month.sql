-- ============================================
-- METRIC: Revenue
-- GRAIN: Year, Month
-- DESCRIPTION:
--   Calculates total revenue aggregated by year and month,
--   considering only completed or billable orders.
--
-- TABLES:
--   - orders
--   - order_item
--
-- STATUS LOGIC:
--   Paid, Shipped, Delivered, Completed
-- ============================================
SELECT
    YEAR(order_date) AS year_of_order,
    MONTH(order_date) AS month_of_order,
    SUM(quantity * unit_price) AS revenue
FROM 
    orders o
JOIN 
    order_item oi ON o.order_id = oi.order_id_fk
WHERE
    o.order_status IN ('Paid', 'Shipped', 'Delivered', 'Completed') 
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year_of_order, month_of_order;
