/*using VARCHAR on CategoryDescription and 
MerchantDescription as these tables will 
be populated in plain english only */

CREATE TABLE Categories (
CategoryID INT IDENTITY(1,1)
	CONSTRAINT PK_Categories PRIMARY KEY,
CategoryDescription VARCHAR(100) NOT NULL
)

CREATE TABLE Merchants(
MerchantID INT IDENTITY(1,1)
	CONSTRAINT PK_Merchants PRIMARY KEY,
MerchantDescription VARCHAR(100) NOT NULL
)
