-- >>>
-- title: Top Tables by row count
-- chart-1:
--   title: Table row counts
--   chartType: pie
--   xdef:
--     field: Table
--     transformFunction: identity
--   ydefs:
--     - field: TABLE_ROWS
--       aggregateFunction: sum
--       title: TABLE ROWS
-- selected-chart: 1
-- autoExecute: true
-- splitterInitialValue: 20%
-- <<<
SELECT
  TABLE_NAME AS `Table`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024) AS `Size (KB)`,
  TABLE_ROWS
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = DATABASE()
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC;