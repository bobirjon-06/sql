WITH factorials AS (
  SELECT 1 AS Num, 1 AS Factorial
  UNION ALL
  SELECT Num + 1, Factorial * (Num + 1)
  FROM factorials
  WHERE Num < 10
)
SELECT *
FROM factorials
OPTION (MAXRECURSION 10);
