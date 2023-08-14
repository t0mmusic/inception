FROM debian:bookworm

# Update the package lists and install required dependencies
RUN apt-get update && apt-get upgrade
RUN apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-xml \
    php-mbstring \
    php-imagick \
    curl

RUN mkdir /var/www

# !Hardcoded latest php version
COPY ./conf/php.conf /etc/php/8.2/fpm/pool.d/wordpress_pool.conf

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Create new wordpress website
RUN cd /var/www \
    && wp core download --allow-root --path=html

# Copy script to generate wp-config.php
COPY ./tools/wp-config.sh /var/www/html/wp-config.sh
RUN chmod +x /var/www/html/wp-config.sh

COPY ./conf/lemp-post.html /var/www/html/lemp-post.html
RUN chmod +x /var/www/html/lemp-post.html

COPY ./conf/nginx-post.html /var/www/html/nginx-post.html
RUN chmod +x /var/www/html/nginx-post.html

COPY ./conf/mariadb-post.html /var/www/html/mariadb-post.html
RUN chmod +x /var/www/html/mariadb-post.html

COPY ./conf/php-post.html /var/www/html/php-post.html
RUN chmod +x /var/www/html/php-post.html

COPY ./conf/wordpress-post.html /var/www/html/wordpress-post.html
RUN chmod +x /var/www/html/wordpress-post.html

COPY ./conf/linux-post.html /var/www/html/linux-post.html
RUN chmod +x /var/www/html/linux-post.html

WORKDIR /var/www/html/
ENTRYPOINT [ "/var/www/html/wp-config.sh" ]

# Superceded by ENTRYPOINT script but informative
CMD [ "/usr/sbin/php-fpm*" "-F" "-R" ]
