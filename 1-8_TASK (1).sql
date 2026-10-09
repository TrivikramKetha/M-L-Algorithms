 ----- create table person_person Task 1
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);
----- insert values 
INSERT INTO Person (PersonID, FirstName, LastName)
VALUES
(1, 'Vignesh', 'Babu'),
(2, 'Rahul', 'Kumar'),
(3, 'Arjun', 'Reddy'),
(4, 'Priya', 'Sharma'),
(5, 'Anusha', 'Devi'),
(6, 'Kiran', 'Rao'),
(7, 'Harshitha', 'Reddy'),
(8, 'Bhaskar', 'Kumar');

select * from person

----- create table Sales
CREATE TABLE SalesTerritory (
    TerritoryID INT PRIMARY KEY,
    TerritoryName VARCHAR(100),
    Country VARCHAR(50)
);

INSERT INTO SalesTerritory (TerritoryID, TerritoryName, Country)
VALUES
(1, 'Andhra Pradesh', 'India'),
(2, 'Telangana', 'India'),
(3, 'Karnataka', 'India'),
(4, 'Tamil Nadu', 'India'),
(5, 'Kerala', 'India'),
(6, 'Maharashtra', 'India'),
(7, 'Delhi', 'India'),
(8, 'Gujarat', 'India');

select * from  SalesTerritory


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    PersonID INT,
    TerritoryID INT,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);

INSERT INTO Customer (CustomerID, PersonID, TerritoryID)
VALUES
(101, 1, 1),
(102, 2, 2),
(103, 3, 3),
(104, 4, 4),
(105, 5, 5),
(106, 6, 6),
(107, 7, 7),
(108, 8, 8);

select * from Customer


----- table 5 sales person
CREATE TABLE SalesPerson (
    SalesPersonID INT PRIMARY KEY,
    PersonID INT,
    TerritoryID INT,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);

INSERT INTO SalesPerson (SalesPersonID, PersonID, TerritoryID)
VALUES
(11, 1, 1),
(12, 2, 2),
(13, 3, 3),
(14, 4, 4),
(15, 5, 5),
(16, 6, 6),
(17, 7, 7),
(18, 8, 8);

select * from salesperson


CREATE TABLE SalesOrderHeader (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    SalesPersonID INT,
    TerritoryID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
    FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);

INSERT INTO SalesOrderHeader 
(OrderID, CustomerID, SalesPersonID, TerritoryID, OrderDate, TotalAmount)
VALUES
(01, 101, 11, 1, '2026-01-10', 24999.00),
(02, 102, 12, 2, '2026-01-15', 799.00),
(03, 103, 13, 3, '2026-02-05', 5499.00),
(04, 104, 14, 4, '2026-02-12', 32999.00),
(05, 105, 15, 5, '2026-02-20', 899.00),
(06, 106, 16, 6, '2026-03-03', 1299.00),
(07, 107, 17, 7, '2026-03-15', 2499.00),
(08, 108, 18, 8, '2026-03-25', 699.00);

----- table pc
CREATE TABLE ProductCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

INSERT INTO ProductCategory (CategoryID, CategoryName)
VALUES
(101, 'Electronics'),
(205, 'Clothing'),
(317, 'Furniture'),
(428, 'Sports'),
(536, 'Books'),
(649, 'Grocery'),
(752, 'Automotive'),
(864, 'Accessories');

select * from ProductCategory

----- table psc
CREATE TABLE ProductSubcategory (
    SubcategoryID INT PRIMARY KEY,
    SubcategoryName VARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID)
);

INSERT INTO ProductSubcategory (SubcategoryID, SubcategoryName, CategoryID)
VALUES
(201, 'Mobile Phones', 101),
(314, 'Mens Clothing', 205),
(427, 'Home Furniture', 317),
(538, 'Fitness Equipment', 428),
(642, 'Educational Books', 536),
(753, 'Packaged Foods', 649),
(865, 'Car Accessories', 752),
(976, 'Computer Accessories', 864);

select * from  ProductSubcategory 

-- table Product
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SubcategoryID INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (SubcategoryID) REFERENCES ProductSubcategory(SubcategoryID)
);

INSERT INTO Product (ProductID, ProductName, SubcategoryID, UnitPrice)
VALUES
(21, 'Smartphone', 201, 24999.00),
(22, 'T-Shirt', 314, 799.00),
(23, 'Office Chair', 427, 5499.00),
(24, 'Treadmill', 538, 32999.00),
(25, 'Python Programming Book', 642, 899.00),
(26, 'Organic Rice', 753, 1299.00),
(27, 'Car Seat Cover', 865, 2499.00),
(28, 'Wireless Mouse', 976, 699.00);

select * from  Product

-------- table sale-OD
CREATE TABLE SalesOrderDetail (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES SalesOrderHeader(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO SalesOrderDetail
(OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(10, 01, 21, 2, 24999.00),
(20, 02, 22, 3, 799.00),
(30, 03, 23, 1, 5499.00),
(40, 04, 24, 1, 32999.00),
(50, 05, 25, 2, 899.00),
(60, 06, 26, 4, 1299.00),
(70, 07, 27, 2, 2499.00),
(80, 08, 28, 3, 699.00);


select * from SalesOrderDetail

-- Task 2

CREATE SCHEMA Analytics;

USE AdventureWorks_Training;


-- Task 3

CREATE TABLE Analytics.CustomerAnalysis (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    TerritoryID INT NOT NULL,
    TotalOrders INT NOT NULL DEFAULT 0,
    TotalRevenue DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CustomerSegment VARCHAR(50) NULL,
    CreatedDate DATE NOT NULL DEFAULT (CURRENT_DATE)
);

INSERT INTO Analytics.CustomerAnalysis
(CustomerID, CustomerName, TerritoryID, TotalOrders, TotalRevenue, CustomerSegment, CreatedDate)
VALUES
(101, 'Vignesh Babu', 1, 1, 24999.00, 'Premium', '2026-03-30'),
(102, 'Rahul Kumar', 2, 1, 799.00, 'Regular', '2026-03-30'),
(103, 'Arjun Reddy', 3, 1, 5499.00, 'Premium', '2026-03-30'),
(104, 'Priya Sharma', 4, 1, 32999.00, 'Premium', '2026-03-30'),
(105, 'Anusha Devi', 5, 1, 899.00, 'Regular', '2026-03-30'),
(106, 'Kiran Rao', 6, 1, 1299.00, 'Regular', '2026-03-30'),
(107, 'Harshitha Reddy', 7, 1, 2499.00, 'Regular', '2026-03-30'),
(108, 'Bhaskar Kumar', 8, 1, 699.00, 'Regular', '2026-03-30');


----- Task 4


CREATE TABLE Analytics.ProductPerformance (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ProductCategory VARCHAR(100) NOT NULL,
    ProductSubcategory VARCHAR(100) NULL,
    TotalQuantitySold INT NOT NULL DEFAULT 0,
    TotalRevenue DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    AverageSellingPrice DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    ProductRank INT NULL,
    PerformanceCategory VARCHAR(50) NULL
);

INSERT INTO Analytics.ProductPerformance
(ProductID, ProductName, ProductCategory, ProductSubcategory,
 TotalQuantitySold, TotalRevenue, AverageSellingPrice, ProductRank, PerformanceCategory)
VALUES
(21, 'Smartphone', 'Electronics', 'Mobile Phones', 2, 49998.00, 24999.00, 1, 'Excellent'),
(22, 'T-Shirt', 'Clothing', 'Mens Clothing', 3, 2397.00, 799.00, 7, 'Average'),
(23, 'Office Chair', 'Furniture', 'Home Furniture', 1, 5499.00, 5499.00, 4, 'Good'),
(24, 'Treadmill', 'Sports', 'Fitness Equipment', 1, 32999.00, 32999.00, 2, 'Excellent'),
(25, 'Python Programming Book', 'Books', 'Educational Books', 2, 1798.00, 899.00, 6, 'Average'),
(26, 'Organic Rice', 'Grocery', 'Packaged Foods', 4, 5196.00, 1299.00, 5, 'Good'),
(27, 'Car Seat Cover', 'Automotive', 'Car Accessories', 2, 4998.00, 2499.00, 3, 'Good'),
(28, 'Wireless Mouse', 'Accessories', 'Computer Accessories', 3, 2097.00, 699.00, 8, 'Average');


----- Task 5

----- Add column
ALTER TABLE Analytics.CustomerAnalysis
ADD COLUMN Email VARCHAR(100);


INSERT INTO Analytics.CustomerAnalysis (CustomerID, Email)
VALUES
(101, 'vignesh@gmail.com'),
(102, 'rahul@gmail.com'),
(103, 'arjun@gmail.com'),
(104, 'priya@gmail.com'),
(105, 'anusha@gmail.com'),
(106, 'kiran@gmail.com'),
(107, 'harshitha@gmail.com'),
(108, 'bhaskar@gmail.com');

select* from Analytics.CustomerAnalysis

----- Change a column's data type
ALTER TABLE Analytics.CustomerAnalysis
MODIFY COLUMN CustomerName VARCHAR(150) NOT NULL;

----- Add a DEFAULT constraint
ALTER TABLE Analytics.CustomerAnalysis
ALTER COLUMN CustomerSegment SET DEFAULT 'Regular';

----- Add a CHECK constraint
ALTER TABLE Analytics.CustomerAnalysis
ADD CONSTRAINT chk_total_revenue
CHECK (TotalRevenue >= 0);

----- Add UNIQUE
ALTER TABLE Analytics.CustomerAnalysis
ADD CONSTRAINT uq_customer_email
UNIQUE (Email);

----- rename
ALTER TABLE Analytics.CustomerAnalysis
RENAME COLUMN Email TO CustomerEmail;

----- drop contraints
ALTER TABLE Analytics.CustomerAnalysis
DROP INDEX uq_customer_email;

ALTER TABLE Analytics.CustomerAnalysis
DROP CHECK chk_total_revenue;

----- remove column
ALTER TABLE Analytics.CustomerAnalysis
DROP COLUMN CustomerEmail;

----- ALTER TABLE is a DDL command. It changes the structure of the table, such as adding, modifying, renaming, or removing columns and constraints.
----- UPDATE is a DML command. It changes the data stored inside existing rows without changing the table structure.

----- Task 6
USE AdventureWorks_Training;

INSERT INTO Analytics.CustomerAnalysis
(CustomerID, CustomerName, TerritoryID, TotalOrders, TotalRevenue, CustomerSegment, CreatedDate)
VALUES
(109, 'Sanjay Kumar', 1, 2, 15998.00, 'Regular', '2026-08-19'),
(110, 'Sneha Reddy', 2, 3, 45999.00, 'Premium', '2026-08-19'),
(111, 'Rohit Sharma', 3, 1, 2499.00, 'Regular', '2026-08-19'),
(112, 'Keerthi Rao', 4, 4, 67998.00, 'Premium', '2026-08-19'),
(113, 'Naveen Kumar', 5, 2, 10998.00, 'Regular', '2026-08-19');

SELECT *FROM Analytics.CustomerAnalysis;

----- Task 7

----- case 
UPDATE Analytics.CustomerAnalysis
SET CustomerSegment =
    CASE
        WHEN TotalRevenue >= 10000 THEN 'Premium'
        WHEN TotalRevenue BETWEEN 5000 AND 9999.99 THEN 'Gold'
        WHEN TotalRevenue BETWEEN 1000 AND 4999.99 THEN 'Silver'
        WHEN TotalRevenue < 1000 THEN 'Standard'
    END
WHERE CustomerID  BETWEEN 101 AND 113;

SELECT
    CustomerID,
    CustomerName,
    TotalRevenue,
    CustomerSegment
FROM Analytics.CustomerAnalysis
ORDER BY CustomerID;

----- Task 8

SELECT *
FROM Analytics.CustomerAnalysis
WHERE CustomerID BETWEEN 109 AND 113;

DELETE FROM Analytics.CustomerAnalysis
WHERE CustomerID BETWEEN 109 AND 113;





