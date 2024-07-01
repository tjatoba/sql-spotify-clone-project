START TRANSACTION;

use spotify;

-- Visualizacao de musicas, ID e artistas
CREATE OR REPLACE VIEW musicas AS
SELECT s.song_ID, s.song_name AS song_Name, a.artist_name
FROM songs s
JOIN artists a ON s.artist_id = a.artist_ID;

SELECT * FROM musicas;

-- Visualizacao de gravadoras por artistas
CREATE OR REPLACE VIEW gravadoras AS
SELECT a.artist_name, s.record_label
FROM songs s
JOIN artists a ON s.artist_id = a.artist_ID;

-- Visualizacao de generos das musicas
CREATE OR REPLACE VIEW generos AS
SELECT s.song_ID, s.song_name AS song_Name, g.genre_name
FROM songs s
JOIN genre g ON s.genre_id = g.genre_ID;

-- Visualizacao de cadastro dos usuários
CREATE OR REPLACE VIEW cadastro_users AS
SELECT user_name, user_email, user_type
FROM user;

-- Visualizacao de playlists por usuários
CREATE OR REPLACE VIEW playlist_users AS
SELECT DISTINCT u.user_name, p.playlist_name
FROM user u
JOIN playlist p ON u.user_ID = p.user_ID;

COMMIT;