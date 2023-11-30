FROM debian:bullseye

RUN apt-get update && apt-get upgrade
RUN apt-get install -y redis-server

COPY ./conf/redis.conf /etc/redis/redis.conf
RUN chmod +x /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]