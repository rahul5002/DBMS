CREATE DATABASE IF NOT EXISTS test;
USE test;

DELIMITER //

DROP PROCEDURE IF EXISTS Greater;
CREATE PROCEDURE Greater()
BEGIN
    DECLARE A INT DEFAULT 10;
    DECLARE B INT DEFAULT 50;
    DECLARE C INT DEFAULT 20;
    DECLARE result VARCHAR(100);

    IF A >= B AND A >= C THEN
        SET result = CONCAT(A, ' is the greatest.');
    ELSEIF B >= A AND B >= C THEN
        SET result = CONCAT(B, ' is the greatest.');
    ELSE
        SET result = CONCAT(C, ' is the greatest.');
    END IF;
    SELECT result AS 'Greatest_Number_Result';
END//

DROP PROCEDURE IF EXISTS Welcome_Loop;
CREATE PROCEDURE Welcome_Loop()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE result_text TEXT DEFAULT ''; 

    WHILE counter < 20 DO
        SET result_text = CONCAT(result_text, 'Welcome to MySQL Programming\n');
        SET counter = counter + 1;
    END WHILE;

    SELECT result_text AS 'Message';
END//

DROP PROCEDURE IF EXISTS Factorial;
CREATE PROCEDURE Factorial()
BEGIN
    DECLARE N INT DEFAULT 5;
    DECLARE result BIGINT DEFAULT 1;
    DECLARE i INT DEFAULT 1;
    WHILE i <= N DO
        SET result = result * i;
        SET i = i + 1;
    END WHILE;
    SELECT CONCAT('Factorial of ', N, ' is: ', result) AS 'Factorial_Result';
END//

DROP PROCEDURE IF EXISTS Fibonacci;
CREATE PROCEDURE Fibonacci()
BEGIN
    DECLARE N INT DEFAULT 10;
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
    SELECT series_str AS 'Fibonacci_Series';
END//

DROP PROCEDURE IF EXISTS Sum_First_N;
CREATE PROCEDURE Sum_First_N()
BEGIN
    DECLARE N INT DEFAULT 100;
    DECLARE sum_val BIGINT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    WHILE i <= N DO
        SET sum_val = sum_val + i;
        SET i = i + 1;
    END WHILE;
    SELECT CONCAT('Sum of first ', N, ' numbers is: ', sum_val) AS 'Exp13_Sum';
END//

DELIMITER ;
CALL Greater();
CALL Welcome_Loop();
CALL Factorial();
CALL Fibonacci();
CALL Sum_First_N();