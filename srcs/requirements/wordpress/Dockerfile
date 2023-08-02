FROM debian:buster

# Update the package lists and install required dependencies
RUN apt-get update && apt-get upgrade && apt-get install -y \
    wget \
    unzip \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-xml \
    php-mbstring \
    php-imagick

RUN mkdir /run/php/

COPY ./conf/php.conf /etc/php/7.3/fpm/pool.d/wordpress_pool.conf

# Change working directory to the local mounted volume
WORKDIR /var/www

# Download and extract WordPress
# TODO don't download if files already present
# use wordpress cli?
RUN wget -O wordpress.zip https://wordpress.org/latest.zip \
    && unzip wordpress.zip \
	  && cp -rf wordpress/* . \
    && rm -rf wordpress/ wordpress.zip

# Set ownership and permissions for WordPress directory
RUN chown -R www-data:www-data . \
    && find . -type d -exec chmod 755 {} \; \
    && find . -type f -exec chmod 644 {} \;

# Exposing port 9000 sets port container will listen on
# This will only work in conjunction with docker run -p instruction
# Or when explicitly referenced in docker-compose
EXPOSE 9000
# Start PHP-FPM service
CMD ["/usr/sbin/php-fpm7.3", "-F", "-R"]
