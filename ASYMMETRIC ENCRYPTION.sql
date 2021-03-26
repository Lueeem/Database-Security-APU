CREATE ASYMMETRIC KEY asymkey1
WITH ALGORITHM = RSA_2048;

CREATE SYMMETRIC KEY symkey1
WITH ALGORITHM = AES_256
ENCRYPTION BY ASYMMETRIC KEY asymkey1;

OPEN SYMMETRIC KEY symkey1
DECRYPTION BY ASYMMETRIC KEY asymkey1;

ALTER TABLE Laboratory
ADD labObjective_encrypt varbinary(MAX)

UPDATE Laboratory
SET labObjective_encrypt = ENCRYPTBYKEY (
	KEY_GUID('symkey1'),
	labObjective
)
FROM Laboratory
GO

SELECT * FROM Laboratory;

SELECT CONVERT(varchar, DECRYPTBYKEY(labObjective_encrypt)) AS decrypted_labObjective FROM Laboratory