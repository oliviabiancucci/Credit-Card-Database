CREATE OR REPLACE FUNCTION p3(newAccount varchar(4), newName varchar(25), newProvince varchar(25), newLimit numeric)
RETURNS VOID
AS $$

BEGIN
	INSERT INTO customer VALUES 
	(newAccount, newName, newProvince, 0, newLimit);
END; $$

LANGUAGE 'plpgsql';
