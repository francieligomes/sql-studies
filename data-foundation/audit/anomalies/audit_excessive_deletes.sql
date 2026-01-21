-- ============================================
-- AUDIT QUERY: Excessive Deletes by User
-- PURPOSE:
--   Detects users who performed a higher-than-average number
--   of delete operations.
--
-- TABLE:
--   - audit_log
--
-- NOTES:
--   - Helps identify risky or abnormal delete behavior
-- ============================================
SELECT
    changed_by,
    COUNT(*) AS total_deletes
FROM 
    audit_log 
WHERE 
    operation_type = 'DELETE'
GROUP BY changed_by
HAVING COUNT(*) > (
            SELECT
                AVG(total_deletes)
            FROM (
                SELECT
                    COUNT(*) AS total_deletes
                FROM 
                    audit_Log
                WHERE 
                    operation_type = 'DELETE'
                GROUP BY changed_by
            ) AS deletes
);
