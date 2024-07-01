use spotify;

 -- Inicio Transação
START TRANSACTION;

-- Identificar os itens a serem excluidos
SELECT * FROM PLAYLIST
 WHERE playlist_id IN (160,161);

-- Deleção dos itens	
DELETE FROM PLAYLIST 
 WHERE playlist_id IN (160,161);

-- Verificar se intens foram excluidos
SELECT * FROM PLAYLIST 
 WHERE playlist_id IN (160,161);

ROLLBACK;

-- Identificar se itens retornaram
SELECT * FROM PLAYLIST  
 WHERE playlist_id IN (160,161);

COMMIT;

-- Inserção de usuarios na tabela user

START TRANSACTION;

INSERT INTO USER VALUES (null,'Ana Silva','ana.silva@email.com','free', '1985-01-02');
INSERT INTO USER VALUES (null,'João Pereira','joao.pereira@email.com','premium', '1990-03-04');
INSERT INTO USER VALUES (null,'Maria Oliveira','maria.oliveira@email.com','regular', '1975-05-06');
INSERT INTO USER VALUES (null,'Pedro Souza','pedro.souza@email.com','regular', '2000-07-08');
SAVEPOINT insercao_parte1;
INSERT INTO USER VALUES (null,'Clara Santos','clara.santos@email.com','premium','1988-09-10');
INSERT INTO USER VALUES (null,'Bruno Mendes','bruno.mendes@email.com	','free', '1995-11-12');
INSERT INTO USER VALUES (null,'Diana Costa','diana.costa@email.com','free', '2005-12-14');
INSERT INTO USER VALUES (null,'Ricardo Gomes','ricardo.gomes@email.com','regular', '1992-01-16');
SAVEPOINT insercao_parte2;

-- RELEASE SAVEPOINT insercao_parte1;

COMMIT;

select * from user;