START TRANSACTION;

use spotify;

-- CRIAÇÃO DAS FUNÇÕES

DELIMITER $$
USE `spotify`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_genre`(genreid INT) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE nome_genre VARCHAR(50);
    SELECT genre_name into nome_genre 
    FROM genre 
    WHERE genre_id = genreid;
    RETURN @nome_genre;
END;$$

DELIMITER ;

USE `spotify`;
DROP function IF EXISTS `spotify`.`get_played_song_names`;
;

DELIMITER $$
USE `spotify`$$
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
END;$$

DELIMITER ;
;

COMMIT;