/****** Object:  StoredProcedure [dbo].[getProductsStyle]    Script Date: 06/12/2020 22:27:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getProductsStyle]
	@language nvarchar(50),
    @availability nvarchar(50),
	@style nvarchar(50),
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
		WHERE ProductModelProductDescriptionCulture.CultureID = @language 
		AND Production.Product.Style = @style 
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
		WHERE ProductModelProductDescriptionCulture.CultureID = @language 
		AND Production.Product.Style = @style 
		AND Production.ProductModel.ProductModelID IS NOT NULL
        ORDER BY Production.ProductModel.Name
		OFFSET @currentPage * @productsPerPage ROWS
		FETCH NEXT @productsPerPage ROWS ONLY                            
END