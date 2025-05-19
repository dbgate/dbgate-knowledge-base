-- @title: Database Sizes
-- @description: Without system databases
-- @folder: PostgreSQL

select
datname as database,
(pg_database_size(datname)/1024/1024) as size
from pg_database
where datname not in ('postgres','template0','template1')
order by pg_database_size(datname) desc;
