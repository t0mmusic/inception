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

# Copy .conf file to required directory
COPY ./conf/php.conf /wordpress_pool.conf
RUN cd /etc/php/*/fpm/pool.d/ && cp /wordpress_pool.conf .

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Create new wordpress website
RUN cd /var/www \
    && wp core download --allow-root --path=html

# Copy ENTRYPOINT script
COPY ./tools/wp-config.sh /var/www/html/wp-config.sh
RUN chmod +x /var/www/html/wp-config.sh

# Copy wordpress posts to volume
RUN mkdir /var/www/html/posts/
COPY ./conf/posts/* /var/www/html/posts/
RUN chmod +x /var/www/html/posts/*

WORKDIR /var/www/html/
ENTRYPOINT [ "/var/www/html/wp-config.sh" ]

# Superceded by ENTRYPOINT script but informative
CMD [ "/usr/sbin/php-fpm*" "-F" "-R" ]
