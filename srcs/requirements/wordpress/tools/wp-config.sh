#!/bin/bash

# If the site has not been configured
if [[ ! -f wp-config.php ]]; then

# Function to generate the salts from the WordPress API
generate_salts() {
    curl -s https://api.wordpress.org/secret-key/1.1/salt/
}

# Generate salts
SALTS=$(generate_salts)

# This file can be made with wp-cli but requires additional installation of mysql for some reason
# Create the wp-config.php file
cat > wp-config.php << EOL
<?php
define( 'DB_NAME', '${PHP_CONTAINER}' );
define( 'DB_USER', '${USER}' );
define( 'DB_PASSWORD', '${DATABASE_PASSWORD}' );
define( 'DB_HOST', '${DATABASE_CONTAINER}' );
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
# Change permissions for wp-config.php
chmod +x wp-config.php

# Create admin user, set title and domain
until wp core install --url=https://${USER}.${DOMAIN} --title=INCEPTION --admin_user=root --admin_password=${DATABASE_ROOT_PASSWORD} --admin_email=root@${DOMAIN} --allow-root; do
    sleep 1
    echo "Attempting connection to database."
done
# create non-admin user
wp user create $USER $USER@$DOMAIN --role=author --user_pass=$DATABASE_PASSWORD --allow-root
fi

# Run php-fpm in foreground
# !Hardcoded latest php version
exec /usr/sbin/php-fpm8.2 -F -R
