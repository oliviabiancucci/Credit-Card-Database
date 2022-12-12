CREATE OR REPLACE FUNCTION p1(custName varchar) 
RETURNS table(vendName varchar(25), transDate date, transAmount numeric) 
AS $$

DECLARE
        vendName varchar(25);
        transDate date;
        transAmount numeric;
    BEGIN
       	RETURN QUERY 
		SELECT vendor.Vname, transaction.T_date, transaction.Amount
        FROM vendor JOIN transaction ON vendor.Vno = transaction.Vno JOIN customer ON customer.Account = transaction.Account
        WHERE customer.Cname = custName;
    END; $$
LANGUAGE 'plpgsql';