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
# default wordpress setup
define( 'DB_NAME', '${PHP_CONTAINER}' );
define( 'DB_USER', '${USER}' );
define( 'DB_PASSWORD', '${DATABASE_PASSWORD}' );
define( 'DB_HOST', '${DATABASE_CONTAINER}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

# additional redis setup
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );

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

# Remove default wordpress post(s)
wp post delete --force $(wp post list --post_type=post --format=ids --allow-root) --allow-root
wp post delete --force $(wp post list --post_type=page --format=ids --allow-root) --allow-root

# Site Customistation
wp theme install generatepress --allow-root
wp theme activate generatepress --allow-root
wp option update blogdescription "We Need To Go Deeper." --allow-root
wp term create category "LEMP" --allow-root
wp term create category "Linux" --allow-root
wp term create category "Nginx" --allow-root
wp term create category "MariaDB" --allow-root
wp term create category "PHP" --allow-root
wp term create category "Wordpress" --allow-root

# Add custom posts to site
LEMP_POST_CONTENT=$(cat posts/lemp-post.html)
wp post create --post_type=post --post_title="LEMP" --post_content="$LEMP_POST_CONTENT" --post_category="LEMP,Linux,Nginx,MariaDB,PHP,Wordpress" --post_author=2 --post_status=publish --porcelain --allow-root
NGINX_POST_CONTENT=$(cat posts/nginx-post.html)
wp post create --post_type=post --post_title="Nginx" --post_content="$NGINX_POST_CONTENT" --post_category="Nginx" --post_author=2 --post_status=publish --porcelain --allow-root
MARIADB_POST_CONTENT=$(cat posts/mariadb-post.html)
wp post create --post_type=post --post_title="MariaDB" --post_content="$MARIADB_POST_CONTENT" --post_category="MariaDB" --post_author=2 --post_status=publish --porcelain --allow-root
PHP_POST_CONTENT=$(cat posts/php-post.html)
wp post create --post_type=post --post_title="PHP" --post_content="$PHP_POST_CONTENT" --post_category="PHP" --post_author=2 --post_status=publish --porcelain --allow-root
WORDPRESS_POST_CONTENT=$(cat posts/wordpress-post.html)
wp post create --post_type=post --post_title="Wordpress" --post_content="$WORDPRESS_POST_CONTENT" --post_category="Wordpress" --post_author=2 --post_status=publish --porcelain --allow-root
LINUX_POST_CONTENT=$(cat posts/linux-post.html)
wp post create --post_type=post --post_title="Linux" --post_content="$LINUX_POST_CONTENT" --post_category="Linux" --post_author=2 --post_status=publish --porcelain --allow-root

# Install redis plugin
wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root
fi

# Run php-fpm in foreground
exec /usr/sbin/php-fpm* -F -R
