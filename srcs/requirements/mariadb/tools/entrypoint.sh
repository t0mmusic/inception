#!/bin/bash

# Start the MariaDB service
service mysql start

# Wait for the MariaDB service to be ready
until mysqladmin ping -h localhost -u root --password=$MYSQL_ROOT_PASSWORD --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Create a new database for WordPress
mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS wordpress;"

# Create a new user and grant privileges for the WordPress database
mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY '$MYSQL_WORDPRESS_PASSWORD';"
mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service
service mysql stop

# Start the MySQL service in the foreground
exec /usr/sbin/mysqld --user=mysql --console