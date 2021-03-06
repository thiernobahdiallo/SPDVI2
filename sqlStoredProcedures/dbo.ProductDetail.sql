/****** Object:  StoredProcedure [dbo].[getProductDetail]    Script Date: 06/12/2020 22:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getProductDetail]
	@language nvarchar(50),
    @availability nvarchar(50),
	@name nvarchar(50)
AS
BEGIN
	IF(@availability = 'YES')
		SELECT Production.ProductModel.Name AS Name, 
		Production.ProductDescription.Description AS Description,Production.
		Product.ProductNumber, Production.Product.Color, 
		Production.Product.ListPrice, 
		Production.Product.Size, 
		Production.Product.ProductLine, 
		Production.Product.Class, 
		Production.Product.Style, 
		Production.ProductCategory.Name AS Category, 
		Production.ProductSubcategory.Name AS SubCategory 
		FROM Production.Product 
		INNER JOIN Production.ProductSubcategory 
		ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory 
		ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel 
		ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
		AND Product.ProductModelID IS NOT NULL AND Production.ProductModel.Name = @name
		AND Production.Product.SellEndDate IS NULL
		AND Production.ProductModel.ProductModelID IS NOT NULL
	ELSE
		SELECT Production.ProductModel.Name AS Name, 
		Production.ProductDescription.Description AS Description,Production.
		Product.ProductNumber, Production.Product.Color, 
		Production.Product.ListPrice, 
		Production.Product.Size, 
		Production.Product.ProductLine, 
		Production.Product.Class, 
		Production.Product.Style, 
		Production.ProductCategory.Name AS Category, 
		Production.ProductSubcategory.Name AS SubCategory 
		FROM Production.Product 
		INNER JOIN Production.ProductSubcategory 
		ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory 
		ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel 
		ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
		AND Product.ProductModelID IS NOT NULL AND Production.ProductModel.Name = @name
                                                   
END