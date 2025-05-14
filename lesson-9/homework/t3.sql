WITH Fibonacci (position, value, nextValue) AS (
    SELECT 1, 1, 1
    UNION ALL
    SELECT position + 1, nextValue, value + nextValue
    FROM Fibonacci
    WHERE position < 10
)
SELECT position, value
FROM Fibonacci;
