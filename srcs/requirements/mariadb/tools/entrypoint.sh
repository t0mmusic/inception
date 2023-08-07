#!/bin/bash

# Start the MariaDB service
service mariadb start

# Wait for the MariaDB service to be ready
until mysqladmin ping -h localhost -u root --password=$MYSQL_ROOT_PASSWORD --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# If the db exists, don't try to create it again
if [ ! -d "/var/lib/mysql/wordpress" ]; then
echo "Creating Database"
    mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test';"
    # root password set, now required to access db
    mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;"
    # Create a new user and grant privileges for the WordPress database
    mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';"
    mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';"
    mysql -h localhost -u root --password=$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
echo "Database created"
fi
# Stop the MariaDB services
service mariadb stop > /dev/null

echo "End"
# Start the MySQL service in the foreground
exec /usr/sbin/mysqld --user=mysql --console
