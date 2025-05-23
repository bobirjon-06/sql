DECLARE @Year INT = 2025;
DECLARE @Month INT = 3;
;WITH Dates AS (
    SELECT CAST(DATEFROMPARTS(@Year, @Month, 1) AS DATE) AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM Dates
    WHERE MONTH(DateValue) = @Month
),
CalendarCTE AS (
    SELECT 
        DateValue,
        DATEPART(WEEK, DateValue) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1 AS WeekNum,
        DATEPART(WEEKDAY, DateValue) AS WeekDayNum
    FROM Dates
)
SELECT 
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 1 THEN DAY(DateValue) END) AS Sunday,
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 2 THEN DAY(DateValue) END) AS Monday,
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 3 THEN DAY(DateValue) END) AS Tuesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 4 THEN DAY(DateValue) END) AS Wednesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 5 THEN DAY(DateValue) END) AS Thursday,
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 6 THEN DAY(DateValue) END) AS Friday,
    MAX(CASE WHEN DATEPART(WEEKDAY, DateValue) = 7 THEN DAY(DateValue) END) AS Satirday
FROM CalendarCTE
GROUP BY WeekNum
ORDER BY WeekNum
OPTION (MAXRECURSION 1000);
