/****** Object:  StoredProcedure [dbo].[getProductsPriceNumber]    Script Date: 06/12/2020 22:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getProductsPriceNumber]
	@language nvarchar(50),
    @availability nvarchar(50),
	@minim float,
	@maxim float
AS
BEGIN
	IF(@availability = 'YES')
		SELECT COUNT(DISTINCT Production.ProductModel.Name) 
		FROM Production.ProductModel INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product ON Production.ProductModel.ProductModelID = Production.Product.ProductModelID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @language 
		AND Production.Product.SellEndDate IS NULL
		AND Production.Product.ListPrice BETWEEN @minim AND @maxim  
	ELSE
		SELECT COUNT(DISTINCT Production.ProductModel.Name)  
		FROM Production.ProductModel INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product ON Production.ProductModel.ProductModelID = Production.Product.ProductModelID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @language  
		AND Production.Product.ListPrice BETWEEN @minim AND @maxim  
END