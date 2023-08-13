#!/bin/bash

# If the db exists, don't try to create it again
if [ ! -d "/var/lib/mysql/wordpress" ]; then
# Start the MariaDB service
service mariadb start

# Wait for the MariaDB service to be ready
until mysqladmin ping -h localhost -u root --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

echo "Creating Database"
    mysql -h localhost -u root -e "DELETE FROM mysql.db WHERE Db='test';"
    mysql -h localhost -u root -e "CREATE DATABASE ${PHP_CONTAINER} CHARACTER SET utf8 COLLATE utf8_general_ci;"
    # Create a new user and grant privileges for the WordPress database
    mysql -h localhost -u root -e "CREATE USER '${USER}'@'%' IDENTIFIED by '${DATABASE_PASSWORD}';"
    mysql -h localhost -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${USER}'@'%';"
    mysql -h localhost -u root -e "FLUSH PRIVILEGES;"
    # root password set, now required to access db
    mysql -h localhost -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';"
echo "Database created"
# Stop the MariaDB services
mysqladmin -u root -p$DATABASE_ROOT_PASSWORD shutdown
fi

# Start the MySQL service in the foreground
exec mysqld_safe #/usr/sbin/mysqld --user=root --console
