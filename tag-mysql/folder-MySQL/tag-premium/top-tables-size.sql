-- >>>
-- title: Top Tables by size
-- icon: img-chart
-- chart-1:
--   title: Table sizes
--   chartType: pie
--   xdef:
--     field: Table
--     transformFunction: identity
--   ydefs:
--     - field: Size (KB)
--       aggregateFunction: sum
--       title: Size (KB)
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