CREATE OR REPLACE FUNCTION p4()
RETURNS VOID
AS $$

	DECLARE
		cur CURSOR FOR
			SELECT DISTINCT Account
			FROM customer
			ORDER BY Account;

		customerAcc varchar(4);
		customername varchar(25);
		transAmount numeric;
		vendName varchar(25);

	BEGIN
		OPEN cur;

		LOOP
			FETCH cur 
			INTO customerAcc;
			EXIT WHEN NOT FOUND;

			PERFORM  * 
			FROM transaction
			WHERE transaction.Account = customerAcc;

			IF NOT FOUND THEN
				raise notice 'no transaction for the account: %', customerAcc;
				raise notice '';
			ELSE
				SELECT  Cname, Amount, Vname
				INTO	customerName, transAmount, vendName
                FROM    customer NATURAL JOIN vendor NATURAL JOIN transaction
                WHERE   transaction.Account = customerAcc AND transaction.Vno = vendor.Vno AND
                    	transaction.T_date =( SELECT MAX(T_date) FROM transaction WHERE transaction.Account = customerAcc);

				raise notice 'Account Number: %', customerAcc;
				raise notice 'Customer Name: %', customerName;
				raise notice 'Transaction Amount: %', transAmount;
				raise notice 'Vendor Name: %', vendName;
				raise notice '';
			END IF;
		END LOOP;
		CLOSE cur;
	END; $$
	
	LANGUAGE 'plpgsql';