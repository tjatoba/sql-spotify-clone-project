START TRANSACTION;

-- Criação das tabelas - Spotify

CREATE SCHEMA Spotify;

use spotify;

CREATE TABLE IF NOT EXISTS user (
	user_ID INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(30),
    user_email VARCHAR(50),
    user_type VARCHAR(30),
    date_birth DATE,
    PRIMARY KEY(user_ID) 
    );
    
CREATE TABLE IF NOT EXISTS genre (
    genre_ID INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(50),
    PRIMARY KEY(genre_ID)
    );
    
	CREATE TABLE IF NOT EXISTS songs (
	song_ID INT NOT NULL AUTO_INCREMENT,
    song_name VARCHAR(100),
    duration TIME,
    genre_id INT,
    artist_id INT,
    record_label VARCHAR(50),
    PRIMARY KEY(song_ID),
	FOREIGN KEY (genre_ID) REFERENCES genre(genre_ID)
    );
    
    CREATE TABLE IF NOT EXISTS artists (
	artist_ID INT NOT NULL AUTO_INCREMENT,
    genre_ID INT,
    artist_name VARCHAR(100),
    song_ID INT,
    country VARCHAR(30),
    PRIMARY KEY(artist_ID),
    FOREIGN KEY (song_ID) REFERENCES songs(song_ID),
    FOREIGN KEY (genre_ID) REFERENCES genre(genre_ID)
    );
    
ALTER TABLE songs
ADD CONSTRAINT artist_idsongsgenre
FOREIGN KEY (artist_id) REFERENCES artists(artist_id);
    
CREATE TABLE IF NOT EXISTS playlist (
	playlist_ID INT NOT NULL AUTO_INCREMENT,
    user_ID INT,
    artist_ID INT,
	song_ID INT,
    genre_ID INT,
    playlist_name VARCHAR(40),
     PRIMARY KEY(playlist_ID),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID),
    FOREIGN KEY (artist_ID) REFERENCES artists(artist_ID),
    FOREIGN KEY (song_ID) REFERENCES songs(song_ID),
    FOREIGN KEY (genre_ID) REFERENCES genre(genre_ID)
    );    
    
    CREATE TABLE IF NOT EXISTS plays (
    plays_ID INT NOT NULL AUTO_INCREMENT,
    user_ID INT,
    genre_ID INT,
    song_ID INT,
    artist_ID INT,
    playlist_ID INT,
    time_play TIME,
    Date_play DATE,
    PRIMARY KEY(plays_ID),
    FOREIGN KEY (genre_ID) REFERENCES genre(genre_ID),
    FOREIGN KEY (song_ID) REFERENCES songs(song_ID),
    FOREIGN KEY (artist_ID) REFERENCES artists(artist_ID),
    FOREIGN KEY (playlist_ID) REFERENCES playlist(playlist_ID),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID)
);

UPDATE artists AS a
JOIN songs AS s ON a.artist_ID = s.artist_id
SET a.song_ID = s.song_ID;

UPDATE plays
JOIN playlist ON plays.song_ID = playlist.song_ID
SET plays.playlist_ID = playlist.playlist_ID;

COMMIT;
