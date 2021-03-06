/****** Object:  StoredProcedure [dbo].[updateProduct]    Script Date: 06/12/2020 22:29:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[updateProduct]
	@language nvarchar(50),
    @availability nvarchar(50),
	@nameOriginal nvarchar(50),
	@nameNew nvarchar(50),
	@color nvarchar(50),
	@productLine nvarchar(50),
	@productNumber nvarchar(50),
	@price float,
	@size nvarchar(50),
	@style nvarchar(50),
	@class nvarchar(50)
AS
BEGIN
	IF(@availability = 'YES')
	
		UPDATE Production.Product
			SET Product.ProductNumber = @productNumber,
			Production.Product.Color = @color,
			Production.Product.ListPrice = @price,
			Production.Product.Size = @size,
			Production.Product.ProductLine = @productLine,
			Production.Product.Class = @class,
			Production.Product.Style = @style
			FROM Production.Product 
			INNER JOIN Production.ProductModel 
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
			INNER JOIN Production.ProductModelProductDescriptionCulture 
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
			INNER JOIN Production.ProductDescription 
			ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
			WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Product.ProductModelID IS NOT NULL 
			AND Production.ProductModel.Name = @nameOriginal
			AND Production.Product.SellEndDate IS NULL
			AND Production.ProductModel.ProductModelID IS NOT NULL
		ELSE
		UPDATE Production.Product
			SET Product.ProductNumber = @productNumber,
			Production.Product.Color = @color,
			Production.Product.ListPrice = @price,
			Production.Product.Size = @size,
			Production.Product.ProductLine = @productLine,
			Production.Product.Class = @class,
			Production.Product.Style = @style
			FROM Production.Product 
			INNER JOIN Production.ProductModel 
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
			INNER JOIN Production.ProductModelProductDescriptionCulture 
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
			INNER JOIN Production.ProductDescription 
			ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
			WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Product.ProductModelID IS NOT NULL 
			AND Production.ProductModel.Name = @nameOriginal
			AND Production.ProductModel.ProductModelID IS NOT NULL
END