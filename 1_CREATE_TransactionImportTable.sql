CREATE TABLE TransactionImportTable (
ImportID INT IDENTITY(1, 1)
	CONSTRAINT PK_TransactionImportTable PRIMARY KEY,
TransactionDate DATE NOT NULL,
TransactionAmount MONEY NOT NULL,
TransactionDescription NVARCHAR(200) NOT NULL,
RunningBalance MONEY NOT NULL,
ImportedDate DATETIME DEFAULT (GETDATE()) NOT NULL,
	CONSTRAINT UQ_TransactionImportTable UNIQUE (TransactionDate, TransactionAmount, TransactionDescription, RunningBalance)
)
