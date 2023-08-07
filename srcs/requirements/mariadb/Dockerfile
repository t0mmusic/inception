FROM debian:bookworm

RUN apt-get update && apt-get install -y mysql-common mariadb-server

# Copy custom configuration files, if any
COPY conf/my.cnf /etc/mysql/my.cnf
RUN chmod 600 /etc/mysql/my.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Set up the entry point script
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Start MariaDB service
CMD ["mysqld", "--user=mysql", "--console"]