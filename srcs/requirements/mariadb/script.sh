service mysql start && mysqladmin -u root password ${DB_ADMIN_PASSWORD}
service mysql start \
    && mysql -uroot -p${DB_ADMIN_PASSWORD} -e "CREATE DATABASE wordpress; \
    CREATE USER '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}'; \
    GRANT ALL ON wordpress.* TO '${DB_USERNAME}'@'%'; \
    FLUSH PRIVILEGES;"