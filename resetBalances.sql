CREATE OR REPLACE FUNCTION reset()
RETURNS VOID
AS $$

	BEGIN

		UPDATE 	vendor
		SET 	Vbalance = 200.0
		WHERE	Vno = 'V1'; 

		UPDATE 	vendor
		SET 	Vbalance = 671.05
		WHERE	Vno = 'V2'; 

		UPDATE 	vendor
		SET 	Vbalance = 0.0
		WHERE	Vno = 'V3'; 
		
		UPDATE 	vendor
		SET 	Vbalance = 225.0
		WHERE	Vno = 'V4'; 

	END; $$
	
	LANGUAGE 'plpgsql';