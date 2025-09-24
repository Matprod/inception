FROM wordpress:6.4-php8.2-fpm-alpine

# Install necessary packages
RUN apk update && apk add --no-cache \
    curl \
    bash \
    mysql-client

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy configurations
COPY conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY conf/wp-config.php /var/www/html/wp-config.php

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]