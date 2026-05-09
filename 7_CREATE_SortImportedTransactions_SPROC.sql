CREATE PROCEDURE SortImportedTransactions
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ImportID INT;
	DECLARE @NewTransactions INT;

	SELECT @NewTransactions = ISNULL(MAX(TransactionID), 0) FROM dbo.Transactions;
    SELECT @ImportID = ISNULL(LastImportID, 0) FROM ImportTracker;

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

	--Classify and add new merchants
	INSERT INTO Merchants(MerchantDescription)
	SELECT DISTINCT MerchantName FROM 
	(SELECT
	CASE
		WHEN TransactionDescription LIKE '%Card xx%' THEN SUBSTRING(TransactionDescription, 0, (CHARINDEX('Card xx', TransactionDescription))-1)
		ELSE NULL
	END AS MerchantName
	FROM Transactions
	WHERE TransactionID > @NewTransactions) mn
	WHERE MerchantName IS NOT NULL
	AND NOT EXISTS (
		SELECT 1 FROM Merchants WHERE MerchantName = mn.MerchantName)

	UPDATE t
	SET MerchantID = m.MerchantID
	FROM Transactions t
	INNER JOIN Merchants m
	on m.MerchantDescription =  RTRIM(SUBSTRING(TransactionDescription, 0, (CHARINDEX('Card xx', TransactionDescription))))
	WHERE TransactionID > @NewTransactions

END