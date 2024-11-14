#syntax=docker/dockerfile:1
FROM debian:11.11

RUN apt-get update && \
	apt-get -y install \
	php7.4-fpm \
	php7.4-mysqli \
	mariadb-client \
	curl \
	&& rm -rf /var/lib/apt/lists/*
#update
#install
#php-fpm is the FastCGI Process Manager for PHP
#php-mysqli is the MySQL AddOn Extension to interact with MySQL and maridb databases  
#mariadb-client is the client to interact with the mariadb server
#curl is a tool to transfer data from or to a server with URL syntax
#remove the package lists to reduce the docker image size

RUN mkdir -p /var/www/html && \
curl -fsSL https://packages.sury.org/php/README.txt | bash - && \
curl -sS https://wordpress.org/latest.tar.gz | tar xz -C /var/www/html --strip-components=1 && \
chown -R www-data:www-data /var/www/html && \
chmod -R 755 /var/www/html
#download the official version of Wordpress from the official website
#--strip-components=1 is used to extract the content of the archive in the /var/www/html directory
#give the execution rights to the file
#move the file to the /usr/local/bin/ directory to make it available anywhere in the container

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
#copy the www.conf file to the php-fpm configuration directory
#this file is used to configure the php-fpm POOL(group of processes)

COPY ./tools/wp-config.sh /usr/local/bin/wp-config.sh
RUN chmod +x /usr/local/bin/wp-config.sh
#copy the script that will configure the Wordpress
#give the execution rights to the script

EXPOSE 9000
#the default port of php-fpm must be open

WORKDIR /var/www/html
#working directory inside the container (all commands(RUN, CMD, ENTRYPOINT...) will be executed in this directory)

ENTRYPOINT ["bash" , "/usr/local/bin/wp-config.sh"]
#the script will be executed everytime the container starts
#bash is used to execute the script wp-config.sh