/****** Object:  StoredProcedure [dbo].[getProductsPrice]    Script Date: 06/12/2020 22:26:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getProductsPrice]
	@language nvarchar(50),
    @availability nvarchar(50),
	@minim float,
	@maxim float,
	@currentPage int,
	@productsPerPage int
AS
BEGIN
	IF(@availability = 'YES')
		SELECT DISTINCT Production.ProductModel.Name , Production.ProductDescription.Description,Production.Product.ListPrice 
		FROM Production.ProductModel INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product ON Production.ProductModel.ProductModelID = Production.Product.ProductModelID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @language 
		AND Production.Product.SellEndDate IS NULL
		AND Production.Product.ListPrice BETWEEN @minim AND @maxim  
		ORDER BY Production.ProductModel.Name
		OFFSET @currentPage * @productsPerPage ROWS
		FETCH NEXT @productsPerPage ROWS ONLY
	ELSE
		SELECT DISTINCT Production.ProductModel.Name , Production.ProductDescription.Description,Production.Product.ListPrice 
		FROM Production.ProductModel INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product ON Production.ProductModel.ProductModelID = Production.Product.ProductModelID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @language  
		AND Production.Product.ListPrice BETWEEN @minim AND @maxim  
		ORDER BY Production.ProductModel.Name
		OFFSET @currentPage * @productsPerPage ROWS
		FETCH NEXT @productsPerPage ROWS ONLY
END