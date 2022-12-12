CREATE OR REPLACE FUNCTION p5()
RETURNS VOID
AS $$

	DECLARE
		cur CURSOR FOR
		SELECT DISTINCT Vno, Vname, Vbalance
		FROM vendor
		ORDER BY Vno;

		vendBalance numeric;
		newBalance numeric;
		vendNum varchar(4);
		vendName varchar(25);

	BEGIN
		OPEN cur;

		LOOP
			FETCH cur 
			INTO vendNum, vendName, vendBalance;
			EXIT WHEN NOT FOUND;

			SELECT COALESCE(SUM(Amount), 0)
			INTO newBalance
			FROM transaction
			WHERE transaction.Vno = vendNum;

			UPDATE 	vendor
			SET 	Vbalance = Vbalance + newBalance
			WHERE	Vno = vendNum; 
			
			raise notice '';
			raise notice 'Vendor No: %', vendNum;
			raise notice 'Vendor Name: %', vendName;
			raise notice 'New Balance: %', vendBalance + newBalance;
			
		END LOOP;
		CLOSE cur;

	END; $$
	
	LANGUAGE 'plpgsql';