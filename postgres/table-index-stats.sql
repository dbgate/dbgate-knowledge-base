-- @title: Table index stats
-- @folder: PostgreSQL

SELECT
relname AS "table name",
n_live_tup AS "table rows",
100 * idx_scan / (seq_scan + idx_scan) AS "indexes usage [%]"
FROM pg_stat_user_tables 
ORDER BY n_live_tup DESC;
