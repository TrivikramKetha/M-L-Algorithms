select * from product

select * from customer limit 10;

select * from person

select * from salesorderdetail

select * from productcategory

select * from productsubcategory

select * from salesperson

select * from salesterritory

select * from salesorderheader

----- Task   Basic Sales Analysis

SELECT COUNT(*) AS total_sales_orders
FROM SalesOrderHeader;

SELECT SUM(TotalDue) AS total_sales_amount
FROM SalesOrderHeader;

SELECT AVG(TotalDue) AS average_order_value
FROM SalesOrderHeader;

SELECT MIN(TotalDue) AS minimum_order_value
FROM SalesOrderHeader;

SELECT MAX(TotalDue) AS maximum_order_value
FROM SalesOrderHeader;

SELECT COUNT(CustomerID) AS unique_customers
FROM SalesOrderHeader;

----- Task 10  GROUP BY and Aggregation

SELECT c.CustomerID,
    CONCAT(p.FirstName, ' ', p.LastName) AS customer_name,
    COUNT(soh.SalesOrderID) AS number_of_orders,
    SUM(soh.TotalDue) AS total_revenue,
    AVG(soh.TotalDue) AS average_order_value
FROM Customer c
JOIN Person p ON c.PersonID = p.BusinessEntityID
JOIN SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY total_revenue DESC;
    
----- Task 11

SELECT p.ProductID, p.Name AS product_name,
    (
        SELECT SUM(sod.OrderQty) FROM SalesOrderDetail sod
        WHERE sod.ProductID = p.ProductID
    ) AS total_quantity_sold
FROM Product p
WHERE p.ProductID IN (
    SELECT ProductID
    FROM SalesOrderDetail
) ORDER BY total_quantity_sold DESC LIMIT 20;
    
select * from salesorderdetail

SELECT p.ProductID, p.Name AS product_name, SUM(sod.OrderQty) AS total_quantity_sold
FROM Product p
JOIN SalesOrderDetail sod ON p.ProductID = sod.ProductID GROUP BY p.ProductID, p.Name
     ORDER BY total_quantity_sold DESC LIMIT 20;
    
    
SELECT p.ProductID, p.Name AS product_name, SUM(sod.LineTotal) AS total_revenue
FROM Product p
JOIN SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID,p.Name
      ORDER BY total_revenue DESC LIMIT 20;
      
----- subQuery    
SELECT
    p.ProductID,
    p.Name AS product_name,

    (
        SELECT SUM(sod.OrderQty)
        FROM SalesOrderDetail sod
        WHERE sod.ProductID = p.ProductID
    ) AS total_quantity_sold,

    (
        SELECT SUM(sod.LineTotal)
        FROM SalesOrderDetail sod
        WHERE sod.ProductID = p.ProductID
    ) AS total_revenue

FROM Product p
WHERE p.ProductID IN (
    SELECT ProductID
    FROM SalesOrderDetail
)
ORDER BY total_revenue DESC;
      
----- mountain-100 Black= total_evenue- 54674.3,  Mountain Bike Socks =total_quantity -75. this is the higest product revenu &. product.
----- The products with the highest quantity sold do not necessarily have to be the products generating the highest revenue.

----- Task 12

SELECT
    st.TerritoryID,
    st.Name AS territory_name,
    COUNT(DISTINCT c.CustomerID) AS number_of_customers,
    COUNT(DISTINCT soh.SalesOrderID) AS number_of_orders,
    SUM(soh.TotalDue) AS total_revenue,
    AVG(soh.TotalDue) AS average_order_value
FROM SalesTerritory AS st
JOIN Customer AS c ON st.TerritoryID = c.TerritoryID
JOIN SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
GROUP BY
    st.TerritoryID, st.Name
ORDER BY total_revenue DESC;


----- no territory is best

----- Task 13 JOIN Practice

SELECT
    CONCAT(p.FirstName, ' ', p.LastName) AS customer_name,
    soh.SalesOrderNumber AS sales_order_number,
    soh.OrderDate AS order_date,
    st.Name AS territory,
    soh.TotalDue AS total_order_value
FROM Customer AS c
JOIN Person AS p ON c.PersonID = p.BusinessEntityID
JOIN SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
JOIN SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
ORDER BY soh.OrderDate;

----- Task 14

----- Product Sales Report
SELECT
    p.Name AS product_name,
    pc.Name AS product_category,
    psc.Name AS product_subcategory,
    SUM(sod.OrderQty) AS quantity_sold,
    SUM(sod.LineTotal) AS revenue
FROM Product AS p
JOIN ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY
    p.ProductID,p.Name,pc.Name,psc.Name
ORDER BY revenue DESC;

----- Task 15

SELECT
    CONCAT(p.FirstName, ' ', p.LastName) AS salesperson_name,
    st.Name AS territory,
    COUNT(soh.SalesOrderID) AS number_of_orders,
    SUM(soh.TotalDue) AS total_sales,
    AVG(soh.TotalDue) AS average_order_value
FROM SalesPerson AS sp
JOIN Person AS p ON sp.BusinessEntityID = p.BusinessEntityID
JOIN SalesOrderHeader AS soh ON sp.BusinessEntityID = soh.SalesPersonID
JOIN SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID
GROUP BY sp.BusinessEntityID,p.FirstName,p.LastName,st.Name
ORDER BY total_sales DESC;

----- Task 16 CASE Statement
SELECT c.CustomerID,
    SUM(soh.TotalDue) AS total_revenue,
    CASE
        WHEN SUM(soh.TotalDue) >= 1000 THEN 'Premium'
        WHEN SUM(soh.TotalDue) >= 500 THEN 'Gold'
        WHEN SUM(soh.TotalDue) >= 100 THEN 'Silver'
        ELSE 'Standard'
    END AS CustomerSegment
FROM Customer AS c, SalesOrderHeader AS soh
WHERE c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY total_revenue DESC;

----- Task 17

SELECT p.ProductID, p.Name AS product_name, SUM(sod.LineTotal) AS total_revenue,
    CASE
        WHEN SUM(sod.LineTotal) >= 100000 THEN 'High Performer'
        WHEN SUM(sod.LineTotal) >= 50000 THEN 'Medium Performer'
        ELSE 'Low Performer'
    END AS ProductClassification
FROM Product AS p
JOIN SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY total_revenue DESC;

----- 18 task CTE Practice

WITH CustomerRevenue AS (
    SELECT CustomerID, SUM(TotalDue) AS total_revenue FROM SalesOrderHeader GROUP BY CustomerID
)
SELECT CustomerID, total_revenue
FROM CustomerRevenue
ORDER BY total_revenue DESC LIMIT 10;

-----

WITH CustomerRevenue AS (
    SELECT CustomerID, SUM(TotalDue) AS total_revenue FROM SalesOrderHeader GROUP BY CustomerID
)
SELECT CustomerID,total_revenue FROM CustomerRevenue
WHERE total_revenue > ( SELECT AVG(total_revenue) FROM CustomerRevenue)
ORDER BY total_revenue DESC;

------
WITH CustomerRevenue AS (
    SELECT CustomerID, SUM(TotalDue) AS total_revenue FROM SalesOrderHeader GROUP BY CustomerID
)
SELECT CustomerID, total_revenue FROM CustomerRevenue

-------- Task 19 common table expression

WITH ProductPerformance AS (
SELECT ProductID, SUM(OrderQty) AS quantity_sold, SUM(LineTotal) AS revenue 
FROM SalesOrderDetail GROUP BY ProductID
)
SELECT ProductID,quantity_sold,revenue FROM ProductPerformance
ORDER BY revenue DESC;

------ 

 WITH ProductPerformance AS (
    SELECT
        ProductID,SUM(OrderQty) AS quantity_sold,SUM(LineTotal) AS revenue FROM SalesOrderDetail GROUP BY ProductID
)
SELECT
    ProductID, quantity_sold, revenue, (revenue / (SELECT SUM(revenue) FROM ProductPerformance)) * 100 AS percentage_of_total_sales
FROM ProductPerformance
WHERE revenue > (
    SELECT SUM(revenue) * 0.05 FROM ProductPerformance
)
ORDER BY revenue DESC;

----- Task 20 Window Functions

SELECT CustomerID, total_revenue, ROW_NUMBER() OVER ( ORDER BY total_revenue DESC ) AS revenue_rank
FROM (
    SELECT CustomerID, SUM(TotalDue) AS total_revenue FROM SalesOrderHeader GROUP BY CustomerID
) AS customer_revenue;

-----

SELECT CustomerID,TerritoryID,total_revenue,
    ROW_NUMBER() OVER (PARTITION BY TerritoryID ORDER BY total_revenue DESC) AS territory_rank
FROM (
    SELECT CustomerID,TerritoryID, SUM(TotalDue) AS total_revenue
    FROM SalesOrderHeader GROUP BY CustomerID,TerritoryID
) AS customer_revenue
ORDER BY TerritoryID,territory_rank;

----- Task 21 rank()

SELECT CustomerID, TerritoryID,total_revenue,
    RANK() OVER (
        PARTITION BY TerritoryID ORDER BY total_revenue DESC) AS territory_rank
FROM (
    SELECT
        CustomerID,TerritoryID,SUM(TotalDue) AS total_revenue FROM SalesOrderHeader
    GROUP BY CustomerID,TerritoryID
) AS customer_revenue
ORDER BY TerritoryID,territory_rank;

----- Task 22 dense_rank()

SELECT CustomerID,TerritoryID,total_revenue,
    DENSE_RANK() OVER ( ORDER BY total_revenue DESC) AS dense_rank_value
FROM (
    SELECT CustomerID,TerritoryID,SUM(TotalDue) AS total_revenue FROM SalesOrderHeader
    GROUP BY CustomerID,TerritoryID
) AS customer_revenue
ORDER BY TerritoryID, total_revenue DESC;

----- Task 24

SELECT
    SalesOrderID,
    TotalDue,
    SUM(TotalDue) OVER (
        ORDER BY SalesOrderID
    ) AS running_total
FROM SalesOrderHeader
LIMIT 5;

----- Task 25

SELECT SalesOrderID, TotalDue,
    LAG(TotalDue) OVER (ORDER BY SalesOrderID) AS previous_order_value
FROM SalesOrderHeader
LIMIT 5;

----- Task 27

SELECT
    SalesOrderID,
    TotalDue,
    LEAD(TotalDue) OVER (
        ORDER BY SalesOrderID
    ) AS next_order_value
FROM SalesOrderHeader
LIMIT 10;

----- TASK 23,26,28,30 not yet completed

----- Task 29

SELECT CustomerID,TotalDue AS order_value,
    SUM(TotalDue) OVER (
        PARTITION BY CustomerID
        ORDER BY SalesOrderID
    ) AS running_revenue
FROM SalesOrderHeader
ORDER BY CustomerID,SalesOrderID;

----- Advanced Business Problems

----- Task 1

WITH ProductRevenue AS (
    SELECT p.ProductID, p.Name AS product_name, pc.Name AS category_name, SUM(sod.LineTotal) AS revenue 
    FROM Product AS p
    JOIN SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
    JOIN ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    JOIN ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
    GROUP BY p.ProductID, p.Name, pc.Name
),
RankedProducts AS (
    SELECT ProductID, product_name, category_name, revenue,
        RANK() OVER (PARTITION BY category_name ORDER BY revenue DESC) AS product_rank
    FROM ProductRevenue
)
SELECT ProductID, product_name, category_name, revenue, product_rank
FROM RankedProducts WHERE product_rank <= 3
ORDER BY category_name, product_rank;

----- Task 2

WITH CustomerRevenue AS ( SELECT CustomerID,TerritoryID,SUM(TotalDue) AS total_revenue
FROM SalesOrderHeader
    GROUP BY CustomerID,TerritoryID
),
RankedCustomers AS ( SELECT CustomerID,TerritoryID,total_revenue,
        RANK() OVER (PARTITION BY TerritoryID ORDER BY total_revenue DESC) AS customer_rank
    FROM CustomerRevenue
)
SELECT CustomerID,TerritoryID,total_revenue,customer_rank
FROM RankedCustomers
WHERE customer_rank = 1
ORDER BY TerritoryID;


----- Task 3

WITH CustomerRevenue AS (
    SELECT CustomerID,SUM(TotalDue) AS total_revenue FROM SalesOrderHeader
    GROUP BY CustomerID
),
RankedCustomers AS (
    SELECT CustomerID,total_revenue,
        RANK() OVER (ORDER BY total_revenue DESC) AS customer_rank
    FROM CustomerRevenue
)
SELECT CustomerID,total_revenue
FROM RankedCustomers
WHERE customer_rank = 2;