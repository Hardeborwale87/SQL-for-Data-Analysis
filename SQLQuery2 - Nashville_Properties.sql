/*

Cleaning Data in SQL queries

*/


Select * 
From portfolio_project.dbo.NashvilleHousing

-----------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select SaleDateConverted, --CONVERT(Date, SaleDate)
From portfolio_project.dbo.NashvilleHousing

ALTER Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = CONVERT(Date, SaleDate)


-- Populate Property Address data

Select *
From portfolio_project.dbo.NashvilleHousing
--Where PropertyAddress is Null
Order By ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, B.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) as PropertyAddressUpdated
From portfolio_project.dbo.NashvilleHousing a
JOIN portfolio_project.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From portfolio_project.dbo.NashvilleHousing a
JOIN portfolio_project.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null


-- Breaking out Address into individual Columns (Address, City, State)

Select PropertyAddress
From portfolio_project.dbo.NashvilleHousing
--Where PropertyAddress is Null
--Order By ParcelID

Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, CHARINDEX(',', PropertyAddress)) as City
From portfolio_project.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER Table NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, CHARINDEX(',', PropertyAddress))




Select OwnerAddress
From portfolio_project.dbo.NashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerSplitState,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerSplitCity,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerSplitAddress
From portfolio_project.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER Table NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER Table NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

Select *
From portfolio_project.dbo.NashvilleHousing



-- Change Y and N to Yes and No in "Sold as Vacant" field


Select DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
From portfolio_project.dbo.NashvilleHousing
Group By SoldAsVacant
Order By 2

Select SoldAsVacant,
CASE when SoldAsVacant = 'Y' Then 'Yes'
	 when SoldAsVacant = 'N' Then 'No'
	 ELSE SoldAsVacant
	 END
From portfolio_project.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant =
CASE when SoldAsVacant = 'Y' Then 'Yes'
	 when SoldAsVacant = 'N' Then 'No'
	 ELSE SoldAsVacant
	 END




-- Remove Duplicates


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 Order By
					UniqueID
					) row_num

From portfolio_project.dbo.NashvilleHousing
)
DELETE
From RowNumCTE
Where row_num > 1
--Order By PropertyAddress

Select *
From portfolio_project.dbo.NashvilleHousing



-- Delete unused columns

Select *
From portfolio_project.dbo.NashvilleHousing

ALTER TABLE portfolio_project.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress

ALTER TABLE portfolio_project.dbo.NashvilleHousing
DROP COLUMN SaleDate