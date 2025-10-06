FROM	debian:bullseye

RUN	apt-get update
RUN	apt-get install -y nginx
RUN    apt-get install -y openssl

# SSL Part
RUN	mkdir /etc/nginx/ssl
RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/mvoisin.crt \
       -keyout /etc/nginx/ssl/mvoisin.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=mvoisin/CN=mvoisin.42.fr/"

COPY	./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN	mkdir -p /run/nginx

EXPOSE	443

CMD	["nginx", "-g", "daemon off;"]