FROM debian:buster

# Update the package lists and install required dependencies
RUN apt-get update && apt-get upgrade && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-xml \
    php-mbstring \
    php-imagick \
    curl

RUN mkdir /run/php/

COPY ./conf/php.conf /etc/php/7.3/fpm/pool.d/wordpress_pool.conf

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp


# Change working directory to the local mounted volume
# WORKDIR /var/www/html/

# Create new wordpress website
COPY ./conf/wp-config.sh /wp-config.sh
RUN chmod +x /wp-config.sh
ENTRYPOINT ["/wp-config.sh"]

# Exposing port 9000 sets port container will listen on
# This will only work in conjunction with docker run -p instruction
# Or when explicitly referenced in docker-compose
EXPOSE 9000
# Start PHP-FPM service
CMD ["/usr/sbin/php-fpm7.3", "-F", "-R"]
