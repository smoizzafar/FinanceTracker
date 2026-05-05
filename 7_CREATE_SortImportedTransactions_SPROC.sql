CREATE PROCEDURE SortImportedTransactions
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ImportID INT;
    SELECT @ImportID = LastImportID FROM ImportTracker;
    INSERT INTO [FinanceTracker].[dbo].[Transactions] (Amount, TransactionDate, TransactionTypeID, TransactionDescription, LastChangedDate)
    SELECT
    TransactionAmount,
    TransactionDate,
    CASE
        WHEN TransactionAmount < 0 THEN 1
        WHEN TransactionAmount > 0 THEN 2
        WHEN TransactionAmount = 0 THEN 3
        ELSE NULL
    END,
    TransactionDescription,
    GETDATE()
    FROM [FinanceTracker].[dbo].[TransactionImportTable]
    WHERE ImportID > @ImportID;
    UPDATE ImportTracker
    SET LastImportID = (SELECT MAX(ImportID) FROM TransactionImportTable);
END