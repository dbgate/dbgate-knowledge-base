-- @title: All elements sizes
-- @description: Tables, indexes, views, sequences,... in a simple list
-- @folder: PostgreSQL

select
relkind as type,
relname as name,
(pg_relation_size(pg_catalog.pg_class.oid)/1024/1024) as size,
reltuples as rows
from pg_catalog.pg_class
join pg_catalog.pg_namespace on relnamespace = pg_catalog.pg_namespace.oid
where pg_catalog.pg_namespace.nspname not in ('pg_catalog','pg_toast','information_schema')
order by relkind desc, relname desc;
