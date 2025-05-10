-- Best seller products analysis based on total revenue (10 out of 77).
-- This query will contain analysis on best selling products of all time.
-- Best selling category types with their description.
-- Total revenue from each product.

SELECT TOP 10
P.ProductName AS PRODUCTS,
C.CategoryName AS CATEGORIES,
COUNT(OD.OrderID) AS ORDER_VOLUME,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL_REVENUE
FROM Products P
INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] AS OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductName, C.CategoryName
ORDER BY TOTAL_REVENUE DESC

-- Find insights on this query from insights folder.