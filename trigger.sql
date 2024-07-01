START TRANSACTION;

-- 1º Trigger 
-- Triggers para registrar adição de usuario na tabela user

use spotify;

--  Criação tabela para registro das informações, tabela será usada para registrar insert e update.
Create table new_update_user(
user_id int,
user_name varchar(30),
user_email varchar(50),
user_type varchar(30),
date_birth date,
reference_date date,
reference_time time,
user varchar(50),
Action Varchar(30)
);

-- Criação da Trigger
CREATE TRIGGER add_new_user
AFTER INSERT ON spotify.user
FOR EACH ROW
INSERT INTO spotify.new_update_user
VALUES (new.user_id ,new.user_name,new.user_email,new.user_type,new.date_birth,current_date(),current_time(),user(),'NEW USER');

-- Insert de novo usuario na tabela user
INSERT INTO spotify.user
Values (null,' Rodrigo Cavallini' , 'cavallini@gmail.com', 'Premium', '1981-10-21');

-- Select na tabela para verificar se registro foi inserido com sucesso
SELECT * from new_update_user;

-- Criação trigger para registrar update de usuario da tabela user
CREATE TRIGGER update_user
BEFORE UPDATE ON spotify.user
FOR EACH ROW
INSERT INTO spotify.new_update_user
VALUES (OLD.user_id ,OLD.user_name,OLD.user_email,OLD.user_type,OLD.date_birth,current_date(),current_time(),user(),'UPDATE');

-- Update do registro
UPDATE spotify.user
SET user_email = 'rodrigo@gmail.com'
WHERE user_name = 'cavallini@gmail.com';

-- Verificação na tabela de registro 
SELECT * from new_update_user;

-- 2º trigger
-- Criação tabela para registro das informações, tabela será usada para registrar insert e update. 

Create table new_playlist(
playlist_id int,
user_id int,
artist_id int,
song_id int,
genre_id int,
playlist_name Varchar(40),
reference_date date,
reference_time time,
user varchar(50)
);

-- Criação da Trigger
CREATE TRIGGER add_new_playlist
AFTER INSERT ON spotify.playlist	
FOR EACH ROW
INSERT INTO spotify.new_playlist
VALUES (new.playlist_id ,new.user_id,new.artist_id,new.song_id,new.genre_id,new.playlist_name,current_date(),current_time(),user());

-- Insert de novo usuario na tabela playlist
INSERT INTO spotify.playlist
Values (null, null , null , 1234567, 2 , 'HIP HOP');

-- Select na tabela para verificar se registro foi inserido com sucesso
SELECT * from new_playlist;

-- Criação tabela para registro do update
Create table update_playlist(
playlist_id int,
user_id int,
artist_id int,
song_id int,
genre_id int,
old_playlist_name Varchar(40),
new_playlist_name Varchar(40),
reference_date date,
reference_time time,
user varchar(50)
);

-- Criação trigger para registrar update da playlist 
CREATE TRIGGER update_playlist
BEFORE UPDATE ON spotify.playlist
FOR EACH ROW
INSERT INTO spotify.update_playlist
VALUES (old.playlist_id ,old.user_id,old.artist_id,old.song_id,old.genre_id,old.playlist_name,new.playlist_name,current_date(),current_time(),user());

-- Update do registro
UPDATE spotify.playlist
SET playlist_name = 'HIP HOP 2025'
WHERE playlist_id = 103;

-- Select na tabela para verificar se registro foi inserido com sucesso
SELECT * from update_playlist;

COMMIT;