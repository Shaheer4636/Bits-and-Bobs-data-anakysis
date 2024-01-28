create database BitsAndBobs;


use BitsAndBobs;

-- As we have the basic table which contains all the data [dbo].[AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
-- We dont need to create a SalesData table 
-- We start by creating the customer table

-- customer table 
CREATE TABLE Customers (
    CustomerID NVARCHAR(20), 
    CustomerFirstName NVARCHAR(50),
    CustomerSurname NVARCHAR(50)
)

-- drop table Customers;

INSERT INTO Customers (CustomerID, CustomerFirstName, CustomerSurname)
SELECT DISTINCT Customer_ID, Customer_First_Name, Customer_Surname
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data];

-- create items table 
CREATE TABLE Items (
    ItemID INT,
    ItemDescription NVARCHAR(100),
    ItemPrice DECIMAL(10, 2)
);

INSERT INTO Items (ItemID, ItemDescription, ItemPrice)
SELECT DISTINCT Item_ID, Item_Description, Item_Price
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data];

-- staff table 
CREATE TABLE Staff (
    StaffID INT,
    StaffFirstName NVARCHAR(50),
    StaffSurname NVARCHAR(50),
    StaffOffice NVARCHAR(50),
    OfficeLocation NVARCHAR(50)
);

INSERT INTO Staff (StaffID, StaffFirstName, StaffSurname, StaffOffice, OfficeLocation)
SELECT DISTINCT Staff_ID, Staff_First_Name, Staff_Surname, Staff_office, Office_Location
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data];


-- we are making this table to analyze the performane 
-- the table is named as sales table 

-- sales table 
CREATE TABLE Sales (
    SaleDate DATETIME,
    ReceiptId INT,
    OfficeLocation NVARCHAR(50),
    RowTotal DECIMAL(12, 2)
);

INSERT INTO Sales (SaleDate, ReceiptId, OfficeLocation, RowTotal)
SELECT Sale_Date, Receipt_Id, Office_Location, Row_Total
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data];



-- Selecting all the data from the file we have load into the ssms 
select * from [dbo].[AssignmentTwo2023Data_-313404010 - Assignment 2 Data]

-- checking null values 
SELECT *
FROM [dbo].[AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
WHERE [Customer_ID] IS NULL
OR [Staff_ID] IS NULL
OR [Receipt_ID] IS NULL

-- checking data type inconsistencies from the sales-date column 
SELECT *
FROM [dbo].[AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
WHERE ISDATE([Sale_Date]) = 0

-- checking duplicate records
SELECT [Receipt_ID], COUNT(*)
FROM [dbo].[AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
GROUP BY [Receipt_ID]
HAVING COUNT(*) > 1

-- data integrity constrains 
SELECT *
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
WHERE [Item_Quantity] < 0
OR [Item_Price] <= 0

-- Invalid relationships 
SELECT *
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
WHERE [Customer_ID] NOT IN (SELECT ID FROM CustomerTable)


-- Analysis Part 
-- Approach N0.1 
-- problem 1: Most popular item 
SELECT TOP 3 Item_ID, Item_Description, SUM(Item_Quantity) AS TotalQuantitySold
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
GROUP BY Item_ID, Item_Description
ORDER BY TotalQuantitySold DESC;

-- problem 2: Least popular items 
SELECT TOP 3 Item_ID, Item_Description, SUM(Item_Quantity) AS TotalQuantitySold
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
GROUP BY Item_ID, Item_Description
ORDER BY TotalQuantitySold ;

-- problem 3: top 3 salesman 
SELECT TOP 3 Staff_ID, Staff_First_Name, Staff_Surname, SUM(Row_Total) AS TotalSales
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
WHERE Sale_Date >= DATEADD(YEAR, -1, GETDATE())  -- Filters data from the last year
GROUP BY Staff_ID, Staff_First_Name, Staff_Surname
ORDER BY TotalSales DESC;


-- Approach NO.2
-- Know this analysis is based on the sales of each office 
-- Problem 1: top 3 items soled in each office 
WITH RankedItems AS (
    SELECT Office_Location, Item_ID, Item_Description, SUM(Item_Quantity) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY Office_Location ORDER BY SUM(Item_Quantity) DESC) AS SalesRank,
        ROW_NUMBER() OVER (PARTITION BY Office_Location ORDER BY SUM(Item_Quantity)) AS LeastSalesRank
    FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
    GROUP BY Office_Location, Item_ID, Item_Description
)
SELECT Office_Location, Item_ID, Item_Description, TotalQuantitySold
FROM RankedItems
WHERE SalesRank <= 3;

-- Problem 2: least selling product of each office 
SELECT Office_Location, Item_ID, Item_Description, TotalQuantitySold
FROM (
    SELECT Office_Location, Item_ID, Item_Description, SUM(Item_Quantity) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY Office_Location ORDER BY SUM(Item_Quantity) ASC) AS LeastSalesRank
    FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
    GROUP BY Office_Location, Item_ID, Item_Description
) AS RankedItems
WHERE LeastSalesRank <= 3;



-- Problem 3: top 3 sales person 
WITH RankedSales AS (
    SELECT 
        Staff_ID,
        Staff_First_Name,
        Staff_Surname,
        Office_Location,
        SUM(Row_Total) AS TotalSales,
        ROW_NUMBER() OVER (PARTITION BY Office_Location ORDER BY SUM(Row_Total) DESC) AS SalesRank
    FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
    WHERE Sale_Date >= DATEADD(YEAR, -1, GETDATE())
    GROUP BY Staff_ID, Staff_First_Name, Staff_Surname, Office_Location
)
SELECT Staff_ID, Staff_First_Name, Staff_Surname, Office_Location, TotalSales
FROM RankedSales
WHERE SalesRank <= 3;

-- Most profitable office with highest sales 
SELECT TOP 1 Office_Location, SUM(Row_Total) AS TotalSales
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
GROUP BY Office_Location
ORDER BY TotalSales DESC;

-- Least profitable office with least sales
SELECT TOP 1 Office_Location, SUM(Row_Total) AS TotalSales
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
GROUP BY Office_Location
ORDER BY TotalSales;

-- List of offices with their sales 
SELECT TOP 1 Office_Location, SUM(Row_Total) AS TotalSales
FROM [AssignmentTwo2023Data_-313404010 - Assignment 2 Data]
GROUP BY Office_Location
ORDER BY TotalSales DESC;


