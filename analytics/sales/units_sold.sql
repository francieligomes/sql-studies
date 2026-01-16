-- ============================================
-- METRIC: Units Sold by Book
-- GRAIN: Book
-- DESCRIPTION:
--   Calculates the total number of units sold
--   per book, considering only completed or
--   billable orders.
--
-- TABLES:
--   - book
--   - orders
--   - order_item
--
-- STATUS LOGIC:
--   Paid, Shipped, Delivered, Completed
--
-- NOTES:
--   Useful for identifying best-selling books
--   and supporting ranking or performance analysis.
-- ============================================
SELECT
    title,
    SUM(quantity) AS units_sold
FROM
   book b
JOIN 
    order_item oi ON b.book_id = oi.book_id_fk
JOIN
    orders o ON oi.order_id_fk = o.order_id
WHERE 
    o.order_status IN ('Paid', 'Shipped', 'Delivered', 'Completed')
GROUP BY b.book_id, b.title
ORDER BY units_sold;
