-- >>>
-- title: Running queries
-- autoExecute: true
-- splitterInitialValue: 20%
-- description: Queries that are currently running, excluding idle ones
-- <<<

SELECT pid, age(clock_timestamp(), query_start), datname, usename, query, state
FROM pg_stat_activity
WHERE state NOT LIKE 'idle%' AND query NOT ILIKE '%pg_stat_activity%'
ORDER BY query_start desc;
