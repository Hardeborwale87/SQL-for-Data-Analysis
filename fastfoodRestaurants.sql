-- Importing the database

Select *
From fastfood_restaurants.dbo.FastFood_Restaurant

/*

Cleaning Data in Table

*/
----------------------------------------------------------------------------------------------------------------------------------

-- Separating date and time in dateAdded column

Select dateAdded 
From fastfood_restaurants.dbo.FastFood_Restaurant

Select --CAST(dateAdded AS Date) as Date,
CONVERT(time(0), CAST(dateAdded AS Time))
From fastfood_restaurants.dbo.FastFood_Restaurant

ALTER TABLE FastFood_Restaurant
ADD separatedDateAdded Date, separatedTimeAdded Time(0);

UPDATE FastFood_Restaurant
SET separatedDateAdded = CAST(dateAdded AS Date),
separatedTimeAdded = CONVERT(time(0), CAST(dateAdded AS Time))


Select *
From fastfood_restaurants.dbo.FastFood_Restaurant


-- Separating date and time on datUpdated

Select CAST(dateUpdated AS Date),
CONVERT(time(0), CAST(dateUpdated AS Time))
From fastfood_restaurants.dbo.FastFood_Restaurant

ALTER TABLE FastFood_Restaurant
ADD separatedDateUpdated Date, separatedTimeUpdated Time(0);

UPDATE FastFood_Restaurant
SET separatedDateUpdated = CAST(dateUpdated AS Date),
separatedTimeUpdated = CONVERT(time(0), CAST(dateUpdated AS Time))


Select *
From fastfood_restaurants.dbo.FastFood_Restaurant


-- checking for duplicate

Select a.id, a.address, a.name, b.id, b.address, b.name
From fastfood_restaurants.dbo.FastFood_Restaurant a
JOIN fastfood_restaurants.dbo.FastFood_Restaurant b
	on a.id = b.id
GROUP BY a.id, a.address, a.name, b.id, b.address, b.name
HAVING COUNT(a.id) > 1

--Select a.id, a.address, a.name, b.id, b.address, b.name
--From fastfood_restaurants.dbo.FastFood_Restaurant a
--JOIN fastfood_restaurants.dbo.FastFood_Restaurant b
--	on a.id = b.id
--	and a.[index] <> b.[index]


-- Checking duplicates using cte

WITH duplicateRows AS(
Select *, 
	ROW_NUMBER() OVER (
	PARTITION BY id,
				 address,
				 name
				 Order By [index]
					) row_num

From fastfood_restaurants.dbo.FastFood_Restaurant
)
Select *
From duplicateRows
Where row_num >= 1
Order by id

-- deleting duplicates

WITH duplicateRows AS(
Select *, 
	ROW_NUMBER() OVER (
	PARTITION BY id,
				 address,
				 name
				 Order By [index]
					) row_num

From fastfood_restaurants.dbo.FastFood_Restaurant
)
DELETE
From duplicateRows
Where row_num > 1

-- delete used columns

ALTER TABLE FastFood_Restaurant
DROP COLUMN dateAdded, dateUpdated

----------------------------------------------------------------------------------------------------------------------------------------------


/*

Working with the data

*/

----------------------------------------------------------------------------------------------------------------------------------------------



-- Showing total number location a restaurant is located in a city

Select distinct city, postalCode, keys, name
From fastfood_restaurants.dbo.FastFood_Restaurant

Select distinct name, city, count(name) no_of_restaurant
From fastfood_restaurants.dbo.FastFood_Restaurant
Group by name, city
Order by 3 desc

-- showing the number of restaurants per city

Select DISTINCT city, count(name) restaurantPerCity
From fastfood_restaurants.dbo.FastFood_Restaurant
Group by city


-- showing all restaurants in Houston

Select name, address, postalCode, keys
From fastfood_restaurants.dbo.FastFood_Restaurant
Where city = 'Houston'


-- Showing Restaurant by category

Select name, categories
From fastfood_restaurants.dbo.FastFood_Restaurant


-- Showing restaurants by SourceUrl

Select name, sourceURLS
From fastfood_restaurants.dbo.FastFood_Restaurant

-- Select restaurant where source url is trip advisor

Select name, sourceURLs
From fastfood_restaurants.dbo.FastFood_Restaurant
Where sourceURLs LIKE 'http://www.tripadvisor.com/%' 
	

-- Select restaurants that are added after 2016-07-19


Select *
From fastfood_restaurants.dbo.FastFood_Restaurant
Where separatedDateAdded > '2016-07-19'

Select 
From fastfood_restaurants.dbo.FastFood_Restaurant
Where Is Null