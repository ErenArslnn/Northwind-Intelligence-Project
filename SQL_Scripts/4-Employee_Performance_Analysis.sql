-- Employee performance analysis.

-- This query will analyze employee performance based on total order count,
-- total revenue contribution,
-- Hiring date will affect overall evaluation.

SELECT 
E.FirstName AS EMPLOYEE,
E.HireDate,
DATEDIFF(MONTH, E.HireDate, '1998-05-06') AS EXPERIENCE,
COUNT(O.EmployeeID) AS ORDER_COUNT,
COUNT(O.EmployeeID) / NULLIF(DATEDIFF(MONTH, E.HireDate, '1998-05-06'),0) AS MONTHLY_ORDER_AVG,

-- Monthly revenue avg would also tell us which employee has the highest score.
-- Performance analysis should be done with ordering this query by monthly revenue average.

(SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)))
/
(NULLIF(DATEDIFF(MONTH, E.HireDate, '1998-05-06'),0)) AS MONTHLY_REVENUE_AVG,

SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL_REVENUE

FROM Employees E
INNER JOIN Orders AS O ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
INNER JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY E.FirstName,E.HireDate, DATEDIFF(MONTH, E.HireDate, '1998-05-06')
ORDER BY MONTHLY_REVENUE_AVG DESC

-- See insights on this query in insights folder.