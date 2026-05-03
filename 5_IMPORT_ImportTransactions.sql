BULK INSERT dbo.StagingImportTable
FROM '\data\DummyTransactions.csv' --insert exact path of import csv
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 1,
	TABLOCK
	);

INSERT INTO dbo.TransactionImportTable (TransactionDate, TransactionAmount, TransactionDescription, RunningBalance, ImportedDate)
SELECT
	CONVERT(DATE, [DATE], 103),
	Amount,
	Description,
	RunningTotal,
	GETDATE()
FROM dbo.StagingImportTable;