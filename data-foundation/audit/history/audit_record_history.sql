-- ============================================
-- AUDIT QUERY: Record Change History
-- PURPOSE:
--   Retrieves the full audit history of a specific record,
--   showing all changes over time.
--
-- TABLE:
--   - audit_log
--
-- NOTES:
--   - Filtered by table name and primary key
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
    table_name = 'book'
    AND record_primary_key = 1
ORDER BY changed_at DESC;
