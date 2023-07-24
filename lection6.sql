-- SET
SET @test := 5;
SELECT @test;

-- SELECT
SELECT @test_var := 50;

-- IF
SELECT IF(400<2000, "YES", "NO");

-- PROCEDURE
CREATE PROCEDURE books (IN num INT) 
BEGIN
	DECLARE i INT DEFAULT 0;
    IF (NUM>0)
		WHILE (i<num DO)
			SELECT M.id, P.name, P.author, M.quantity
            FROM magazine_incoming M, products P
            WHERE M.product_id=P.id AND M.id=i;
            SET i= i+1;
		END WHILE;
    ELSE
		SELECT 'Задайте правильный параметр';
	END IF;
END;