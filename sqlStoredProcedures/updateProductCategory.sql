/****** Object:  StoredProcedure [dbo].[updateProductCategory]    Script Date: 06/12/2020 22:29:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[updateProductCategory]
	@language nvarchar(50),
    @availability nvarchar(50),
	@nameOriginal nvarchar(50),
	@category nvarchar(50)
AS
BEGIN
	IF(@availability = 'YES')
	
		UPDATE Production.ProductCategory
			SET Production.ProductCategory.Name = @category
			FROM Production.ProductCategory
			INNER JOIN Production.ProductSubcategory
			ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
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
		UPDATE Production.ProductCategory
			SET Production.ProductCategory.Name = @category
			FROM Production.ProductCategory
			INNER JOIN Production.ProductSubcategory
			ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
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