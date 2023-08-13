FROM debian:bookworm

RUN apt-get update && apt-get install -y mysql-common mariadb-server

# Copy custom configuration file
COPY conf/my.conf /etc/mysql/my.cnf
RUN chmod 600 /etc/mysql/my.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Set up the entry point script
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Start MariaDB service
# Superceded by ENTRYPOINT script but informative
CMD ["mysqld", "--user=mysql", "--console"]
