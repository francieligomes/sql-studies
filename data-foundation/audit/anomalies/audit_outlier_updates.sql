-- ============================================
-- AUDIT QUERY: Update Outliers by Record
-- PURPOSE:
--   Identifies records that received an unusually high number
--   of update operations compared to the average.
--
-- TABLE:
--   - audit_log
--
-- NOTES:
--   - Useful for detecting suspicious or excessive updates
-- ============================================
SELECT 
    al.table_name
FROM 
    audit_log al
WHERE 
    al.audit_id IN (
    SELECT
        audit_id
    FROM 
        audit_log
    GROUP BY audit_id
    HAVING COUNT(*) > (
        SELECT 
            AVG(amount_update)
        FROM (
            SELECT
                COUNT(*) AS amount_update
            FROM 
                audit_log
            GROUP BY audit_id
        ) AS amount
    )
);
