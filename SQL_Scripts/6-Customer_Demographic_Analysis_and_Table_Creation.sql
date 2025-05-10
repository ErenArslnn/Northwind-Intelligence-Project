-- Customer demographic analysis table creation
-- In this query customer demographic analysis setup will be created,
-- The analysis in hand will be pushed to another table using select into method.

SELECT 
O.CustomerID AS CUSTOMERID,
O.ShipCountry AS SHIPCOUNTRY,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL_REVENUE,
COUNT(O.CustomerID) AS ORDER_COUNT,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount))
/
COUNT(O.CustomerID) AS SUM_PER_MONTH
FROM Orders O
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY O.CustomerID, O.ShipCountry
ORDER BY SUM_PER_MONTH DESC


-- Classifying our sales in %33 partitions would help us to divide our customers to have a heathy demographic.

WITH CUSTOMER_REVENUE AS (SELECT 
O.CustomerID AS CUSTOMER_ID,
O.ShipCountry AS COUNTRY,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL_REVENUE,
COUNT(O.CustomerID) AS ORDER_COUNT,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount))
/
COUNT(O.CustomerID) AS SUM_PER_MONTH
FROM Orders O
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY O.CustomerID, O.ShipCountry)


SELECT
CUSTOMER_ID,
COUNTRY,
TOTAL_REVENUE,
ORDER_COUNT,
SUM_PER_MONTH,
NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC) AS CUSTOMER_SEGMENT,
CASE 
	WHEN(NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC)) = 1 THEN 'HIGH_REVENUE'
	WHEN(NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC)) = 2 THEN 'MEDIUM_REVENUE'
	WHEN(NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC)) = 3 THEN 'LOW_REVENUE'
END AS CUSTOMER_DESCRIPTION
FROM CUSTOMER_REVENUE
ORDER BY CUSTOMER_SEGMENT, TOTAL_REVENUE DESC;

-- Let's create a table to store our demographic analysis. 

WITH CUSTOMER_REVENUE AS (SELECT 
O.CustomerID AS CUSTOMER_ID,
O.ShipCountry AS COUNTRY,
SUM((OD.Quantity * OD.UnitPrice) - ((OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL_REVENUE
FROM Orders O
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY O.CustomerID, O.ShipCountry)

SELECT
CUSTOMER_ID,
COUNTRY,
TOTAL_REVENUE,
NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC) AS CUSTOMER_SEGMENT,
CASE 
	WHEN(NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC)) = 1 THEN 'HIGH_REVENUE'
	WHEN(NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC)) = 2 THEN 'MEDIUM_REVENUE'
	WHEN(NTILE(3) OVER (ORDER BY TOTAL_REVENUE DESC)) = 3 THEN 'LOW_REVENUE'
END AS CUSTOMER_DESCRIPTION
INTO CustomerDemographic
FROM CUSTOMER_REVENUE
ORDER BY CUSTOMER_SEGMENT, TOTAL_REVENUE DESC;
