-- Selecting Table

Select *
From OutletsSales.dbo.sales

-- Changing reg and LW to Regular and Low fat respectively from Item fat content

Select DISTINCT(Item_Fat_Content)
From OutletsSales.dbo.sales

Select DISTINCT Item_Fat_Content,
	CASE
		WHEN Item_Fat_Content = 'reg' THEN 'Regular'
		WHEN Item_Fat_Content = 'LF' THEN 'Low Fat'
		ELSE Item_Fat_Content
	END
From OutletsSales.dbo.sales

UPDATE sales
SET Item_Fat_Content = 
	CASE
		WHEN Item_Fat_Content = 'reg' THEN 'Regular'
		WHEN Item_Fat_Content = 'LF' THEN 'Low Fat'
		ELSE Item_Fat_Content
	END

-----------------------------------------------------------------------------------------------------------------------------------

Select *
From OutletsSales.dbo.sales

-- Select Outlet type where year is Null

Select Outlet_Type, Year
From OutletsSales.dbo.sales
Where Year is null

-------------------------------------------------------------------------------------------------------------------------------------

-- Select top 10 Item types

Select TOP 10(Item_Type)
From OutletsSales.dbo.sales

-------------------------------------------------------------------------------------------------------------------------------------

-- Select Item type, Item price and Outlet type where Item price is greater than $200

Select Item_Type, [Item_MRP $], Outlet_type
From OutletsSales.dbo.sales
Where [Item_MRP $] > 200
Order By 2

--------------------------------------------------------------------------------------------------------------------------------------

-- Show sales and sale status in the year 2002

Select FLOOR([Sales $]) as Sales, Sales_Status
From OutletsSales.dbo.sales
Where Year = 2002

----------------------------------------------------------------------------------------------------------------------------------------

-- Select Item identifier, Item type, Item price and Item weight of Items with Low Fat content

Select Item_Identifier, Item_Type, [Item_MRP $], Item_Weight
From OutletsSales.dbo.sales
Where Item_Fat_Content = 'Low fat'


----------------------------------------------------------------------------------------------------------------------------------------

-- Show total items, total sales, total revenue and Percentage of sales by revenue

Select COUNT(Item_Type) as Every_Items, SUM([Sales $]) as Total_Sales, SUM(Outlet_Type_Revenue) as Total_Revenue, SUM([Sales $]) / 
		SUM(Outlet_Type_Revenue) * 100 as PercentSalesByRevenue
From OutletsSales.dbo.sales

----------------------------------------------------------------------------------------------------------------------------------------


--Select DISTINCT Outlet_Type, Outlet_Size, Outlet_Location_Type, SUM([Sales $]) as Total_Sales
--From OutletsSales.dbo.sales
--Group by Outlet_Size, Outlet_Type, Outlet_Location_Type, [Sales $]
--Order by 3

----------------------------------------------------------------------------------------------------------------------------------------
-- Display total sales by Outlet type and Outlet size

Select Outlet_Type, Outlet_size, SUM([Sales $]) as SalesByOutlet
From OutletsSales.dbo.sales
Group by Outlet_Type, Outlet_Size


----------------------------------------------------------------------------------------------------------------------------------------

-- Display total sales by Item type

Select Item_Type, SUM(FLOOR([Sales $])) as SalesByItemType
From OutletsSales.dbo.sales
Group by Item_Type
Order by 1

----------------------------------------------------------------------------------------------------------------------------------------

-- Display total revenue by each Outlet

Select Outlet_Type, SUM(Outlet_Type_Revenue)
From OutletsSales.dbo.sales
Group by Outlet_Type


----------------------------------------------------------------------------------------------------------------------------------------

-- Display total sales made by each outlet type by year

Select DISTINCT Year, Outlet_Type, SUM(FLOOR([Sales $])) as SalesByYear
From OutletsSales.dbo.sales
Group by Year, Outlet_Type
Order by 1


-----------------------------------------------------------------------------------------------------------------------------------------

-- Views for visualization

-----------------------------------------------------------------------------------------------------------------------------------------

-- View one ( Year vs Sales)

Select Year, SUM(Floor([Sales $])) as Sales
From OutletsSales.dbo.sales
Group by Year

-----------------------------------------------------------------------------------------------------------------------------------------

-- View two (Item types)

Select TOP 10 Item_Type, COUNT(Item_Type)
From OutletsSales.dbo.sales
Group By Item_Type
Order by 1


-----------------------------------------------------------------------------------------------------------------------------------------

-- View three

Select COUNT(Item_Type) as Item
From OutletsSales.dbo.sales
Group By Item_Type
Order by 1z