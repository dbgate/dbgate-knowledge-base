-- @title: Index usage stats
-- @description: Indexes with idx_* = 0 may be useless

SELECT
relname AS table_name,
indexrelname AS index_name,
idx_scan,
idx_tup_read,
idx_tup_fetch,
((pg_relation_size(indexrelname::regclass))/1024/1024) AS size
FROM pg_stat_all_indexes
WHERE schemaname = 'public'
ORDER BY idx_scan DESC;
