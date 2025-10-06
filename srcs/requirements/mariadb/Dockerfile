FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

ARG DB_ADMIN_PASSWORD
ARG DB_USERNAME
ARG DB_PASSWORD

RUN service mariadb start && sleep 5 && \
    mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ADMIN_PASSWORD}'; FLUSH PRIVILEGES;" && \
    mysql -uroot -p${DB_ADMIN_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS wordpress; \
        CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}'; \
        GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USERNAME}'@'%'; \
        FLUSH PRIVILEGES;" && \
    mysqladmin -u root -p${DB_ADMIN_PASSWORD} shutdown

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]