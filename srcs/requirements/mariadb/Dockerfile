FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

# Copy custom configuration files, if any
COPY conf/my.cnf /etc/mysql/my.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Set up the entry point script
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Start MariaDB service
CMD ["mysqld", "--user=mysql", "--console"]