/****** Object:  StoredProcedure [dbo].[updateProductModel]    Script Date: 06/12/2020 22:30:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[updateProductModel]
	@language nvarchar(50),
    @availability nvarchar(50),
	@nameOriginal nvarchar(50),
	@nameNew nvarchar(50)
AS
BEGIN
	IF(@availability = 'YES')
	
		UPDATE Production.ProductModel
			SET Production.ProductModel.Name = @nameNew
			FROM Production.ProductModel
			INNER JOIN Production.Product
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
			INNER JOIN Production.ProductModelProductDescriptionCulture 
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
			INNER JOIN Production.ProductDescription 
			ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
			WHERE Production.ProductModel.Name = @nameOriginal
			AND Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Production.Product.SellEndDate IS NULL
		ELSE
		UPDATE Production.ProductModel
			SET Production.ProductModel.Name = @nameNew
			FROM Production.ProductModel
			INNER JOIN Production.Product
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
			INNER JOIN Production.ProductModelProductDescriptionCulture 
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
			INNER JOIN Production.ProductDescription 
			ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
			WHERE Production.ProductModel.Name = @nameOriginal
			AND Production.ProductModelProductDescriptionCulture.CultureID = @language 
		                                           
END