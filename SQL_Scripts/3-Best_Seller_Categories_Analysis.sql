-- Best seller categories analysis.
-- This query will contain analysis on best selling categories of all time.
-- Total revenue from each category type.

SELECT
C.CategoryName AS CATEGORIES,
COUNT(OD.OrderID) AS ORDER_VOLUME,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL_REVENUE
FROM Products P
INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] AS OD ON OD.ProductID = P.ProductID
GROUP BY C.CategoryName
ORDER BY TOTAL_REVENUE DESC

-- Find insights on this query in insights folder.