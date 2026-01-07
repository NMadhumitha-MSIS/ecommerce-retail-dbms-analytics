USE G;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_Customer_LastName' AND object_id = OBJECT_ID('Customer'))
    DROP INDEX idx_Customer_LastName ON Customer;
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_Product_Category' AND object_id = OBJECT_ID('Product'))
    DROP INDEX idx_Product_Category ON Product;
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_IndividualOrder_OrderDate' AND object_id = OBJECT_ID('Individual_Order'))
    DROP INDEX idx_IndividualOrder_OrderDate ON Individual_Order;
GO


-- Non-clustered index: Customer.LastName
CREATE NONCLUSTERED INDEX idx_Customer_LastName ON Customer(LastName);
-- Non-clustered index: Product.Category
CREATE NONCLUSTERED INDEX idx_Product_Category ON Product(Category);
-- Non-clustered index: Individual_Order.OrderDate
CREATE NONCLUSTERED INDEX idx_IndividualOrder_OrderDate ON Individual_Order(OrderDate);


-- View index information
EXEC sp_helpindex 'Customer';
EXEC sp_helpindex 'Product';
EXEC sp_helpindex 'Individual_Order';

-- Testing non-clustered indexes
SELECT * FROM Customer WHERE LastName = 'Smith';
SELECT * FROM Product WHERE Category = 'Electronics';
SELECT * FROM Individual_Order WHERE OrderDate = '2024-03-08';

SELECT CustomerID, FirstName, LastName, Email
FROM Customer
ORDER BY LastName;

SELECT IO.OrderID, IO.OrderDate, C.FirstName, C.LastName, IO.TotalAmount
FROM Individual_Order IO
INNER JOIN Customer C ON IO.CustomerID = C.CustomerID
WHERE C.LastName = 'Smith';
