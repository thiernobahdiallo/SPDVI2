/****** Object:  StoredProcedure [dbo].[getCategoryProducts]    Script Date: 06/12/2020 22:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getCategoryProducts]
	@language nvarchar(50),
    @availability nvarchar(50),
	@category nvarchar(50),
	@currentPage int,
	@productsPerPage int
AS
BEGIN
	IF(@availability = 'YES')
		SELECT DISTINCT Production.ProductModel.Name ,Description 
		FROM Production.ProductModel 
		INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product 
		ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductSubcategory 
		ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory 
		ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @language 
		AND Production.ProductCategory.Name = @category
		AND Production.Product.SellEndDate IS NULL
		AND Production.ProductModel.ProductModelID IS NOT NULL
		ORDER BY Production.ProductModel.Name
OFFSET @currentPage * @productsPerPage ROWS
FETCH NEXT @productsPerPage ROWS ONLY  
	ELSE
		SELECT DISTINCT Production.ProductModel.Name ,Description 
		FROM Production.ProductModel 
		INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product 
		ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductSubcategory 
		ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory 
		ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @language 
		AND Production.ProductCategory.Name = @category
		AND Production.ProductModel.ProductModelID IS NOT NULL
ORDER BY Production.ProductModel.Name
OFFSET @currentPage * @productsPerPage ROWS
FETCH NEXT @productsPerPage ROWS ONLY               
END