/****** Object:  StoredProcedure [dbo].[updateProductDescription]    Script Date: 06/12/2020 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[updateProductDescription]
	@language nvarchar(50),
    @availability nvarchar(50),
	@nameOriginal nvarchar(50),
	@descriptionOriginal nvarchar(50),
	@description nvarchar (50)
AS
BEGIN
	IF(@availability = 'YES')
	
		UPDATE Production.ProductDescription
			SET  Production.ProductDescription.Description = @description
			FROM Production.ProductDescription
			INNER JOIN Production.ProductModelProductDescriptionCulture
			ON Production.ProductDescription.ProductDescriptionID = Production.ProductModelProductDescriptionCulture.ProductDescriptionID
			INNER JOIN Production.ProductModel 
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID
			INNER JOIN Production.Product
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
			WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Product.ProductModelID IS NOT NULL 
			AND Production.ProductModel.Name = @nameOriginal
			AND Production.ProductDescription.Description = @descriptionOriginal
			AND Production.Product.SellEndDate IS NULL
			AND Production.ProductModel.ProductModelID IS NOT NULL
		ELSE
		UPDATE Production.ProductDescription
			SET  Production.ProductDescription.Description = @description
			FROM Production.ProductDescription
			INNER JOIN Production.ProductModelProductDescriptionCulture
			ON Production.ProductDescription.ProductDescriptionID = Production.ProductModelProductDescriptionCulture.ProductDescriptionID
			INNER JOIN Production.ProductModel 
			ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID
			INNER JOIN Production.Product
			ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID
			WHERE Production.ProductModelProductDescriptionCulture.CultureID = @language 
			AND Product.ProductModelID IS NOT NULL 
			AND Production.ProductModel.Name = @nameOriginal
			AND Production.ProductDescription.Description = @descriptionOriginal
			AND Production.ProductModel.ProductModelID IS NOT NULL
END