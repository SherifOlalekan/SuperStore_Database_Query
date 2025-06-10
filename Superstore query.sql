-- DATABASE CREATION
CREATE DATABASE Superstore_DB;
GO
-- switch to the database after ctreating it
USE Superstore_DB;
GO

--TABLES CREATION

 -- Orders table
 CREATE TABLE [dbo].[Orders](
	[RowID] [int] PRIMARY KEY,
	[OrderID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[OrderPriority] [varchar](50) NOT NULL,
	[OrderQuantity] [int] NOT NULL,
	[Sales] [float] NOT NULL,
	[Discount] [float] NOT NULL,
	[ShipMode] [varchar](50) NOT NULL,
	[Profit] [float] NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[ShippingCost] [float] NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[Province] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](50) NOT NULL,
	[CustomerSegment] [varchar](50) NOT NULL,
	[ProductCategory] [varchar](50) NOT NULL,
	[ProductSubCategory] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductContainer] [varchar](50) NOT NULL,
	[ProductBaseMargin] [float] NULL,
	[ShipDate] [date] NOT NULL
)

-- Returns table creation
CREATE TABLE [dbo].[Returns](
	[OrderID] [int] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	)

-- Users table creation
CREATE TABLE [dbo].[Users](
	[Region] [nvarchar](50) NOT NULL,
	[Manager] [varchar](50) NOT NULL
)
GO

-- THE IMPORT PROCESS

-- Insert the returns table
INSERT INTO [Superstore_DB].[dbo].[Returns] (OrderID, Status)  -- Step 1
SELECT *                                                         -- Step 2
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',                      -- Step 3
    'Excel 12.0;Database=C:\Users\HP\Desktop\Superstore.xlsx;HDR=YES;IMEX=1', -- Step 4
    'SELECT * FROM [Returns$]'
	);

-- Insert the users table
INSERT INTO [Superstore_DB].[dbo].[Users] (Region, Manager)  -- Step 1
SELECT *                                                         -- Step 2
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',                      -- Step 3
    'Excel 12.0;Database=C:\Users\HP\Desktop\Superstore.xlsx;HDR=YES;IMEX=1', -- Step 4
    'SELECT * FROM [Users$]'
	);


-- Insert the Orders table
INSERT INTO [Superstore_DB].[dbo].[Orders](  -- Step 1
	RowID, 
	OrderID, OrderDate,
	OrderPriority,
	OrderQuantity,
	Sales,
	Discount,
	ShipMode,
	Profit,
	UnitPrice,
	ShippingCost,
	CustomerName,
	Province,
	Region,
	CustomerSegment,
	ProductCategory,
	ProductSubCategory,
	ProductName,
	ProductContainer,
	ProductBaseMargin,
	ShipDate
	)

SELECT *                                                         -- Step 2
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',                      -- Step 3
    'Excel 12.0;Database=C:\Users\HP\Desktop\Superstore.xlsx;HDR=YES;IMEX=1', -- Step 4
    'SELECT * FROM [Orders$]'
	);

-- Challenge faced
	-- The issue of nullability, i had to delete some empty rows before importing them
	-- i also had to convert the datatypes in excel before importing




-- Synthax Used to query the database to ensure they are accurate

-- Synthax 1: Sales Across region
SELECT ROUND(SUM(Sales), 2) AS Sales, Region
FROM [Superstore_DB].[dbo].[Orders]
GROUP BY Region
ORDER BY Sales DESC;

-- Synthax 2: Top performing products
select ProductCategory, ProductName, ROUND(SUM(Sales),2) AS Sales
from [Superstore_DB].[dbo].[Orders]
GROUP BY ProductCategory, ProductName
ORDER BY Sales DESC;

-- Synthax 3: Numnber and Percentage of goods returned
SELECT 
	COUNT(R.status) AS NumberOfReturns,
	ROUND(CAST(COUNT(DISTINCT R.OrderID) AS FLOAT) / COUNT(DISTINCT O.OrderID),2) * 100 AS PercentageOfReturned
FROM [Superstore_DB].[dbo].[Orders] AS O
LEFT JOIN
	Superstore_DB.dbo.Returns AS R ON O.OrderID = R.OrderID

-- Synthax 4
SELECT  COUNT(*)
FROM [Superstore_DB].[dbo].[Orders] -- Row number is 8399 which is same as the cleaned data





