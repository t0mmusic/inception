FROM debian:bookworm

RUN apt-get update && apt-get upgrade
RUN apt-get install -y wget php php-mysql php-pdo

# Download and install Adminer
RUN mkdir /adminer && \
    wget -O /adminer/index.php https://www.adminer.org/latest.php

# Expose port
EXPOSE 8080

# Start a simple PHP server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/adminer"]