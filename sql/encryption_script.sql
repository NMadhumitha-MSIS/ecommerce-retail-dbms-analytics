USE G;
GO

IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'DAMGSymmetricKey')
BEGIN
    BEGIN TRY
        CLOSE SYMMETRIC KEY DAMGSymmetricKey;
    END TRY
    BEGIN CATCH
    END CATCH
    DROP SYMMETRIC KEY DAMGSymmetricKey;
END;
GO
IF EXISTS (SELECT * FROM sys.certificates WHERE name = 'DAMGCertificate')
BEGIN
    DROP CERTIFICATE DAMGCertificate;
END;
GO
IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    DROP MASTER KEY;
END;
GO

-- Create a master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DAMG6210Group9';
GO
-- Create a certificate
CREATE CERTIFICATE DAMGCertificate
WITH SUBJECT = 'Certificate for column encryption';
GO
-- Create a symmetric key
CREATE SYMMETRIC KEY DAMGSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE DAMGCertificate;
GO


-- -- Modify the Customer table to add a new column for storing encrypted phone numbers
-- Uncomment this section to add the EncryptedPhoneNumber column
ALTER TABLE Customer
ADD EncryptedPhoneNumber VARBINARY(MAX);
GO

-- Now open the key before encrypting
OPEN SYMMETRIC KEY DAMGSymmetricKey DECRYPTION BY CERTIFICATE DAMGCertificate;

-- Update the EncryptedPhoneNumber column
UPDATE Customer
SET EncryptedPhoneNumber = EncryptByKey(KEY_GUID('DAMGSymmetricKey'), CAST(PhoneNumber AS NVARCHAR(20)))
WHERE PhoneNumber IS NOT NULL;

-- Close the symmetric key
CLOSE SYMMETRIC KEY DAMGSymmetricKey;
GO

-- Query the results
-- Test the encryption

SELECT 
    CustomerID,
    Email,
    EncryptedPhoneNumber
FROM Customer;
GO

OPEN SYMMETRIC KEY DAMGSymmetricKey DECRYPTION BY CERTIFICATE DAMGCertificate;
SELECT 
    CustomerID,
    Email,
    CONVERT(VARCHAR(20), DecryptByKey(EncryptedPhoneNumber)) AS DecryptedPhoneNumber
FROM Customer;
CLOSE SYMMETRIC KEY DAMGSymmetricKey;
