DROP DATABASE IF EXISTS test;
Create Database IF NOT EXISTS test;
USE test;

DELIMITER //
DROP FUNCTION IF EXISTS Greater_Func;
CREATE FUNCTION Greater_Func()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE A INT DEFAULT 10;
    DECLARE B INT DEFAULT 50;
    DECLARE C INT DEFAULT 20;
    DECLARE greatest INT;
    IF A >= B AND A >= C THEN SET greatest = A;
    ELSEIF B >= A AND B >= C THEN SET greatest = B;
    ELSE SET greatest = C;
    END IF;
    RETURN greatest;
END//

DROP PROCEDURE IF EXISTS Welcome_Loop_Proc;
CREATE PROCEDURE Welcome_Loop_Proc()
BEGIN
    -- FIX: Build one string to prevent "Commands out of sync" error
    DECLARE counter INT DEFAULT 0;
    DECLARE result_message VARCHAR(2000) DEFAULT '';
    WHILE counter < 20 DO
        SET result_message = CONCAT(result_message, 'Welcome to MySQL Programming (from Exp14 Proc)\n');
        SET counter = counter + 1;
    END WHILE;
    SELECT result_message AS 'Message';
END//

DROP FUNCTION IF EXISTS Factorial_Func;
CREATE FUNCTION Factorial_Func()
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE N INT DEFAULT 6;
    DECLARE result BIGINT DEFAULT 1;
    DECLARE i INT DEFAULT 1;
    WHILE i <= N DO
        SET result = result * i;
        SET i = i + 1;
    END WHILE;
    RETURN result;
END//

DROP PROCEDURE IF EXISTS Generate_Fibonacci_Proc;
CREATE PROCEDURE Generate_Fibonacci_Proc()
BEGIN
    DECLARE N INT DEFAULT 12;
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE temp INT;
    DECLARE i INT DEFAULT 0;
    DECLARE series_str VARCHAR(1000) DEFAULT '';
    IF N > 0 THEN
        WHILE i < N DO
            SET series_str = CONCAT(series_str, a, ' ');
            SET temp = a + b;
            SET a = b;
            SET b = temp;
            SET i = i + 1;
        END WHILE;
    END IF;
    SELECT series_str AS 'Exp14_Fibonacci_Series';
END//

DROP FUNCTION IF EXISTS Sum_N_Func;
CREATE FUNCTION Sum_N_Func()
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE N INT DEFAULT 50;
    DECLARE sum_val BIGINT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    WHILE i <= N DO
        SET sum_val = sum_val + i;
        SET i = i + 1;
    END WHILE;
    RETURN sum_val;
END//

DELIMITER ;
CALL Welcome_Loop_Proc();
CALL Generate_Fibonacci_Proc();
SELECT Greater_Func() AS 'Exp14_Greatest_Result';
SELECT Factorial_Func() AS 'Exp14_Factorial_Result';
SELECT Sum_N_Func() AS 'Exp14_Sum_Result';