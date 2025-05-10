-- Monthly sales analysis.
-- This analysis will contain analysis for total revenue for each month and order count.

SELECT 
O.MonthName_ AS MONTH_,

--Orders table hold data between 07-1996 to 05-1998 checking each year would be beneficial.

DATEPART(YEAR,O.OrderDate) AS YEAR_,

-- Orders table holds distinct order entries only. To have unbiased analysis we need order volume.

COUNT(DISTINCT(O.OrderID)) AS ORDER_COUNT,
COUNT(OD.OrderID) AS ORDER_VOLUME,
SUM((OD.Quantity * OD.UnitPrice) - (OD.Quantity * OD.UnitPrice) * OD.Discount) AS TOTAL_REVENUE
FROM Orders O
INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
GROUP BY O.MonthName_, DATEPART(YEAR,O.OrderDate)
ORDER BY ORDER_VOLUME DESC, ORDER_COUNT DESC, YEAR_ DESC

--Run query below for more general analysis.

--Exclue analysis based on years.

SELECT 
O.MonthName_ AS MONTH_,
COUNT(DISTINCT(O.OrderID)) AS ORDER_COUNT,
COUNT(OD.OrderID) AS ORDER_VOLUME,
SUM((OD.Quantity * OD.UnitPrice) - (OD.Quantity * OD.UnitPrice) * OD.Discount) AS TOTAL_REVENUE
FROM Orders O
INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
GROUP BY O.MonthName_
ORDER BY ORDER_VOLUME DESC, ORDER_COUNT DESC

--Find insights on this query in insights folder.


