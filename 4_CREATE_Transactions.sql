CREATE TABLE Transactions (
TransactionID INT IDENTITY(1,1)
	CONSTRAINT PK_Transactions PRIMARY KEY,
Amount MONEY NOT NULL,
TransactionDate DATE NOT NULL,
TransactionTypeID INT NOT NULL,
	CONSTRAINT FK_Transactions_TransactionType FOREIGN KEY (TransactionTypeID)
	REFERENCES TransactionTypes (TypeID),
TransactionDescription NVARCHAR(200) NOT NULL,
CategoryID INT,
	CONSTRAINT FK_Transactions_Categories FOREIGN KEY (CategoryID)
	REFERENCES Categories (CategoryID),
MerchantID INT,
	CONSTRAINT FK_Transactions_Merchants FOREIGN KEY (MerchantID)
	REFERENCES Merchants (MerchantID),
LastChangedDate DATETIME NOT NULL
	DEFAULT GETDATE()
)
