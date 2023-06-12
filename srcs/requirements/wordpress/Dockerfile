FROM debian:buster

# Update the package lists and install required dependencies
RUN apt-get update && apt-get install -y \
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

WORKDIR /var/www/html
# Download and extract WordPress
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
# TODO: Make this always reflect the most recent version of php-fpm
CMD ["/usr/sbin/php-fpm7.3", "-F"]