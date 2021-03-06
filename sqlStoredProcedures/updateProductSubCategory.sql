/****** Object:  StoredProcedure [dbo].[updateProductSubCategory]    Script Date: 06/12/2020 22:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[updateProductSubCategory]
	@language nvarchar(50),
    @availability nvarchar(50),
	@nameOriginal nvarchar(50),
	@subCategory nvarchar(50)
AS
BEGIN
	IF(@availability = 'YES')
	
		UPDATE Production.ProductSubcategory
			SET Production.ProductSubcategory.Name = @subCategory
			FROM Production.ProductSubcategory
			INNER JOIN Production.Product
			ON Production.ProductSubcategory.ProductSubcategoryID = Production.Product.ProductSubcategoryID
			INNER JOIN Production.ProductModel
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
			INNER JOIN Production.ProductModelProductDescriptionCulture
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID
			WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Product.ProductModelID IS NOT NULL 
			AND Production.ProductModel.Name = @nameOriginal
			AND Production.Product.SellEndDate IS NULL
			AND Production.ProductModel.ProductModelID IS NOT NULL

		ELSE
		UPDATE Production.ProductSubcategory
			SET Production.ProductSubcategory.Name = @subCategory
			FROM Production.ProductSubcategory
			INNER JOIN Production.Product
			ON Production.ProductSubcategory.ProductSubcategoryID = Production.Product.ProductSubcategoryID
			INNER JOIN Production.ProductModel
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
			INNER JOIN Production.ProductModelProductDescriptionCulture
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID
			WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Product.ProductModelID IS NOT NULL 
			AND Production.ProductModel.Name = @nameOriginal
			AND Production.ProductModel.ProductModelID IS NOT NULL

END