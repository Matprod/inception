FROM mariadb:10.11

# Install necessary packages
RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# Copy custom configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy initialization scripts
COPY tools/init.sql /docker-entrypoint-initdb.d/init.sql

# Set proper permissions
RUN chown -R mysql:mysql /var/lib/mysql

# Create necessary directories
RUN mkdir -p /var/lib/mysql \
    && mkdir -p /var/log/mysql \
    && mkdir -p /etc/mysql/conf.d

# Expose port 3306
EXPOSE 3306

# Use the official MariaDB entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
