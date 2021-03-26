CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'm@sterPassword123';

CREATE CERTIFICATE UmbrellaCertificate
WITH SUBJECT = 'Umbrella Pharmaceuticals';

CREATE SYMMETRIC KEY symmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE UmbrellaCertificate;

OPEN SYMMETRIC KEY symmetricKey
DECRYPTION BY CERTIFICATE UmbrellaCertificate;

ALTER TABLE Employee
ADD encrypt_employeePhoneNumber varbinary(MAX);

UPDATE Employee
SET encrypt_employeePhoneNumber = ENCRYPTBYKEY (
	Key_GUID('symmetricKey'),
	employeePhoneNumber
)
FROM Employee
GO

