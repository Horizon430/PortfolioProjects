SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [PortfolioProject].[dbo].[NashvilleHousing]


  --Cleaning Data 
  Select*
  From PortfolioProject..NashvilleHousing


  --Standardize Data Format
  Select SaleDateConverted, CONVERT(Date,SaleDate)
  From PortfolioProject..NashvilleHousing


  Update NashvilleHousing
  SET SaleDate = CONVERT(Date, SaleDate)

  ALTER TABLE NashvilleHousing
  Add SaleDateConverted Date;

  Update NashvilleHousing
  SET SaleDateConverted = CONVERT(Date, SaleDate)


  -- Address data
	
  Select *
  From PortfolioProject..NashvilleHousing
  --Where PropertyAddress is null
  order by ParcelID

  -- a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress


  Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
  From PortfolioProject..NashvilleHousing a
  Join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null




--break address into individual column

Select PropertyAddress
From PortfolioProject..NashvilleHousing

SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address

From PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))




Select*
From PortfolioProject..NashvilleHousing


Select OwnerAddress
From PortfolioProject..NashvilleHousing


Select 
PARSENAME(Replace(OwnerAddress, ',','.'), 3),
PARSENAME(Replace(OwnerAddress, ',','.'), 2),
PARSENAME(Replace(OwnerAddress, ',','.'), 1)
From PortfolioProject..NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',','.'), 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',','.'), 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',','.'), 1)



Select*
From PortfolioProject..NashvilleHousing


--Change Y and N to Yes, No in Solid as Vacant

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
order by 2


Select SoldAsVacant,
CASE When SoldAsVacant = 'Y' Then 'Yes'
	When SoldAsVacant='N' Then 'Not'
	Else SoldAsVacant
	End
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	When SoldAsVacant='N' Then 'Not'
	Else SoldAsVacant
	End

--Remove Duplicates
Select*,
	ROW_NUMBER() Over (
	Partition By ParcelID,
				 PropertyAddress, 
				 SalePrice, 
				 SaleDate, 
				 LegalReference
				 Order By
				 UniqueID)row_num

From PortfolioProject..NashvilleHousing
order by ParcelID

Select*
From PortfolioProject..NashvilleHousing

Alter Table PortfolioProject..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table PortfolioProject..NashvilleHousing
Drop Column SaleDate

