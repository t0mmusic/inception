#!/bin/bash

if [ ! -d "/var/www/html/wp-config.php" ]; then
wp core download --allow-root

# Function to generate the salts from the WordPress API
generate_salts() {
    curl -s https://api.wordpress.org/secret-key/1.1/salt/
}

# Generate salts
SALTS=$(generate_salts)

# Create the wp-config.php file
cat > wp-config.php <<EOL
<?php
define( 'DB_NAME', '${MYSQL_DATABASE}' );
define( 'DB_USER', '${MYSQL_USER}' );
define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
define( 'DB_HOST', '${MYSQL_HOSTNAME}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

${SALTS}

$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';

EOL

cat wp-config.php

echo "wp-config.php created successfully!"
fi