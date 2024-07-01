START TRANSACTION;

use Spotify;

-- Criação dos usuários
CREATE USER 'readonly_user'@'localhost';
CREATE USER 'readwrite_user'@'localhost';

-- Concessão de permissões
GRANT SELECT ON Spotify.* TO 'readonly_user'@'localhost'; #apenas leitura s/ deleção
GRANT SELECT, INSERT, UPDATE ON Spotify.* TO 'readwrite_user'@'localhost'; #leitura e escrita s/ deleleção

-- Aplicar as permissões
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'readonly_user'@'localhost';

COMMIT;