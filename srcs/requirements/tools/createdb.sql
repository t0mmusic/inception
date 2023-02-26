CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON WordPress.* TO 'user'@'localhost';
FLUSH PRIVILEGES;