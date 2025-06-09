-- >>>
-- title: Top Tables by Used Space
-- selected-chart: 1
-- chart-1:
--   title: Top Tables by Used Space
--   chartType: pie
--   pieCountLimit: '5'
--   pieRatioLimit: '0'
--   dataLabelFormatter: size:kb
--   xdef:
--     field: ObjectName
--     transformFunction: identity
--   ydefs:
--     - aggregateFunction: sum
--       field: Used_Space_kb
--       title: Used Space Kb
-- autoExecute: true
-- splitterInitialValue: 20%
-- <<<

SELECT
  t.object_id,
  OBJECT_NAME(t.object_id) ObjectName,
  sum(u.total_pages) * 8 Total_Reserved_kb,
  sum(u.used_pages) * 8 Used_Space_kb,
  u.type_desc,
  max(p.rows) RowsCount
FROM
  sys.allocation_units u
  JOIN sys.partitions p on u.container_id = p.hobt_id
  JOIN sys.tables t on p.object_id = t.object_id
GROUP BY
  t.object_id,
  OBJECT_NAME(t.object_id),
  u.type_desc