CREATE OR REPLACE FUNCTION p2(vendName varchar)
RETURNS table(Account varchar(4), customerName varchar(25), Province varchar(25))
AS $$

DECLARE
        Account varchar(4);
        customerName varchar(25);
        Province varchar(25);
    BEGIN
        RETURN QUERY
		SELECT customer.Account, customer.Cname, customer.Province
        FROM vendor JOIN transaction ON vendor.Vno = transaction.Vno JOIN customer ON customer.Account = transaction.Account
        WHERE vendor.Vname = vendName;
    END; $$

LANGUAGE 'plpgsql';

--esso doesnt work?