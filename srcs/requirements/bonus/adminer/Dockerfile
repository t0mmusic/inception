FROM debian:bookworm

RUN apt-get update && apt-get upgrade
RUN apt-get install -y wget php php-mysql php-pdo

# Download and install Adminer
RUN mkdir /adminer
RUN wget -O /index.php https://www.adminer.org/latest.php
COPY ./tools/adminer-copy.sh /adminer-copy.sh

ENTRYPOINT [ "/adminer-copy.sh" ]

# Start a simple PHP server
CMD ["php", "-S", "0.0.0.0:9001", "-t", "/adminer/adminer"]