-- ============================================================
-- METRIC: Revenue
-- GRAIN: Year, Month, Category
-- DESCRIPTION:
--   Calculates total monthly revenue by product category.
--   Revenue is computed as the sum of quantity multiplied
--   by unit price, considering only billable orders.
--
-- TABLES:
--   - orders
--   - order_item
--   - book
--   - category_book
--   - category
--
-- STATUS LOGIC:
--   Paid, Shipped, Delivered, Completed
--
-- NOTES:
--   - Time grain is derived from order_date.
--   - Category is resolved via the category_book bridge table.
-- ============================================================
SELECT
    YEAR(o.order_date) AS year_of_order,
    MONTH(o.order_date) AS month_of_order,
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM 
    orders o 
JOIN
    order_item oi ON o.order_id = oi.order_id_fk
JOIN 
    book b ON oi.book_id_fk = b.book_id
JOIN 
    category_book cb ON b.book_id = cb.book_id
JOIN 
    category c ON cb.category_id = c.category_id
WHERE
    o.order_status IN ('Paid', 'Shipped', 'Delivered', 'Completed') 
GROUP BY YEAR(o.order_date), MONTH(o.order_date), c.category_id, c.category_name
ORDER BY YEAR(o.order_date), MONTH(o.order_date), c.category_name; 
