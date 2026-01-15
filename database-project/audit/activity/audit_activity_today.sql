-- ============================================
-- AUDIT QUERY: Audit Activity Today
-- PURPOSE:
--   Retrieves all audit events executed on the current date,
--   allowing visibility into recent data changes.
--
-- TABLE:
--   - audit_log
--
-- NOTES:
--   - Query may return no rows if no changes occurred today
-- ============================================
SELECT
    audit_id,
    table_name,
    operation_type,
    record_primary_key,
    old_data,
    new_data,
    changed_by,
    changed_at
FROM 
    audit_log
WHERE 
    DATE(changed_at) = CURRENT_DATE;

