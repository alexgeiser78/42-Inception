#syntax=docker/dockerfile:1
FROM debian:bullseye

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

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp
#download the wp-cli.phar file which is the main file of the wp-cli tool which is a interface in command line to interact with WP
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