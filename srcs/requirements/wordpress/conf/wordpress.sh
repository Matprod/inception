#!/bin/bash

# Check if WordPress is already installed
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	# Create the wp-config.php file
	wp config create --allow-root --dbname="$DB_NAME" --dbuser="$DB_USERNAME" --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb:3306" --path="/var/www/html/wordpress"

    # Installer WordPress
	wp core install --allow-root --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USERNAME" \
		--admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_MAIL" --path="/var/www/html/wordpress"
fi

# Démarrer le serveur php-fpm
/usr/sbin/php-fpm7.4 -F