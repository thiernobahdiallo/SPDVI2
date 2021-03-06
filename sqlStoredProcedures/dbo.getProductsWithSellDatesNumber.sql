/****** Object:  StoredProcedure [dbo].[getProductsWithSellDatesNumber]    Script Date: 06/12/2020 22:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getProductsWithSellDatesNumber]
	@language nvarchar(50),
	@availability nvarchar(50)

AS
BEGIN
	IF(@availability = 'YES')
		SELECT COUNT(DISTINCT Production.ProductModel.Name)
		FROM Production.ProductModel 
		INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product
		ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
		WHERE ProductModelProductDescriptionCulture.CultureID = @language
		AND Production.ProductModel.ProductModelID IS NOT NULL
		AND Production.Product.SellEndDate IS NULL

	ELSE
		SELECT COUNT(DISTINCT Production.ProductModel.Name)
		FROM Production.ProductModel 
		INNER JOIN Production.ProductModelProductDescriptionCulture 
		ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription 
		ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		INNER JOIN Production.Product
		ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
		WHERE ProductModelProductDescriptionCulture.CultureID = @language
		AND Production.ProductModel.ProductModelID IS NOT NULL
END

