CREATE OR REPLACE FUNCTION p6()
RETURNS VOID
AS $$

	DECLARE
		cur CURSOR FOR
		SELECT DISTINCT Vname, Vbalance, Vno
		FROM vendor
		ORDER BY Vno;

		vendName varchar(25);
		vendBalance numeric;
		vendNum varchar(4);
		feeCharged numeric;

	BEGIN
		OPEN cur;

		LOOP
			FETCH cur 
			INTO vendName, vendBalance, vendNum;
			EXIT WHEN NOT FOUND;

			SELECT vendBalance * 0.025
			INTO feeCharged
			FROM vendor
			WHERE Vno = vendNum;

			UPDATE 	vendor
			SET 	Vbalance = Vbalance - feeCharged
			WHERE	Vno = vendNum; 
			
			raise notice '';
			raise notice 'Vendor Name: %', vendName;
			raise notice 'Fee Charged: %', feeCharged;
			raise notice 'New Balance: %', vendBalance - feeCharged;
			
		END LOOP;
		CLOSE cur;

	END; $$
	
	LANGUAGE 'plpgsql';