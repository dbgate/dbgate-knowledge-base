-- @title: Heap stats
-- @folder: PostgreSQL

SELECT
SUM(heap_blks_read) AS heap_read,
SUM(heap_blks_hit) AS heap_hit,
(SUM(heap_blks_hit) - SUM(heap_blks_read)) / SUM(heap_blks_hit) AS ratio
FROM pg_statio_user_tables;
