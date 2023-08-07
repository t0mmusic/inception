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
    curl \
    sendmail

# RUN mkdir /run/php/
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
COPY ./conf/wp-config.sh /var/www/html/wp-config.sh
RUN chmod +x /var/www/html/wp-config.sh

# Exposing port 9000 sets port container will listen on
# This will only work in conjunction with docker run -p instruction
# Or when explicitly referenced in docker-compose
EXPOSE 9000

WORKDIR /var/www/html/
ENTRYPOINT [ "/var/www/html/wp-config.sh" ]
CMD [ "/usr/sbin/php-fpm8.2" "-F" "-R" ]