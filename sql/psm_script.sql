----Stored procedures with transaction management and error handling
USE G;
GO

-- Drop existing stored procedures if they exist
IF OBJECT_ID('usp_GetCustomerTotalAmount', 'P') IS NOT NULL
   DROP PROCEDURE usp_GetCustomerTotalAmount;
GO
IF OBJECT_ID('usp_InsertProduct', 'P') IS NOT NULL
   DROP PROCEDURE usp_InsertProduct;
GO
IF OBJECT_ID('usp_CountPaymentsByStatus', 'P') IS NOT NULL
   DROP PROCEDURE usp_CountPaymentsByStatus;
GO

-- Stored Procedure 1: Get total amount for a customer
ALTER PROCEDURE usp_GetCustomerTotalAmount
   @CustomerID INT,
   @TotalAmount DECIMAL(10,2) OUTPUT,
   @message NVARCHAR(255) OUTPUT
AS
BEGIN
   BEGIN TRY
       -- Check if the CustomerID exists
       IF NOT EXISTS (SELECT 1 FROM Individual_Order WHERE CustomerID = @CustomerID)
       BEGIN
           -- Handle non-existent customer
           SET @message = 'Error: Customer ID ' + CAST(@CustomerID AS NVARCHAR) + ' does not exist in the order database.';
           SET @TotalAmount = 0;
           RETURN;
       END


       -- Check if the CustomerID is negative
       IF @CustomerID < 0
       BEGIN
           -- Handle negative CustomerID
           SET @message = 'Error: Invalid Customer ID. Customer ID cannot be negative.';
           SET @TotalAmount = 0;
           RETURN;
       END


       BEGIN TRANSACTION;
       SELECT @TotalAmount = SUM(TotalAmount)/0
       FROM Individual_Order
       WHERE CustomerID = @CustomerID;


       -- Check if @TotalAmount is NULL (no orders found)
       IF @TotalAmount IS NULL
       BEGIN
           SET @TotalAmount = 0;
           SET @message = 'Customer has no orders.';
       END
       ELSE
       BEGIN
           SET @message = 'Success: Total amount calculated.';
       END
      
       COMMIT;
   END TRY
   BEGIN CATCH
       IF @@TRANCOUNT > 0
           ROLLBACK;


       -- Get detailed error information
       DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
       DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
       DECLARE @ErrorState INT = ERROR_STATE();
       DECLARE @ErrorNumber INT = ERROR_NUMBER();
      
       -- Create more specific error messages based on error number
       IF @ErrorNumber = 8134 -- Division by zero error
       BEGIN
           SET @message = 'Error: Division by zero occurred during calculation.';
       END
       ELSE
       BEGIN
           SET @message = 'Error: ' + @ErrorMessage;
       END
      
       SET @TotalAmount = 0;
   END CATCH
END;
GO

-- Declare variables for testing
DECLARE @CustomerID INT
DECLARE @TotalAmount DECIMAL(10,2)
DECLARE @Message NVARCHAR(255)


-- Test Case 4: Division by zero error (for testing error handling)
SET @CustomerID = 1 -- Using a valid customer ID
EXEC usp_GetCustomerTotalAmount @CustomerID, @TotalAmount OUTPUT, @Message OUTPUT
SELECT @Message AS Message



-- Test Case 3: Negative customer ID
SET @CustomerID = -1
EXEC usp_GetCustomerTotalAmount @CustomerID, @TotalAmount OUTPUT, @Message OUTPUT
SELECT @Message AS Message


-- Test Case 2: Customer doesn't exist
PRINT '=== Test Case 2: Non-existent Customer ==='
SET @CustomerID = 9999 -- Assuming this customer doesn't exist
EXEC usp_GetCustomerTotalAmount @CustomerID, @TotalAmount OUTPUT, @Message OUTPUT
SELECT @Message AS Message
PRINT 'Customer ID: ' + CAST(@CustomerID AS NVARCHAR)
PRINT 'Total Amount: ' + CAST(@TotalAmount AS NVARCHAR)
PRINT 'Message: ' + @Message
PRINT ''


-- Test Case 1: Customer exists with orders
PRINT '=== Test Case 1: Valid Customer with Orders ==='
SET @CustomerID = 1 -- Assuming customer 1 exists and has orders
EXEC usp_GetCustomerTotalAmount @CustomerID, @TotalAmount OUTPUT, @Message OUTPUT
SELECT @Message AS Message
PRINT 'Customer ID: ' + CAST(@CustomerID AS NVARCHAR)
PRINT 'Total Amount: ' + CAST(@TotalAmount AS NVARCHAR)
PRINT 'Message: ' + @Message
PRINT ''



--STORED PROCEDURE 2 

CREATE PROCEDURE usp_InsertProduct
   @SupplierID INT,
   @WarehouseID INT,
   @ProductName VARCHAR(255),
   @Description VARCHAR(MAX),
   @Price DECIMAL(10,2),
   @Category VARCHAR(100),
   @StockQuantity INT,
   @Rating DECIMAL(2,1),
   @NewProductID INT OUTPUT,
   @Message NVARCHAR(255) OUTPUT -- Added output parameter for error messages
AS
BEGIN
   -- Initialize output parameters
   SET @NewProductID = -1;
   SET @Message = '';
  
   -- Validate input parameters
   IF @SupplierID IS NULL OR NOT EXISTS (SELECT 1 FROM Supplier WHERE SupplierID = @SupplierID)
   BEGIN
       SET @Message = 'Error: Invalid or non-existent Supplier ID.';
       RETURN;
   END
  
   IF @WarehouseID IS NULL OR NOT EXISTS (SELECT 1 FROM Warehouse WHERE WarehouseID = @WarehouseID)
   BEGIN
       SET @Message = 'Error: Invalid or non-existent Warehouse ID.';
       RETURN;
   END
  
   IF @ProductName IS NULL OR LEN(TRIM(@ProductName)) = 0
   BEGIN
       SET @Message = 'Error: Product name cannot be empty.';
       RETURN;
   END
  
   IF @Price IS NULL OR @Price < 0
   BEGIN
       SET @Message = 'Error: Product price must be non-negative.';
       RETURN;
   END
  
   IF @StockQuantity IS NULL OR @StockQuantity < 0
   BEGIN
       SET @Message = 'Error: Stock quantity must be non-negative.';
       RETURN;
   END
  
   IF @Rating IS NULL OR @Rating < 0 OR @Rating > 5
   BEGIN
       SET @Message = 'Error: Product rating must be between 0 and 5.';
       RETURN;
   END
  
   BEGIN TRY
       BEGIN TRANSACTION;
       INSERT INTO Product (SupplierID, WarehouseID, ProductName, Description, Price, Category, StockQuantity, Rating)
       VALUES (@SupplierID, @WarehouseID, @ProductName, @Description, @Price, @Category, @StockQuantity, @Rating);
       SET @NewProductID = SCOPE_IDENTITY();
       SET @Message = 'Success: Product inserted successfully with ID: ' + CAST(@NewProductID AS NVARCHAR);
       COMMIT;
   END TRY
   BEGIN CATCH
       IF @@TRANCOUNT > 0
           ROLLBACK;
          
       -- Get detailed error information
       DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
       DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
       DECLARE @ErrorState INT = ERROR_STATE();
       DECLARE @ErrorNumber INT = ERROR_NUMBER();
      
       -- Handle specific errors with meaningful messages
       IF @ErrorNumber = 2627 OR @ErrorNumber = 2601 -- Unique constraint violation
       BEGIN
           SET @Message = 'Error: Product with this name already exists.';
       END
       ELSE IF @ErrorNumber = 547 -- Constraint violation (foreign key)
       BEGIN
           SET @Message = 'Error: Invalid reference to Supplier or Warehouse.';
       END
       ELSE IF @ErrorNumber = 8115 -- Arithmetic overflow error
       BEGIN
           SET @Message = 'Error: One of the numeric values is too large for its column.';
       END
       ELSE IF @ErrorNumber = 515 -- NULL value insert violation
       BEGIN
           SET @Message = 'Error: Required field missing.';
       END
       ELSE -- Generic error
       BEGIN
           SET @Message = 'Error: ' + @ErrorMessage;
       END
      
       -- Set output parameter
       SET @NewProductID = -1;
   END CATCH
END;
GO

-- Declare variables for testing
DECLARE @NewProductID INT
DECLARE @Message NVARCHAR(255)

-- Test Case 5: Invalid rating (out of range)
PRINT '=== Test Case 5: Invalid Rating ==='
EXEC usp_InsertProduct
   @SupplierID = 1,
   @WarehouseID = 1,
   @ProductName = 'Test Product Invalid Rating',
   @Description = 'This product has an invalid rating',
   @Price = 99.99,
   @Category = 'Test',
   @StockQuantity = 10,
   @Rating = 6.0,
   @NewProductID = @NewProductID OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Message AS Message


-- Test Case 4: Negative price
PRINT '=== Test Case 4: Negative Price ==='
EXEC usp_InsertProduct
   @SupplierID = 1,
   @WarehouseID = 1,
   @ProductName = 'Test Product Negative Price',
   @Description = 'This product has a negative price',
   @Price = -10.00,
   @Category = 'Test',
   @StockQuantity = 10,
   @Rating = 4.0,
   @NewProductID = @NewProductID OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Message AS Message

-- Test Case 3: Empty product name
PRINT '=== Test Case 3: Empty Product Name ==='
EXEC usp_InsertProduct
   @SupplierID = 1,
   @WarehouseID = 1,
   @ProductName = '',
   @Description = 'This product has an empty name',
   @Price = 99.99,
   @Category = 'Test',
   @StockQuantity = 10,
   @Rating = 4.0,
   @NewProductID = @NewProductID OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Message AS Message

-- Test Case 2: Invalid supplier ID
PRINT '=== Test Case 2: Invalid Supplier ID ==='
EXEC usp_InsertProduct
   @SupplierID = 9999,
   @WarehouseID = 1,
   @ProductName = 'Test Product Invalid Supplier',
   @Description = 'This product has an invalid supplier',
   @Price = 99.99,
   @Category = 'Test',
   @StockQuantity = 10,
   @Rating = 4.0,
   @NewProductID = @NewProductID OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Message AS Message

-- Test Case 1: Valid product insertion
PRINT '=== Test Case 1: Valid Product Insertion ==='
EXEC usp_InsertProduct
   @SupplierID = 1,
   @WarehouseID = 1,
   @ProductName = 'Test Product 1',
   @Description = 'This is a test product',
   @Price = 99.99,
   @Category = 'Test',
   @StockQuantity = 10,
   @Rating = 4.0,
   @NewProductID = @NewProductID OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Message AS Message

--STORED PROCEDURE 3

CREATE PROCEDURE usp_CountPaymentsByStatus
   @Status VARCHAR(50),
   @Count INT OUTPUT,
   @Message NVARCHAR(255) OUTPUT -- Added message parameter
AS
BEGIN
   -- Initialize output parameters
   SET @Count = 0;
   SET @Message = '';
  
   -- Validate input parameters
   IF @Status IS NULL OR LEN(TRIM(@Status)) = 0
   BEGIN
       SET @Message = 'Error: Payment status cannot be empty.';
       SET @Count = -1;
       RETURN;
   END
  
   -- Check if the status is valid (assuming you have a set of valid statuses)
   IF @Status NOT IN ('Pending', 'Processing', 'Completed', 'Failed', 'Refunded', 'Cancelled')
   BEGIN
       SET @Message = 'Error: Invalid payment status. Valid statuses are: Pending, Processing, Completed, Failed, Refunded, Cancelled.';
       SET @Count = -1;
       RETURN;
   END
  
   BEGIN TRY
       BEGIN TRANSACTION;
       SELECT @Count = COUNT(*)
       FROM Payment
       WHERE PaymentStatus = @Status;
      
       -- Set success message
       SET @Message = 'Success: Found ' + CAST(@Count AS NVARCHAR) + ' payment(s) with status "' + @Status + '".';
       COMMIT;
   END TRY
   BEGIN CATCH
       IF @@TRANCOUNT > 0
           ROLLBACK;
          
       -- Get detailed error information
       DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
       DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
       DECLARE @ErrorState INT = ERROR_STATE();
      
       -- Set error message
       SET @Message = 'Error: ' + @ErrorMessage;
       SET @Count = -1;
   END CATCH
END;
GO


-- Declare variables for testing
DECLARE @Count INT
DECLARE @Message NVARCHAR(255)

-- Test Case 4: Invalid status
PRINT '=== Test Case 5: Invalid Payment Status ==='
EXEC usp_CountPaymentsByStatus
   @Status = 'InvalidStatus',
   @Count = @Count OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Count AS InvalidStatusCount, @Message AS Message


-- Test Case 3: Empty status
PRINT '=== Test Case 3: Empty Payment Status ==='
EXEC usp_CountPaymentsByStatus
   @Status = '',
   @Count = @Count OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Count AS EmptyStatusCount, @Message AS Message


-- Test Case 2: Valid payment status (Pending)
PRINT '=== Test Case 2: Valid Payment Status (Pending) ==='
EXEC usp_CountPaymentsByStatus
   @Status = 'Pending',
   @Count = @Count OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Count AS PendingPaymentsCount, @Message AS Message

-- Test Case 1: Valid payment status (Completed)
PRINT '=== Test Case 1: Valid Payment Status (Completed) ==='
EXEC usp_CountPaymentsByStatus
   @Status = 'Completed',
   @Count = @Count OUTPUT,
   @Message = @Message OUTPUT;
SELECT @Count AS CompletedPaymentsCount, @Message AS Message


--Triggers
USE G;
GO

IF OBJECT_ID('EncryptPhoneNumberTrigger', 'TR') IS NOT NULL
   DROP TRIGGER EncryptPhoneNumberTrigger;
GO
IF OBJECT_ID('UpdateTotalAmountTrigger', 'TR') IS NOT NULL
   DROP TRIGGER UpdateTotalAmountTrigger;
GO
IF OBJECT_ID('ShippingStatusTrigger', 'TR') IS NOT NULL
   DROP TRIGGER ShippingStatusTrigger;
GO


-- EncryptPhoneNumberTrigger Trigger:
-- Step 1: Create a database master key if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
   CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword123!';
   PRINT 'Database Master Key created.';
END
ELSE
   PRINT 'Database Master Key already exists.';
GO


-- Step 2: Create a certificate if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'DAMGCertificate')
BEGIN
   CREATE CERTIFICATE DAMGCertificate
   WITH SUBJECT = 'Certificate for Data Protection';
   PRINT 'Certificate created.';
END
ELSE
   PRINT 'Certificate already exists.';
GO


-- Step 3: Create a symmetric key if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'DAMGSymmetricKey')
BEGIN
   CREATE SYMMETRIC KEY DAMGSymmetricKey
   WITH ALGORITHM = AES_256
   ENCRYPTION BY CERTIFICATE DAMGCertificate;
   PRINT 'Symmetric Key created.';
END
ELSE
   PRINT 'Symmetric Key already exists.';
GO


-- Step 4: Make sure the EncryptedPhoneNumber column exists
IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE Name = 'EncryptedPhoneNumber'
               AND Object_ID = Object_ID('Customer'))
BEGIN
   ALTER TABLE Customer
   ADD EncryptedPhoneNumber VARBINARY(MAX) NULL;
   PRINT 'EncryptedPhoneNumber column added.';
END
ELSE
   PRINT 'EncryptedPhoneNumber column already exists.';
GO


-- Step 5: Recreate the trigger
CREATE OR ALTER TRIGGER EncryptPhoneNumberTrigger
ON Customer
AFTER INSERT, UPDATE
AS
BEGIN
   SET NOCOUNT ON;
  
   IF UPDATE(PhoneNumber)
   BEGIN
       OPEN SYMMETRIC KEY DAMGSymmetricKey DECRYPTION BY CERTIFICATE DAMGCertificate;
      
       UPDATE c
       SET c.EncryptedPhoneNumber = ENCRYPTBYKEY(KEY_GUID('DAMGSymmetricKey'), i.PhoneNumber)
       FROM Customer c
       INNER JOIN inserted i ON c.CustomerID = i.CustomerID
       WHERE i.PhoneNumber IS NOT NULL;
      
       CLOSE SYMMETRIC KEY DAMGSymmetricKey;
   END
END;
GO


-- Individual_Order Trigger: Recalculate TotalAmount on Individual_Order
CREATE TRIGGER UpdateTotalAmountTrigger
ON Individual_Order
AFTER INSERT, UPDATE
AS
BEGIN
   SET NOCOUNT ON;
   UPDATE IO
   SET TotalAmount = I.Price * I.Quantity
   FROM Individual_Order AS IO
   INNER JOIN inserted AS I ON IO.OrderID = I.OrderID;
END;
GO


-- Shipping Trigger: Automatically update ShippingStatus
CREATE TRIGGER ShippingStatusTrigger
ON Shipping
AFTER UPDATE
AS
BEGIN
   SET NOCOUNT ON;
   UPDATE S
   SET ShippingStatus = 'Delivered'
   FROM Shipping S
   JOIN inserted I ON S.ShippingID = I.ShippingID
   WHERE I.EstimatedDeliveryDate <= CONVERT(date, GETDATE())
     AND S.ShippingStatus <> 'Delivered';
END;
GO

----- TEST -----
-- 1. Test encryption trigger: Encrypt PhoneNumber on Customer
-- INSERT a new customer, trigger the encryption trigger
INSERT INTO Customer (Email, FirstName, LastName, PhoneNumber)
VALUES ('newtest@example.com', 'Test', 'User', '9998887777');
-- Query the newly inserted record and verify PhoneNumber and EncryptedPhoneNumber
SELECT CustomerID, Email, PhoneNumber, EncryptedPhoneNumber
FROM Customer
WHERE Email = 'newtest@example.com';
GO
-- UPDATE PhoneNumber
UPDATE Customer
SET PhoneNumber = '7778889999'
WHERE Email = 'newtest@example.com';
-- Query updated records
SELECT CustomerID, Email, PhoneNumber, EncryptedPhoneNumber
FROM Customer
WHERE Email = 'newtest@example.com';
GO

-- 2. Test Individual_Order trigger: Automatically calculating when inserting an order
-- INSERT order data
INSERT INTO Individual_Order (CustomerID, ProductID, OrderDate, TotalAmount, Quantity, Price)
VALUES (1, 1, GETDATE(), 0, 3, 1810.99);
-- SELECT the newly inserted order and verify the TotalAmount
SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Price, TotalAmount
FROM Individual_Order
WHERE CustomerID = 1 AND Price = 1810.99
GO
-- UPDATE the order record and modify the Quantity and Price
UPDATE Individual_Order
SET Quantity = 10, Price = 780.89
WHERE CustomerID = 1 AND Price = 1810.99
-- Query the updated record to verify whether the trigger recalculates TotalAmount
SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Price, TotalAmount
FROM Individual_Order
WHERE CustomerID = 1 AND Price = 780.89
GO

-- 3. Test Shipping Trigger: Automatically update ShippingStatus
-- INSERT a Shipping record, set EstimatedDeliveryDate to yesterday and ShippingStatus to Shipped
INSERT INTO Shipping (OrderID, AddressID, ShippingMethod, EstimatedDeliveryDate, ShippingStatus)
VALUES (1, 1, 'UPS', DATEADD(day, -1, GETDATE()), 'Shipped');
-- Simulate update operation
DECLARE @NewShippingID INT = SCOPE_IDENTITY();
UPDATE Shipping
SET EstimatedDeliveryDate = DATEADD(day, -2, GETDATE())
WHERE ShippingID = @NewShippingID;
-- Query the Shipping table to confirm whether ShippingStatus has been updated to Delivered
SELECT * FROM Shipping WHERE ShippingID = @NewShippingID;
GO


---Triggers 
USE G;
GO

IF OBJECT_ID('EncryptPhoneNumberTrigger', 'TR') IS NOT NULL
    DROP TRIGGER EncryptPhoneNumberTrigger;
GO
IF OBJECT_ID('UpdateTotalAmountTrigger', 'TR') IS NOT NULL
    DROP TRIGGER UpdateTotalAmountTrigger;
GO
IF OBJECT_ID('ShippingStatusTrigger', 'TR') IS NOT NULL
    DROP TRIGGER ShippingStatusTrigger;
GO

-- EncryptPhoneNumberTrigger Trigger:
-- Step 1: Create a database master key if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword123!';
    PRINT 'Database Master Key created.';
END
ELSE
    PRINT 'Database Master Key already exists.';
GO

-- Step 2: Create a certificate if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'DAMGCertificate')
BEGIN
    CREATE CERTIFICATE DAMGCertificate
    WITH SUBJECT = 'Certificate for Data Protection';
    PRINT 'Certificate created.';
END
ELSE
    PRINT 'Certificate already exists.';
GO

-- Step 3: Create a symmetric key if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'DAMGSymmetricKey')
BEGIN
    CREATE SYMMETRIC KEY DAMGSymmetricKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE DAMGCertificate;
    PRINT 'Symmetric Key created.';
END
ELSE
    PRINT 'Symmetric Key already exists.';
GO

-- Step 4: Make sure the EncryptedPhoneNumber column exists
IF NOT EXISTS (SELECT 1 FROM sys.columns 
                WHERE Name = 'EncryptedPhoneNumber'
                AND Object_ID = Object_ID('Customer'))
BEGIN
    ALTER TABLE Customer
    ADD EncryptedPhoneNumber VARBINARY(MAX) NULL;
    PRINT 'EncryptedPhoneNumber column added.';
END
ELSE
    PRINT 'EncryptedPhoneNumber column already exists.';
GO

-- Step 5: Recreate the trigger
CREATE OR ALTER TRIGGER EncryptPhoneNumberTrigger
ON Customer
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(PhoneNumber)
    BEGIN
        OPEN SYMMETRIC KEY DAMGSymmetricKey DECRYPTION BY CERTIFICATE DAMGCertificate;
        
        UPDATE c
        SET c.EncryptedPhoneNumber = ENCRYPTBYKEY(KEY_GUID('DAMGSymmetricKey'), i.PhoneNumber)
        FROM Customer c
        INNER JOIN inserted i ON c.CustomerID = i.CustomerID
        WHERE i.PhoneNumber IS NOT NULL;
        
        CLOSE SYMMETRIC KEY DAMGSymmetricKey;
    END
END;
GO


-- Individual_Order Trigger: Recalculate TotalAmount on Individual_Order
CREATE TRIGGER UpdateTotalAmountTrigger
ON Individual_Order
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE IO
    SET TotalAmount = I.Price * I.Quantity
    FROM Individual_Order AS IO
    INNER JOIN inserted AS I ON IO.OrderID = I.OrderID;
END;
GO

-- Shipping Trigger: Automatically update ShippingStatus
CREATE TRIGGER ShippingStatusTrigger
ON Shipping
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE S
    SET ShippingStatus = 'Delivered'
    FROM Shipping S
    JOIN inserted I ON S.ShippingID = I.ShippingID
    WHERE I.EstimatedDeliveryDate <= CONVERT(date, GETDATE())
      AND S.ShippingStatus <> 'Delivered';
END;
GO


----- TEST -----
-- 1. Test encryption trigger: Encrypt PhoneNumber on Customer
-- INSERT a new customer, trigger the encryption trigger
INSERT INTO Customer (Email, FirstName, LastName, PhoneNumber)
VALUES ('newtest@example.com', 'Test', 'User', '9998887777');
-- Query the newly inserted record and verify PhoneNumber and EncryptedPhoneNumber
SELECT CustomerID, Email, PhoneNumber, EncryptedPhoneNumber
FROM Customer
WHERE Email = 'newtest@example.com';
GO
-- UPDATE PhoneNumber
UPDATE Customer
SET PhoneNumber = '7778889999'
WHERE Email = 'newtest@example.com';
-- Query updated records
SELECT CustomerID, Email, PhoneNumber, EncryptedPhoneNumber
FROM Customer
WHERE Email = 'newtest@example.com';
GO

-- 2. Test Individual_Order trigger: Automatically calculating when inserting an order
-- INSERT order data
INSERT INTO Individual_Order (CustomerID, ProductID, OrderDate, TotalAmount, Quantity, Price)
VALUES (1, 1, GETDATE(), 0, 3, 1810.99);
-- SELECT the newly inserted order and verify the TotalAmount
SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Price, TotalAmount
FROM Individual_Order
WHERE CustomerID = 1 AND Price = 1810.99
GO
-- UPDATE the order record and modify the Quantity and Price
UPDATE Individual_Order
SET Quantity = 10, Price = 780.89
WHERE CustomerID = 1 AND Price = 1810.99
-- Query the updated record to verify whether the trigger recalculates TotalAmount
SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Price, TotalAmount
FROM Individual_Order
WHERE CustomerID = 1 AND Price = 780.89
GO

-- 3. Test Shipping Trigger: Automatically update ShippingStatus
-- INSERT a Shipping record, set EstimatedDeliveryDate to yesterday and ShippingStatus to Shipped
INSERT INTO Shipping (OrderID, AddressID, ShippingMethod, EstimatedDeliveryDate, ShippingStatus)
VALUES (1, 1, 'UPS', DATEADD(day, -1, GETDATE()), 'Shipped');
-- Simulate update operation
DECLARE @NewShippingID INT = SCOPE_IDENTITY();
UPDATE Shipping
SET EstimatedDeliveryDate = DATEADD(day, -2, GETDATE())
WHERE ShippingID = @NewShippingID;
-- Query the Shipping table to confirm whether ShippingStatus has been updated to Delivered
SELECT * FROM Shipping WHERE ShippingID = @NewShippingID;
GO
