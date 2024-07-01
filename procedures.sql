START TRANSACTION;

use spotify;

-- SP para ordenar uma tabela:
DELIMITER //
CREATE PROCEDURE sp_order_table(
IN table_Name VARCHAR(50), 
IN order_Field VARCHAR(50), 
IN sort_Order VARCHAR(10))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', table_Name, ' ORDER BY ', order_Field, ' ', sort_Order, ';');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;


-- Basta inserir o nome da tabela, a coluna a ser ordenada e como ordená-la
-- EX ordenando a tabela artists, pelo nome do artista de forma crescente
call sp_order_table('artists','artist_name','ASC');


-- SP para inserir novos usuários:
DELIMITER //
CREATE PROCEDURE sp_new_user(
    IN userID INT,
    IN userName VARCHAR(30),
    IN userEmail VARCHAR(50),
    IN userType VARCHAR(30),
    IN userBirth DATE
)
BEGIN
    IF userID IS NULL THEN
        -- Insere sem userID para permitir auto-incremento
        INSERT INTO user (user_name, user_email, user_type, date_birth)
        VALUES (userName, userEmail, userType, userBirth);
    ELSE
        -- Insere com o userID fornecido
        INSERT INTO user (user_ID, user_name, user_email, user_type, date_birth)
        VALUES (userID, userName, userEmail, userType, userBirth);
    END IF;
END //

DELIMITER ;

-- Basta inserir o novo ID, nome do usuario, tipo de conta e data de nascimento
-- EX Inserindo um novo usuario Joao
CALL sp_new_user(null,'João', 'joao@example.com', 'Regular', '1990-05-16');

select * from user;

COMMIT;