service mysql start && \
mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${DB_ADMIN_PASSWORD}'; FLUSH PRIVILEGES;" && \
mysql -uroot -p${DB_ADMIN_PASSWORD} -e "CREATE DATABASE wordpress; \
CREATE USER '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}'; \
GRANT ALL ON wordpress.* TO '${DB_USERNAME}'@'%'; \
FLUSH PRIVILEGES;"