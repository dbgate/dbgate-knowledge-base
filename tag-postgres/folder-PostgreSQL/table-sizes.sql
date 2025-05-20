-- @title: Table sizes
-- @description: Without system databases

WITH RECURSIVE pg_inherit(inhrelid, inhparent) AS
    (select inhrelid, inhparent
    FROM pg_inherits
    UNION
    SELECT child.inhrelid, parent.inhparent
    FROM pg_inherit child, pg_inherits parent
    WHERE child.inhparent = parent.inhrelid),
pg_inherit_short AS (SELECT * FROM pg_inherit WHERE inhparent NOT IN (SELECT inhrelid FROM pg_inherit))
SELECT TABLE_NAME
    , row_estimate
    , cast(total_bytes/1024/1024 as numeric(12,2)) AS total
    , cast(table_bytes/1024/1024 as numeric(12,2)) AS table
    , cast(toast_bytes/1024/1024 as numeric(12,2)) AS toast
    , cast(index_bytes/1024/1024 as numeric(12,2)) AS index
  FROM (
    SELECT *, total_bytes-index_bytes-COALESCE(toast_bytes,0) AS table_bytes
    FROM (
         SELECT c.oid
              , relname AS TABLE_NAME
              , SUM(c.reltuples) OVER (partition BY parent) AS row_estimate
              , SUM(pg_total_relation_size(c.oid)) OVER (partition BY parent) AS total_bytes
              , SUM(pg_indexes_size(c.oid)) OVER (partition BY parent) AS index_bytes
              , SUM(pg_total_relation_size(reltoastrelid)) OVER (partition BY parent) AS toast_bytes
              , parent
          FROM (
                SELECT pg_class.oid
                    , reltuples
                    , relname
                    , relnamespace
                    , pg_class.reltoastrelid
                    , COALESCE(inhparent, pg_class.oid) parent
                FROM pg_class
                    LEFT JOIN pg_inherit_short ON inhrelid = oid
                WHERE relkind IN ('r', 'p', 'm')
             ) c
             LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE nspname NOT IN ('pg_catalog','information_schema')
  ) a
  WHERE oid = parent
) a
ORDER BY total_bytes DESC;