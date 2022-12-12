CREATE OR REPLACE FUNCTION p7()
RETURNS VOID
AS $$

	DECLARE
		cur CURSOR FOR
		SELECT DISTINCT Account, Cname, Cbalance, Crlimit
		FROM customer
		ORDER BY Account;

		customerAccount varchar(4);
		customerName varchar(25);
		customerBalance numeric;
		creditLimit numeric;
		feeCharged numeric;

	BEGIN
		OPEN cur;

		LOOP
			FETCH cur 
			INTO customerAccount, customerName, customerBalance, creditLimit;
			EXIT WHEN NOT FOUND;

			IF creditLimit < customerBalance then
				feeCharged := customerBalance - creditLimit;
				feeCharged := feeCharged * 0.10;

				UPDATE 	customer
				SET 	Cbalance = customerBalance - feeCharged
				WHERE	Account = customerAccount; 
			
			raise notice '';
			raise notice 'Customer Name: %', customerName;
			raise notice 'New Balance: %', customerBalance - feeCharged;
			END IF;
			
		END LOOP;
		CLOSE cur;

	END; $$
	
	LANGUAGE 'plpgsql';