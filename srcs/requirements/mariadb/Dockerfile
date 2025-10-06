# Let's start from the debian image
FROM debian:bullseye

# Install mariadb
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

ARG DB_ADMIN_PASSWORD
ARG DB_USERNAME
ARG DB_PASSWORD

# Initialiser MariaDB et configurer la sécurité
RUN service mariadb start && sleep 5 && \
    # Méthode correcte pour définir le mot de passe root dans MariaDB
    mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ADMIN_PASSWORD}'; FLUSH PRIVILEGES;" && \
    # Créer la base et l'utilisateur WordPress
    mysql -uroot -p${DB_ADMIN_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS wordpress; \
        CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}'; \
        GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USERNAME}'@'%'; \
        FLUSH PRIVILEGES;" && \
    # Arrêter MariaDB proprement
    mysqladmin -u root -p${DB_ADMIN_PASSWORD} shutdown

# Choose the port to listen
EXPOSE 3306

# Start mariadb
CMD ["mysqld", "--bind-address=0.0.0.0"]