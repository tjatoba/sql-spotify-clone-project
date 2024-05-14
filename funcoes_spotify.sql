-- codigo funcao 
-- GENREID = 1 A 30
-- traz genero musica

CREATE FUNCTION get_genre (genreid INT) RETURNS varchar(50)
    DETERMINISTIC
BEGIN
    DECLARE nome_genre VARCHAR(50);
    SELECT genre_name into nome_genre FROM genre WHERE genre_id = genreid;
    RETURN @nome_genre;
END;

-- Traz genero da musica sem fazer join
SELECT song_name ,record_label,genre_id, GET_GENRE(GENRE_ID)AS GENERO 
FROM SONGs
order by 3; 

-- funcao 2

CREATE DEFINER=`root`@`localhost` FUNCTION `get_played_song_names`(user_id INT) RETURNS varchar(1000) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE played_songs VARCHAR(1000);
    
    SELECT GROUP_CONCAT(s.song_name SEPARATOR '\n')
    INTO played_songs
    FROM plays p
    INNER JOIN songs s ON p.song_ID = s.song_ID
    WHERE p.user_ID = user_id;

    RETURN played_songs;
END;

select get_played_song_names(1234) as Musica_Tocada; -- id_user , traz a musica ouvida pela usuario.