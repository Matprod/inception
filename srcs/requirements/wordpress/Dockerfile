# Let's start from the debian image
FROM	debian:bullseye

# Install all the requirements for wordpress
RUN	apt-get update
RUN	apt-get install -y wget\
	php7.4\
	php7.4-fpm\
	php7.4-mysql\
	mariadb-client

ARG DB_NAME
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DOMAIN_NAME
ARG WP_TITLE
ARG WP_ADMIN_USERNAME
ARG WP_ADMIN_PASSWORD
ARG WP_ADMIN_MAIL
ARG WP_USER_USERNAME
ARG WP_USER_PASSWORD
ARG WP_USER_MAIL
ARG WP_USER_DISPLAY_NAME

ENV DB_NAME ${DB_NAME}
ENV DB_USERNAME ${DB_USERNAME}
ENV DB_PASSWORD ${DB_PASSWORD}
ENV DOMAIN_NAME ${DOMAIN_NAME}
ENV WP_TITLE ${WP_TITLE}
ENV WP_ADMIN_USERNAME ${WP_ADMIN_USERNAME}
ENV WP_ADMIN_PASSWORD ${WP_ADMIN_PASSWORD}
ENV WP_ADMIN_MAIL ${WP_ADMIN_MAIL}
ENV WP_USER_USERNAME ${WP_USER_USERNAME}
ENV WP_USER_PASSWORD ${WP_USER_PASSWORD}
ENV WP_USER_MAIL ${WP_USER_MAIL}
ENV WP_USER_DISPLAY_NAME ${WP_USER_DISPLAY_NAME}

# Download wordpress
RUN wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www/html/ && \
	cd /var/www/html && tar -xvf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz && \
	chown -R www-data:www-data /var/www/html/wordpress

# Download wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O wp && \
	chmod +x wp && \
	mv wp /usr/local/bin/wp

# Config
COPY	./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create a run file to stock the temporary files from php
RUN	mkdir -p /run/php

# Copy the script to start the services
COPY	conf/wordpress.sh ./
RUN		chmod +x wordpress.sh

RUN chown -R www-data:www-data /var/www/html && \
	chmod -R 755 /var/www/html

# Expose the port 9000
EXPOSE	9000

CMD	["bash", "wordpress.sh"]