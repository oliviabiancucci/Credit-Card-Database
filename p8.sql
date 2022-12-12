CREATE OR REPLACE FUNCTION p8(vendNum varchar(4), accountNum varchar(4), transAmount numeric)
RETURNS VOID
AS $$

	DECLARE
		transNum numeric(4);
		newTransNum varchar(4);
		transDate date;
		currAccountNum numeric;
		currVendNum numeric;

		custName varchar(25);
		custProvince varchar(25);
		custBalance numeric;
		custLimit numeric;

	BEGIN
		PERFORM Account
		FROM customer
		WHERE Account = accountNum;

		IF FOUND THEN

		PERFORM Vno
		FROM vendor
		WHERE Vno = vendNum;

		IF FOUND THEN

		transDate := CAST(NOW() AS date);

		SELECT MAX(CAST(RIGHT(Tno, 1) AS numeric))
		INTO transNum
		FROM transaction;

		transNum := transNum + 1;
		
		SELECT CONCAT('T', CAST(transNum as varchar(4)))
		INTO newTransNum;

		INSERT INTO transaction VALUES 
		(newTransNum, vendNum, accountNum, transDate, transAmount);

		UPDATE customer
		SET Cbalance = Cbalance + transAmount
		WHERE Account = accountNum;

		UPDATE vendor
		SET Vbalance = Vbalance + transAmount
		WHERE Vno = vendNum;

		raise notice '';
		raise notice '~~~ New Transaction ~~~';
		raise notice 'Transaction Number: %', transNum;
		raise notice 'Vendor No: %', vendNum;
		raise notice 'Account No: %', accountNum;
		raise notice 'Transaction Date: %', transDate;
		raise notice 'Amount: %', transAmount;

		SELECT Cname, Province, Cbalance, Crlimit
		INTO custName, custProvince, custBalance, custLimit
		FROM customer
		WHERE Account = accountNum;

		raise notice '';
		raise notice '~~~ Customer Record ~~~';
		raise notice 'Account No: %', accountNum;
		raise notice 'Customer Name: %', custName;
		raise notice 'Province: %', custProvince;
		raise notice 'Customer Balance: %', custBalance;
		raise notice 'Credit Limit: %', custLimit;

		raise notice '';
		raise notice '~~~ Vendor Record ~~~';
		raise notice 'Transaction No: %', newTransNum;
		raise notice 'Vendor No: %', vendNum;
		raise notice 'Account No: %', accountNum;
		raise notice 'Transaction Date: %', transDate;
		raise notice 'Amount: %', transAmount;


		END IF;
		END IF;
	END; $$
	
	LANGUAGE 'plpgsql';