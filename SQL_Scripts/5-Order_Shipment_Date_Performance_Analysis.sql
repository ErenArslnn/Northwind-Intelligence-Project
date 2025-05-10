-- Order shipment date performance analysis.

-- In this query, late shipments will be analyzed.

SELECT
CustomerID,
EmployeeID,
OrderDate,
RequiredDate,
ShippedDate,
CASE
	WHEN RequiredDate < ShippedDate THEN 'LATE'
	WHEN RequiredDate > ShippedDate THEN 'ONTIME'
	END AS DeliveryStatus,
S.CompanyName AS Shipper,
ShipVia,
ShipName,
ShipCountry 
FROM Orders O
INNER JOIN Shippers AS S ON S.ShipperID = O.ShipVia
WHERE RequiredDate < ShippedDate
ORDER BY ShipVia ASC, ShipCountry ASC

-- To have a performance point on each shipping company we can run the query below.

SELECT
    COUNT(CASE WHEN O.RequiredDate >= O.ShippedDate THEN 1 END) AS ONTIME_ORDER_COUNT,
    COUNT(CASE WHEN O.RequiredDate < O.ShippedDate THEN 1 END) AS LATE_ORDER_COUNT,
    S.CompanyName AS Shipper,
    ShipVia,
    -- Performance: ONTIME / (ONTIME + LATE) as a percentage
    (COUNT(CASE WHEN O.RequiredDate >= O.ShippedDate THEN 1 END) * 100.0)
    / (COUNT(*) * 1.0) AS PERFORMANCE
FROM Orders O
INNER JOIN Shippers AS S ON S.ShipperID = O.ShipVia
WHERE O.ShippedDate IS NOT NULL
GROUP BY O.ShipVia, S.CompanyName
ORDER BY ShipVia ASC;

-- See insights on this query in insights folder

