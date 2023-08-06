#!/bin/bash


if [[ ! -f wp-config.php ]]; then

# Function to generate the salts from the WordPress API
generate_salts() {
    curl -s https://api.wordpress.org/secret-key/1.1/salt/
}

# Generate salts
SALTS=$(generate_salts)

# Create the wp-config.php file
cat > wp-config.php << EOL
<?php
define( 'DB_NAME', '${MYSQL_DATABASE}' );
define( 'DB_USER', '${MYSQL_USER}' );
define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
define( 'DB_HOST', '${MYSQL_HOSTNAME}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

${SALTS}

\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';

EOL

chmod +x wp-config.php

echo "wp-config.php created successfully!"
sleep 5 
wp core install --url=${WORDPRESS_URL} --title=INCEPTION --admin_user=${MYSQL_USER} --admin_password=${MYSQL_PASSWORD} --admin_email=${WORDPRESS_EMAIL} --allow-root
fi


exec /usr/sbin/php-fpm7.3 -F -R