-- Creates a new database
-- CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- Creates user for database and grants all priviliges to user
CREATE USER 'jbrown'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON WordPress.* TO 'jbrown'@'localhost';
FLUSH PRIVILEGES;